
// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class StringInterpolationTests: XCTestCase {
    func testDefaultStringInterpolation() {
        // “Do not call this initializer directly. It is used by the compiler when interpreting string interpolations.”
        var def = DefaultStringInterpolation(literalCapacity: 9, interpolationCount: 1)
        def.appendLiteral("Number ")
        def.appendInterpolation(1)
        def.appendLiteral("!")
        XCTAssertEqual("Number 1!", String(stringInterpolation: def))
    }

    func testManualStringInterpolation() {
        var str = StringInterpolationExample()
        str.appendLiteral("ABC")
        str.appendInterpolation(1)
        str.appendInterpolation(1.1)
        str.appendLiteral("XYZ")

        XCTAssertEqual(["ABC", "1", "1.1", "XYZ"], str.elements.map({ String(describing: $0) }))
    }

    func testAutomaticStringInterpolation() {
        XCTAssertEqual("A string and 1 thing", "A \("string") and \(1) \(Thing())")

        #if SKIP
        throw XCTSkip("TODO")
        #else
        XCTAssertEqual(#"["A ", "string", " and ", 1, " ", thing, ""]"#, intepolate("A \("string") and \(1) \(Thing())"))
        #endif
    }
}

struct Thing : CustomStringConvertible {
    var description: String { "thing" }
}

/// A simple function that demonstrates accepting a custom `ExpressibleByStringInterpolation` type
func intepolate(_ string: StringExpressibleExample) -> String {
    string.rawValue
}

struct StringExpressibleExample : ExpressibleByStringInterpolation {
    typealias StringInterpolation = StringInterpolationExample

    let rawValue: String

    init(stringInterpolation: StringInterpolation) {
        self.rawValue = stringInterpolation.elements.description
    }

    init(stringLiteral value: String) {
        self.rawValue = value
    }

    init(unicodeScalarLiteral value: String) {
        self.rawValue = value
    }

    init(extendedGraphemeClusterLiteral value: String) {
        self.rawValue = value
    }
}

struct StringInterpolationExample : StringInterpolationProtocol {
    var elements: [Any] = []

    init(literalCapacity: Int = 0, interpolationCount: Int = 0) {
    }

    mutating func appendLiteral(_ literal: String) {
        elements.append(literal)
    }

    mutating func appendInterpolation<T>(_ value: T) {
        elements.append(value as Any)
    }
}
