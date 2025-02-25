// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest

final class ResultTests: XCTestCase {
    func testSuccess() {
        switch succeed(value: 99) {
        case .success(let result):
            XCTAssertEqual(result, 99)
        case .failure:
            XCTFail()
        }

        do {
            let result = succeed(value: 1)
            let value = try result.get()
            XCTAssertEqual(value, 1)
        } catch {
            XCTFail()
        }
    }

    func testFailure() {
        switch fail() {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(type(of: error) == MyError.self)
        }

        do {
            let result = fail()
            print(try result.get())
            XCTFail()
        } catch {
            do {
                try handle(error: error)
                XCTFail()
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
