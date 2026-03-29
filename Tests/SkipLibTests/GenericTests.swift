// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct GenericTests {
}

struct GenericStruct<T: Any> {
    let t: T

    func doSomething() {
        // Ensures that our Kotlin-transpiled generics can be passed as Any if we have an Any constraint
        Self.doSomething(withAny: t)
    }

    static func doSomething(withAny a: Any) {
    }
}
