// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest

final class GenericTests: XCTestCase {
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
