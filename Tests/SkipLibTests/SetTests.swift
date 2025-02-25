// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest

final class SetTests: XCTestCase {
    func testInit() {
        let set1 = Set<Int>()
        XCTAssertEqual(set1.count, 0)

        let set2 = Set([1, 2, 3])
        XCTAssertEqual(set2.count, 3)

        XCTAssertEqual(set2.sorted().first, 1)
        XCTAssertEqual(set2.sorted().last, 3)
    }

    func testInsert() {
        var set = Set<Int>()
        XCTAssertTrue(set.isEmpty)

        set.insert(1)
        XCTAssertEqual(set.count, 1)
        XCTAssertTrue(set.contains(1))

        set.insert(2)
        XCTAssertEqual(set.count, 2)
        XCTAssertTrue(set.contains(2))
    }

    func testRemove() {
        var set = Set([1, 2, 3])
        XCTAssertEqual(set.count, 3)

        set.remove(2)
        XCTAssertEqual(set.count, 2)
        XCTAssertFalse(set.contains(2))

        set.remove(4)
        XCTAssertEqual(set.count, 2)
    }

    func testUnion() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([3, 4, 5])
        let unionSet = set1.union(set2)

        XCTAssertEqual(unionSet.count, 5)
        XCTAssertTrue(unionSet.contains(1))
        XCTAssertTrue(unionSet.contains(2))
        XCTAssertTrue(unionSet.contains(3))
        XCTAssertTrue(unionSet.contains(4))
        XCTAssertTrue(unionSet.contains(5))
    }

    func testIntersection() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3, 4])
        let intersectionSet = set1.intersection(set2)

        XCTAssertEqual(intersectionSet.count, 2)
        XCTAssertTrue(intersectionSet.contains(2))
        XCTAssertTrue(intersectionSet.contains(3))
    }

    func testSymmetricDifference() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3, 4])
        let symmetricDifferenceSet = set1.symmetricDifference(set2)

        XCTAssertEqual(symmetricDifferenceSet.count, 2)
        XCTAssertTrue(symmetricDifferenceSet.contains(1))
        XCTAssertTrue(symmetricDifferenceSet.contains(4))
    }

    func testSubsetSuperset() {
        XCTAssertTrue(Set([1, 3]).isSubset(of: Set([1, 2, 3])))
        XCTAssertTrue(Set([1, 2, 3]).isSubset(of: Set([1, 2, 3])))
        XCTAssertFalse(Set([1, 2, 3, 4]).isSubset(of: Set([1, 2, 3])))

        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3])
        XCTAssertTrue(set2.isSubset(of: set1))
        XCTAssertTrue(set2.isStrictSubset(of: set1))
        XCTAssertTrue(set1.isSuperset(of: set2))
        XCTAssertTrue(set1.isStrictSuperset(of: set2))
        XCTAssertFalse(set1.isDisjoint(with: set2))
        XCTAssertFalse(set2.isDisjoint(with: set1))
    }

    func testIsDisjoint() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([4, 5, 6])
        XCTAssertTrue(set1.isDisjoint(with: set2))
    }

    func testPopFirst() {
        var strings: Set<String> = ["A", "Z"]
        var popped: Set<String> = []
        popped.insert(strings.popFirst()!)
        popped.insert(strings.popFirst()!)
        XCTAssertEqual(Set(["A", "Z"]), popped)
        XCTAssertTrue(strings.isEmpty)
        XCTAssertNil(strings.popFirst())
    }

    func testCustomHashable() {
        let item = SetItem(name: "ABC", number: 12)
        var item2 = SetItem(name: "ABC", number: 12)
        let item3 = SetItem(name: "XYZ", number: 12)

        XCTAssertNotEqual(item, item3)

        XCTAssertEqual(item, item2)
        item2.number += 1
        XCTAssertNotEqual(item, item2)
        item2.number -= 1
        XCTAssertEqual(item, item2)

        XCTAssertTrue(Set([item]).contains(item))
        XCTAssertTrue(Set([item]).contains(item2))
    }
}

struct SetItem : Hashable {
    let name: String
    var number: Int

    static func ==(lhs: SetItem, rhs: SetItem) -> Bool {
        return lhs.name == rhs.name && lhs.number == rhs.number
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(number)
    }
}
