// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
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
