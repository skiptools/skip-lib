// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

private struct TestOptionSet: OptionSet {
    let rawValue: Int

    static let s1 = TestOptionSet(rawValue: 1 << 0)
    static let s2 = TestOptionSet(rawValue: 1 << 1)
    static let s3 = TestOptionSet(rawValue: 1 << 2)

    static let all: TestOptionSet = [.s1, .s2, .s3]
}

struct TestUnsignedOptionSet: OptionSet {
    let rawValue: UInt

    static let s1 = TestUnsignedOptionSet(rawValue: UInt(1 << 0))
    static let s2 = TestUnsignedOptionSet(rawValue: UInt(1 << 1))
    static let s3 = TestUnsignedOptionSet(rawValue: UInt(1 << 2))

    static let all: TestUnsignedOptionSet = [.s1, .s2, .s3]
}

final class OptionSetTests: XCTestCase {
    func testContains() {
        let set: TestOptionSet = [.s1, .s3]
        XCTAssertTrue(set.contains(.s1))
        XCTAssertFalse(set.contains(.s2))
        XCTAssertTrue(set.contains(.s3))
        XCTAssertFalse(set.contains(.all))

        XCTAssertTrue(TestOptionSet.all.contains(.s1))
        XCTAssertTrue(TestOptionSet.all.contains(.s2))
        XCTAssertTrue(TestOptionSet.all.contains(.s3))
        XCTAssertTrue(TestOptionSet.all.contains(.all))
    }

    func testInsert() {
        var set: TestOptionSet = []
        XCTAssertFalse(set.contains(.s1))
        let (inserted, member) = set.insert(.s1)
        XCTAssertTrue(inserted)
        XCTAssertEqual(member, .s1)
        let (inserted2, member2) = set.insert(.s1)
        XCTAssertFalse(inserted2)
        XCTAssertEqual(member2, .s1)
        XCTAssertTrue(set.contains(.s1))

        XCTAssertFalse(set.contains(.s2))
        XCTAssertFalse(set.contains(.s3))
        let (insertedAll, memberAll) = set.insert(.all)
        XCTAssertTrue(insertedAll)
        XCTAssertEqual(memberAll, .all)
        XCTAssertTrue(set.contains(.s2))
        XCTAssertTrue(set.contains(.s3))
    }
}
