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
        var str = StringExpressibleExample.StringInterpolation()
        str.appendLiteral("ABC")
        str.appendInterpolation(1)
        str.appendInterpolation(1.1)
        str.appendLiteral("XYZ")

        XCTAssertEqual(["ABC", "1", "1.1", "XYZ"], str.elements.map({ String(describing: $0) }))
    }

    func testAutomaticStringInterpolation() {
        XCTAssertEqual("string", intepolate("\("string")"))
        XCTAssertEqual("1", intepolate("\(1)"))
        XCTAssertEqual("A string and 1 thing", "A \("string") and \(1) \(Thing())")
        XCTAssertEqual("A string and 2 things", intepolate("A \("string") and \(2) \(Thing())s"))
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
    let rawValue: String

    init(stringInterpolation: StringInterpolation) {
        self.rawValue = stringInterpolation.elements.map({ String(describing: $0) }).joined(separator: "")
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

    typealias StringInterpolation = StringInterpolationExample

    /// An example implementation of StringInterpolationProtocol that merely stores the arguments as an `[Any]` array
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
}
