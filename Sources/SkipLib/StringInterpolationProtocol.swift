// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

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
