// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct GlobalsTests {
    @Test func fatalError() throws {
        if ({ false }()) {
            Swift.fatalError("this is a fatal error")
        }

        if ({ false }()) {
            Swift.fatalError() // no-arg
        }
    }

    @Test func swap() {
        var a = 1
        var b = 2
        Swift.swap(&a, &b)
        #expect(2 == a)
        #expect(1 == b)
    }
}
