// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct StructTests {
    @Test func structMutate() {
        var struct1a = Struct1(i: 2)
        struct1a.i += 1
        #expect(struct1a.i == 3)

        var struct1b = struct1a
        struct1b.i += 1
        #expect(struct1b.i == 4)
        #expect(struct1a.i == 3)
    }

    @Test func structMutateDidSet() {
        let holder = StructHolder()
        #expect(holder.structSetCount == 0)

        holder.struct1.i += 1
        #expect(holder.struct1.i == 1)
        #expect(holder.structSetCount == 1)

        var struct1 = holder.struct1
        #expect(struct1.i == 1)
        struct1.i += 1
        #expect(struct1.i == 2)
        #expect(holder.struct1.i == 1)
        #expect(holder.structSetCount == 1)

        holder.struct1.i += 2
        #expect(holder.struct1.i == 3)
        #expect(holder.structSetCount == 2)
        #expect(struct1.i == 2)
    }

    @Test func nestedStructDidSet() {
        let holder = StructHolder()
        holder.struct2.s1.i = 3
        #expect(holder.struct2.s1.i == 3)
        #expect(holder.structSetCount == 1)

        var struct2 = holder.struct2
        struct2.s1.i = 2
        #expect(holder.struct2.s1.i == 3)
        #expect(holder.structSetCount == 1)

        holder.struct2.s1.i = 1
        #expect(holder.struct2.s1.i == 1)
        #expect(holder.structSetCount == 2)
        #expect(struct2.s1.i == 2)
    }

    @Test func structReferences() {
        var struct1a = Struct1()
        struct1a.i += 1
        var struct1b = struct1a
        struct1b.i += 1
        var struct1c = struct1b
        struct1c.i += 1

        struct1a.i += 1

        #expect(struct1a.i == 2)
        #expect(struct1b.i == 2)
        #expect(struct1c.i == 3)
    }
}

private struct Struct1 {
    var i = 0
}

private struct Struct2 {
    var s1: Struct1 = Struct1()
}

private class StructHolder {
    var struct1: Struct1 = Struct1() {
        didSet {
            structSetCount += 1
        }
    }
    var struct2: Struct2 = Struct2() {
        didSet {
            structSetCount += 1
        }
    }
    var structSetCount = 0
}
