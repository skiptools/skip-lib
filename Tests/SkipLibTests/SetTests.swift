// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct SetTests {
    @Test func initialization() {
        let set1 = Set<Int>()
        #expect(set1.count == 0)

        let set2 = Set([1, 2, 3])
        #expect(set2.count == 3)

        #expect(set2.sorted().first == 1)
        #expect(set2.sorted().last == 3)
    }

    @Test func insert() {
        var set = Set<Int>()
        #expect(set.isEmpty)

        set.insert(1)
        #expect(set.count == 1)
        #expect(set.contains(1))

        set.insert(2)
        #expect(set.count == 2)
        #expect(set.contains(2))
    }

    @Test func remove() {
        var set = Set([1, 2, 3])
        #expect(set.count == 3)

        set.remove(2)
        #expect(set.count == 2)
        #expect(!set.contains(2))

        set.remove(4)
        #expect(set.count == 2)
    }

    @Test func union() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([3, 4, 5])
        let unionSet = set1.union(set2)

        #expect(unionSet.count == 5)
        #expect(unionSet.contains(1))
        #expect(unionSet.contains(2))
        #expect(unionSet.contains(3))
        #expect(unionSet.contains(4))
        #expect(unionSet.contains(5))
    }

    @Test func intersection() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3, 4])
        let intersectionSet = set1.intersection(set2)

        #expect(intersectionSet.count == 2)
        #expect(intersectionSet.contains(2))
        #expect(intersectionSet.contains(3))
    }

    @Test func symmetricDifference() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3, 4])
        let symmetricDifferenceSet = set1.symmetricDifference(set2)

        #expect(symmetricDifferenceSet.count == 2)
        #expect(symmetricDifferenceSet.contains(1))
        #expect(symmetricDifferenceSet.contains(4))
    }

    @Test func subsetSuperset() {
        #expect(Set([1, 3]).isSubset(of: Set([1, 2, 3])))
        #expect(Set([1, 2, 3]).isSubset(of: Set([1, 2, 3])))
        #expect(!Set([1, 2, 3, 4]).isSubset(of: Set([1, 2, 3])))

        let set1 = Set([1, 2, 3])
        let set2 = Set([2, 3])
        #expect(set2.isSubset(of: set1))
        #expect(set2.isStrictSubset(of: set1))
        #expect(set1.isSuperset(of: set2))
        #expect(set1.isStrictSuperset(of: set2))
        #expect(!set1.isDisjoint(with: set2))
        #expect(!set2.isDisjoint(with: set1))
    }

    @Test func isDisjoint() {
        let set1 = Set([1, 2, 3])
        let set2 = Set([4, 5, 6])
        #expect(set1.isDisjoint(with: set2))
    }

    @Test func popFirst() {
        var strings: Set<String> = ["A", "Z"]
        var popped: Set<String> = []
        popped.insert(strings.popFirst()!)
        popped.insert(strings.popFirst()!)
        #expect(Set(["A", "Z"]) == popped)
        #expect(strings.isEmpty)
        #expect(strings.popFirst() == nil)
    }

    @Test func customHashable() {
        let item = SetItem(name: "ABC", number: 12)
        var item2 = SetItem(name: "ABC", number: 12)
        let item3 = SetItem(name: "XYZ", number: 12)

        #expect(item != item3)

        #expect(item == item2)
        item2.number += 1
        #expect(item != item2)
        item2.number -= 1
        #expect(item == item2)

        #expect(Set([item]).contains(item))
        #expect(Set([item]).contains(item2))
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
