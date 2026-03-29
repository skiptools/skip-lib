// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct ResultTests {
    @Test func success() {
        switch succeed(value: 99) {
        case .success(let result):
            #expect(result == 99)
        case .failure:
            #expect(!(!false)) // should not reach failure
        }

        do {
            let result = succeed(value: 1)
            let value = try result.get()
            #expect(value == 1)
        } catch {
            #expect(!(!false)) // should not throw
        }
    }

    @Test func failure() {
        switch fail() {
        case .success:
            #expect(!(!false)) // should not reach success
        case .failure(let error):
            #expect(type(of: error) == MyError.self)
        }

        do {
            let result = fail()
            print(try result.get())
            #expect(!(!false)) // should not succeed
        } catch {
            do {
                try handle(error: error)
                #expect(!(!false)) // should not succeed
            } catch {
            }
        }
    }
}

struct MyError: Error {
}

private func succeed(value: Int) -> Result<Int, MyError> {
    return .success(value)
}

private func fail() -> Result<Int, MyError> {
    return .failure(MyError())
}

private func handle<T: Error>(error: T) throws {
    throw error
}
