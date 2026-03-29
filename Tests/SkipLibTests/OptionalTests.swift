// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct OptionalTests {
    @Test func optionalMap() {
        let memberMap = E.a.asNil(false).map { $0 == .a ? 1 : 2 }
        #expect(memberMap == 1)

        let memberMapNil = E.a.asNil(true).map { $0 == .a ? 1 : 2 }
        #expect(memberMapNil == nil)

        let funcMap = enumFactoryFunc(isNil: false).map { $0 == .a ? 1 : 2 }
        #expect(funcMap == 2)

        let funcMapNil = enumFactoryFunc(isNil: true).map { $0 == .a ? 1 : 2 }
        #expect(funcMapNil == nil)
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
