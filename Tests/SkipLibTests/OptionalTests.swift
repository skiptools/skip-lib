// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest

final class OptionalTests: XCTestCase {
    func testOptionalMap() {
        let memberMap = E.a.asNil(false).map { $0 == .a ? 1 : 2 }
        XCTAssertEqual(memberMap, 1)

        let memberMapNil = E.a.asNil(true).map { $0 == .a ? 1 : 2 }
        XCTAssertNil(memberMapNil)

        let funcMap = enumFactoryFunc(isNil: false).map { $0 == .a ? 1 : 2 }
        XCTAssertEqual(funcMap, 2)

        let funcMapNil = enumFactoryFunc(isNil: true).map { $0 == .a ? 1 : 2 }
        XCTAssertNil(funcMapNil)
    }
}

private enum E {
    case a
    case b

    func asNil(_ isNil: Bool) -> E? {
        return isNil ? nil : self
    }
}

private func enumFactoryFunc(isNil: Bool) -> E? {
    return isNil ? nil : .b
}
