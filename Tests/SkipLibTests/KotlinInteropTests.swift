// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class KotlinInteropTests: XCTestCase {
    func testCustomKotlinConversion() throws {
#if SKIP
        XCTAssertTrue(CustomKotlinConverting().kotlin() is java.util.Date)
#endif
    }
}

private struct CustomKotlinConverting {
#if SKIP
    func kotlin(nocopy: Bool = false) -> java.util.Date {
        return java.util.Date()
    }
#endif
}
