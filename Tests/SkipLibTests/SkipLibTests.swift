// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest
#if !SKIP
@testable import SkipLib
#endif

final class SkipLibTests: XCTestCase {
    func testSkipLib() throws {
        XCTAssertEqual(3, 1 + 2)
        XCTAssertEqual("SkipLib", SkipLibInternalModuleName())
        XCTAssertEqual("SkipLib", SkipLibPublicModuleName())
    }

    func testUnitTests() throws {
        // test the various test assertions and ensure the JUnit implementations match the XCUnit ones
        XCTAssertEqual(1, 1)
        XCTAssertEqual(1, 1, "one == one")

        XCTAssertNotEqual(1, 2)
        XCTAssertNotEqual(1, 2, "one != two")

        XCTAssertGreaterThanOrEqual(1, 1)
        XCTAssertGreaterThanOrEqual(1, 1, "one >= one")

        XCTAssertGreaterThan(2, 1)
        XCTAssertGreaterThan(2, 1, "two > one")

        XCTAssertLessThanOrEqual(1, 1)
        XCTAssertLessThanOrEqual(1, 1, "one <= one")

        XCTAssertLessThan(1, 2)
        XCTAssertLessThan(1, 2, "one < two")
    }

    func testFatalError() throws {
        if ({ false }()) {
            fatalError("this is a fatal error")
        }

        if ({ false }()) {
            fatalError() // no-arg
        }
    }
}

#if !SKIP
public struct DemoStruct {
    public let publicInt: Int = 1
    private var privateOptionalString: String?
    private var impliedDouble = (1.234 * 1)
}
#endif
