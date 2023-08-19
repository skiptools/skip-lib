// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
