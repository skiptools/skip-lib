// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
