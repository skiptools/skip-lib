// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
#if !SKIP
import Foundation
#endif
import XCTest

@available(macOS 13, macCatalyst 16, iOS 16, tvOS 16, watchOS 8, *)
final class ConcurrencyTests: XCTestCase {
    func testSimpleValue() async throws {
        let task1 = Task {
            return await asyncInt()
        }
        let task2 = Task.detached {
            return await self.asyncInt2()
        }
        let value1 = await task1.value
        let value2 = await task2.value
        XCTAssertEqual(value1, 100)
        XCTAssertEqual(value2, 200)

        let value3 = await asyncInt()
        XCTAssertEqual(value3, 100)
    }

    func testThrowsException() async throws {
        let task = Task {
            let _ = await asyncInt()
            throw ConcurrencyTestsError()
        }
        do {
            let _ = try await task.value
            XCTFail("Should have thrown ConcurrencyTestsError")
        } catch {
            XCTAssertTrue(error is ConcurrencyTestsError)
        }
    }

    func testTaskCancelWithException() async throws {
        let task = Task {
            try await Task.sleep(nanoseconds: 100_000_000)
        }
        try await Task.sleep(nanoseconds: 1_000_000)
        task.cancel()
        do {
            let _ = try await task.value
            XCTFail("Expected cancellation error")
        } catch {
            // this has been seen to fail when running against the emulator on CI:
            // skip.lib.ConcurrencyTests > runtestTaskCancelWithException$SkipLib_debugAndroidTest[Pixel_3a_API_30(AVD) - 11] FAILED
            XCTAssertTrue(error is CancellationError, "expected CancellationError but got: \(error)")
        }
    }

    func testTaskCancelWithoutException() async throws {
        let task = Task {
            var i = 0
            while i < 10_000 {
                guard !Task.isCancelled else { break }
                let _ = await asyncInt() + asyncInt2()
                i += 1
            }
            return i
        }
        let aint = await asyncInt()
        XCTAssertEqual(aint, 100)
        task.cancel()
        let iterations = await task.value
        XCTAssertLessThan(iterations, 10_000)
    }

    static var taskIsCancelled = false

    func testTaskIsCancelled() async throws {
        Self.taskIsCancelled = false
        let task = Task {
            defer { Self.taskIsCancelled = Task.isCancelled }
            try await Task.sleep(nanoseconds: 10_000_000)
        }
        let _ = await asyncInt() + asyncInt2()
        task.cancel()
        do {
            let _ = try await task.value
            XCTFail("Expected cancellation error")
        } catch {
            XCTAssertTrue(Self.taskIsCancelled)
        }

        let task2 = Task {
            return Task.isCancelled
        }
        let task2Cancelled = await task2.value
        XCTAssertFalse(task2Cancelled)
    }

    func testAsyncLet() async throws {
        let start = currentTimeMillis()
        async let i1 = delayedInt(millis: 500)
        async let i2 = delayedInt(millis: 200)
        let sum = try await i1 + i2
        let end = currentTimeMillis()
        XCTAssertEqual(700, sum)
        // note that the timing assertion has been observed to fail under high load on the Android emulator; this is not unexpected
        XCTAssertLessThan(end - start, 700) 
    }

    func testAsyncSequence() async throws {
        let seq = AsyncIntSequence()
        var collected: [Int] = []
        for await i in seq {
            collected.append(i)
            if collected.count > 10 {
                break
            }
        }
        XCTAssertEqual(collected, [0, 100, 200])
    }

    func testMainActor() async throws {
        mainActorCount = 0
        let task1 = Task.detached {
            var numbers: Set<Int> = []
            for _ in 0..<100 {
                await numbers.insert(self.mainActorIncrement())
            }
            return numbers
        }
        let task2 = Task.detached {
            var numbers: Set<Int> = []
            for _ in 0..<100 {
                await numbers.insert(self.mainActorIncrement())
            }
            return numbers
        }
        let task3 = Task.detached {
            var numbers: Set<Int> = []
            for _ in 0..<100 {
                await numbers.insert(self.mainActorIncrement())
            }
            return numbers
        }
        let set1 = await task1.value
        let set2 = await task2.value
        let set3 = await task3.value

        // @MainActor should have forced exclusive access and prevented races
        let combined = set1.union(set2).union(set3)
        XCTAssertEqual(300, combined.count)
    }

    var mainActorCount = 0

    @MainActor func mainActorIncrement() -> Int {
        mainActorCount += 1
        return mainActorCount
    }

    func currentTimeMillis() -> Int {
        // We're below the level of SkipFoundation, so we don't have access to the transpiled Date API
        #if SKIP
        return Int(java.lang.System.currentTimeMillis())
        #else
        return Int(CFAbsoluteTimeGetCurrent() * 1000)
        #endif
    }

    func delayedInt(millis: Int) async throws -> Int {
        try await Task.sleep(nanoseconds: UInt64(1_000_000 * millis))
        return millis
    }

    func asyncInt() async -> Int {
        return 100
    }

    func asyncInt2() async -> Int {
        return 200
    }
}

struct ConcurrencyTestsError: Error {
}

struct AsyncIntSequence: AsyncSequence {
    typealias AsyncIterator = Iterator
    typealias Element = Int

    func makeAsyncIterator() -> Iterator {
        return Iterator()
    }

    class Iterator: AsyncIteratorProtocol {
        var iterations = 0

        func next() async -> Int? {
            guard iterations < 3 else {
                return nil
            }
            let result = iterations * 100
            iterations += 1
            return result
        }
    }
}
