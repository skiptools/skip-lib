// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

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

@Suite struct OptionSetTests {
    @Test func contains() {
        let set: TestOptionSet = [.s1, .s3]
        #expect(set.contains(.s1))
        #expect(!set.contains(.s2))
        #expect(set.contains(.s3))
        #expect(!set.contains(.all))

        #expect(TestOptionSet.all.contains(.s1))
        #expect(TestOptionSet.all.contains(.s2))
        #expect(TestOptionSet.all.contains(.s3))
        #expect(TestOptionSet.all.contains(.all))
    }

    @Test func insert() {
        var set: TestOptionSet = []
        #expect(!set.contains(.s1))
        let (inserted, member) = set.insert(.s1)
        #expect(inserted)
        #expect(member == .s1)
        let (inserted2, member2) = set.insert(.s1)
        #expect(!inserted2)
        #expect(member2 == .s1)
        #expect(set.contains(.s1))

        #expect(!set.contains(.s2))
        #expect(!set.contains(.s3))
        let (insertedAll, memberAll) = set.insert(.all)
        #expect(insertedAll)
        #expect(memberAll == .all)
        #expect(set.contains(.s2))
        #expect(set.contains(.s3))
    }
}
