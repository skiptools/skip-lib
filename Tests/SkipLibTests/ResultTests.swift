// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
