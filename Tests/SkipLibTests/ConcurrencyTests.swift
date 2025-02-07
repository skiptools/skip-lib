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
            try await Task.sleep(nanoseconds: 100_000_000)
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

    func testTaskGroup() async throws {
        let results = try await withThrowingTaskGroup(of: Int.self) { group in
            group.addTask {
                return try await self.delayedInt(millis: 200)
            }
            group.addTask {
                return try await self.delayedInt(millis: 100)
            }
            group.addTask {
                return try await self.delayedInt(millis: 400)
            }
            var results: [Int] = []
            for try await result in group {
                results.append(result)
            }
            return results
        }
        // Wrap in Set for CI, where order isn't the same as we see locally
        XCTAssertEqual(Set(results), Set([100, 200, 400]))
    }

    func testThrowingTaskUncaught() async throws {
        do {
            let _ = try await withThrowingTaskGroup(of: Int.self) { group in
                group.addTask {
                    let _ = try await self.delayedInt(millis: 200)
                    throw ConcurrencyTestsError()
                }
                group.addTask {
                    return try await self.delayedInt(millis: 100)
                }
                group.addTask {
                    return try await self.delayedInt(millis: 400)
                }
                var results: [Int] = []
                for try await result in group {
                    results.append(result)
                }
                XCTFail()
                return results
            }
        } catch {
            XCTAssertTrue(error is ConcurrencyTestsError, "Caught wrong error type: \(error)")
        }
    }

    func testThrowingTaskGroupCaught() async throws {
        var caught: Error? = nil
        let results = try await withThrowingTaskGroup(of: Int.self) { group in
            group.addTask {
                let _ = try await self.delayedInt(millis: 200)
                throw ConcurrencyTestsError()
            }
            group.addTask {
                return try await self.delayedInt(millis: 100)
            }
            group.addTask {
                return try await self.delayedInt(millis: 400)
            }
            var results: [Int] = []
            do {
                for try await result in group {
                    results.append(result)
                }
            } catch {
                caught = error
            }
            for try await result in group {
                results.append(result)
            }
            return results
        }
        XCTAssertTrue(caught is ConcurrencyTestsError)
        XCTAssertEqual(results.count, 2)
    }

    func testTaskGroupCancel() async throws {
        throw XCTSkip("Failing in CI")
//        let result = try await withThrowingTaskGroup(of: Int.self) { group in
//            group.addTask {
//                return try await self.delayedInt(millis: 200)
//            }
//            group.addTask {
//                return try await self.delayedInt(millis: 100)
//            }
//            group.addTask {
//                return try await self.delayedInt(millis: 400)
//            }
//            let result = try await group.next()
//            XCTAssertNotNil(result)
//            group.cancelAll()
//            XCTAssertTrue(group.isCancelled)
//            do {
//                let _ = try await group.next()
//                XCTFail()
//            } catch is CancellationError {
//            }
//            return result ?? 0
//        }
//        XCTAssertNotEqual(result, 0)
    }

    func testAsyncLet() async throws {
        let start = currentTimeMillis()
        async let i1 = delayedInt(millis: 500)
        async let i2 = delayedInt(millis: 200)
        let sum = try await i1 + i2
        let end = currentTimeMillis()
        XCTAssertEqual(700, sum)
        // note that the timing assertion has been observed to fail under high load on both the Android emulator and iOS simulator; this is not unexpected
        //XCTAssertLessThan(end - start, 700)
    }

    func testAsyncSequence() async throws {
        let seq = AsyncIntSequence()
        var collected: [Int] = []
        for await i in seq {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, 100, 200])

        collected.removeAll()
        let mapped = seq.map { $0 * -1 }
        for await i in mapped {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, -100, -200])

        collected.removeAll()
        let compactMapped = seq.compactMap { $0 == 100 ? nil : $0 }
        for await i in compactMapped {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, 200])

        collected.removeAll()
        let flatMapped = seq.flatMap { _ in AsyncIntSequence() }
        for await i in flatMapped {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, 100, 200, 0, 100, 200, 0, 100, 200])

        collected.removeAll()
        let filtered = seq.filter { $0 == 100 }
        for await i in filtered {
            collected.append(i)
        }
        XCTAssertEqual(collected, [100])

        let first = await seq.first { $0 == 100 }
        XCTAssertEqual(first, 100)

        collected.removeAll()
        let dropped = seq.dropFirst()
        for await i in dropped {
            collected.append(i)
        }
        XCTAssertEqual(collected, [100, 200])

        collected.removeAll()
        let droppedAll = seq.dropFirst(10)
        for await i in droppedAll {
            collected.append(i)
        }
        XCTAssertEqual(collected, Array<Int>())

        collected.removeAll()
        let dropped2 = seq.drop { $0 != 100 }
        for await i in dropped2 {
            collected.append(i)
        }
        XCTAssertEqual(collected, [100, 200])

        collected.removeAll()
        let prefix = seq.prefix(2)
        for await i in prefix {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, 100])

        collected.removeAll()
        let prefixAll = seq.prefix(10)
        for await i in prefixAll {
            collected.append(i)
        }
        XCTAssertEqual(collected, [0, 100, 200])

        let min = await seq.min()
        XCTAssertEqual(min, 0)
        let min2 = await seq.min(by: >)
        XCTAssertEqual(min2, 200)

        let max = await seq.max()
        XCTAssertEqual(max, 200)
        let max2 = await seq.max(by: >)
        XCTAssertEqual(max2, 0)

        let contains = await seq.contains(100)
        XCTAssertTrue(contains)
        let contains2 = await seq.contains(300)
        XCTAssertFalse(contains2)
        let contains3 = await seq.contains { $0 == 100 }
        XCTAssertTrue(contains3)
        let contains4 = await seq.contains { $0 == 300 }
        XCTAssertFalse(contains4)

        let allSatisfy = await seq.allSatisfy { $0 >= 0 }
        XCTAssertTrue(allSatisfy)
        let allSatisfy2 = await seq.allSatisfy { $0 < 200 }
        XCTAssertFalse(allSatisfy2)

        let reduce = await seq.reduce(0, +)
        XCTAssertEqual(reduce, 300)
        var result = 0
        let reduce2 = await seq.reduce(into: result) { $0 += $1 }
        XCTAssertEqual(reduce2, 300)
    }

    func testAsyncStream() async throws {
        let (stream, continuation) = AsyncStream.makeStream(of: Int.self)
        continuation.yield(100)
        continuation.yield(200)
        continuation.finish()
        try await assertEqual(stream: stream, content: [100, 200])

        let (stream2, continuation2) = AsyncStream.makeStream(of: Int.self)
        Task {
            await continuation2.yield(asyncInt())
            await continuation2.yield(asyncInt2())
            continuation2.finish()
        }
        try await assertEqual(stream: stream2, content: [100, 200])

        var i = 0
        let stream3 = AsyncStream<Int>(unfolding: {
            i += 1
            if i == 1 {
                return await self.asyncInt()
            } else if i == 2 {
                return await self.asyncInt2()
            } else {
                return nil
            }
        })
        try await assertEqual(stream: stream3, content: [100, 200])

        #if SKIP
        let stream4 = AsyncStream(Int.self) { continuation in
            continuation.yield(100)
            continuation.yield(200)
            continuation.finish()
        }
        var flow = stream4.kotlin()
        var c = 0
        flow.collect { value in
            if c == 0 {
                XCTAssertEqual(value, 100)
            } else if c == 1 {
                XCTAssertEqual(value, 200)
            }
            c += 1
        }
        XCTAssertEqual(c, 2)

        i = 0
        let stream5 = AsyncStream<Int>(unfolding: {
            i += 1
            if i == 1 {
                return await self.asyncInt()
            } else if i == 2 {
                return await self.asyncInt2()
            } else {
                return nil
            }
        })
        flow = stream5.kotlin()
        c = 0
        flow.collect { value in
            if c == 0 {
                XCTAssertEqual(value, 100)
            } else if c == 1 {
                XCTAssertEqual(value, 200)
            }
            c += 1
        }
        XCTAssertEqual(c, 2)

        flow = kotlinx.coroutines.flow.flowOf(10, 20, 30)
        let stream6 = AsyncStream<Int>(flow: flow)
        try await assertEqual(stream: stream6, content: [10, 20, 30])
        #endif
    }

    private func assertEqual(stream: AsyncStream<Int>, content: [Int]) async throws {
        var i = 0
        for await value in stream {
            if i < content.count {
                XCTAssertEqual(value, content[i])
            }
            i += 1
        }
        XCTAssertEqual(i, content.count)
    }

    func testAsyncThrowingStream() async throws {
        let (stream, continuation) = AsyncThrowingStream.makeStream(of: Int.self)
        continuation.yield(100)
        continuation.yield(200)
        continuation.finish()
        try await assertEqual(stream: stream, content: [100, 200], shouldThrow: false)

        let (stream2, continuation2) = AsyncThrowingStream.makeStream(of: Int.self)
        Task {
            await continuation2.yield(asyncInt())
            await continuation2.yield(asyncInt2())
            continuation2.finish(throwing: ConcurrencyTestsError())
        }
        try await assertEqual(stream: stream2, content: [100, 200], shouldThrow: true)

        var i = 0
        let stream3 = AsyncThrowingStream<Int, Error>(unfolding: {
            i += 1
            if i == 1 {
                return await self.asyncInt()
            } else if i == 2 {
                return await self.asyncInt2()
            } else {
                throw ConcurrencyTestsError()
            }
        })
        try await assertEqual(stream: stream3, content: [100, 200], shouldThrow: true)

        #if SKIP
        let stream4 = AsyncThrowingStream(Int.self) { continuation in
            continuation.yield(100)
            continuation.yield(200)
            continuation.finish(throwing: ConcurrencyTestsError())
        }
        var flow = stream4.kotlin()
        var c = 0
        do {
            flow.collect { value in
                if c == 0 {
                    XCTAssertEqual(value, 100)
                } else if c == 1 {
                    XCTAssertEqual(value, 200)
                }
                c += 1
            }
            XCTFail("Should have thrown")
        } catch {
        }
        XCTAssertEqual(c, 2)

        i = 0
        let stream5 = AsyncStream<Int>(unfolding: {
            i += 1
            if i == 1 {
                return await self.asyncInt()
            } else if i == 2 {
                return await self.asyncInt2()
            } else {
                throw ConcurrencyTestsError()
            }
        })
        flow = stream5.kotlin()
        c = 0
        do {
            flow.collect { value in
                if c == 0 {
                    XCTAssertEqual(value, 100)
                } else if c == 1 {
                    XCTAssertEqual(value, 200)
                }
                c += 1
            }
            XCTFail("Should have thrown")
        } catch {
        }
        XCTAssertEqual(c, 2)

        flow = kotlinx.coroutines.flow.flowOf(10, 20, 30)
        let stream6 = AsyncThrowingStream<Int, Error>(flow: flow)
        try await assertEqual(stream: stream6, content: [10, 20, 30], shouldThrow: false)
        #endif
    }

    private func assertEqual(stream: AsyncThrowingStream<Int, Error>, content: [Int], shouldThrow: Bool) async throws {
        var i = 0
        do {
            for try await value in stream {
                if i < content.count {
                    XCTAssertEqual(value, content[i])
                }
                i += 1
            }
            if shouldThrow {
                XCTFail("Should have thrown")
            }
        } catch {
            XCTAssertTrue(shouldThrow)
        }
        XCTAssertEqual(i, content.count)
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

    func testWithCheckedContinuation() async throws {
        let i1 = await withCheckedContinuation(function: "testWithCheckedContinuation") { continuation in
            continuation.resume(returning: 100)
        }

        XCTAssertEqual(100, i1)

        let i2 = await withCheckedContinuation(function: "testWithCheckedContinuation") { continuation in
            Task.detached {
                continuation.resume(returning: 101)
            }
        }

        XCTAssertEqual(101, i2)

        let i3 = await withCheckedContinuation(function: "testWithCheckedContinuation") { continuation in
            Task.detached {
                Task {
                    Task.detached {
                        continuation.resume(returning: await self.asyncInt() + self.asyncInt2())
                    }
                }
            }
        }

        XCTAssertEqual(300, i3)
    }

    func testWithCheckedThrowingContinuation() async throws {
        do {
            let x: Int = try await withCheckedThrowingContinuation(function: "testWithCheckedThrowingContinuation") { continuation in
                Task.detached {
                    continuation.resume(throwing: ConcurrencyTestsError())
                }
            }
            XCTFail("should have thrown an error")
        } catch _ as ConcurrencyTestsError {
            // success
        } catch {
            XCTFail("wrong error thrown: \(error)")
        }
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
