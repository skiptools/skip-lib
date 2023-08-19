// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class GlobalsTests: XCTestCase {
    func testFatalError() throws {
        if ({ false }()) {
            fatalError("this is a fatal error")
        }

        if ({ false }()) {
            fatalError() // no-arg
        }
    }

    func testSwap() {
        var a = 1
        var b = 2
        swap(&a, &b)
        XCTAssertEqual(2, a)
        XCTAssertEqual(1, b)
    }
}
