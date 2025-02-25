// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

public protocol ExpressibleByUnicodeScalarLiteral {
    //associatedtype UnicodeScalarLiteralType : _ExpressibleByBuiltinUnicodeScalarLiteral
    //init(unicodeScalarLiteral value: Self.UnicodeScalarLiteralType)
}

public protocol ExpressibleByExtendedGraphemeClusterLiteral : ExpressibleByUnicodeScalarLiteral {
    //associatedtype ExtendedGraphemeClusterLiteralType : _ExpressibleByBuiltinExtendedGraphemeClusterLiteral
    //init(extendedGraphemeClusterLiteral value: Self.ExtendedGraphemeClusterLiteralType)
}

public protocol ExpressibleByStringLiteral : ExpressibleByExtendedGraphemeClusterLiteral {
    //associatedtype StringLiteralType : _ExpressibleByBuiltinStringLiteral
    //init(stringLiteral value: Self.StringLiteralType)
}

public protocol ExpressibleByStringInterpolation : ExpressibleByStringLiteral {
    associatedtype StringInterpolation : StringInterpolationProtocol // = DefaultStringInterpolation where Self.StringLiteralType == Self.StringInterpolation.StringLiteralType
    //init(stringInterpolation: Self.StringInterpolation)
}

extension ExpressibleByStringInterpolation where Self.StringInterpolation == DefaultStringInterpolation {
    //public init(stringInterpolation: DefaultStringInterpolation) // An interface may not have a constructor
}

public protocol StringInterpolationProtocol {
    //init(literalCapacity: Int, interpolationCount: Int)
    mutating func appendLiteral(_ literal: String)
    mutating func appendInterpolation<T>(_ value: T)
}

public struct DefaultStringInterpolation : StringInterpolationProtocol, Sendable {
    init(literalCapacity: Int = 0, interpolationCount: Int = 0) { }
    mutating func appendLiteral(_ literal: StaticString) { }
    mutating func appendInterpolation<T>(_ value: T) { }
}

#endif
