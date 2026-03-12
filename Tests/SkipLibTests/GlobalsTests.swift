// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
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
