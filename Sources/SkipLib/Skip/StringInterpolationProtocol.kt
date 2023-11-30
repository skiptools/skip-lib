// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

interface StringInterpolationProtocol {
    //init(literalCapacity: Int, interpolationCount: Int)
    fun appendLiteral(literal: String)
    fun<T> appendInterpolation(value: T)
}

fun String(stringInterpolation: DefaultStringInterpolation): String {
    return stringInterpolation.values.joinToString("")
}

class DefaultStringInterpolation : StringInterpolationProtocol, CustomStringConvertible {
    var values: MutableList<String> = mutableListOf()

    constructor(literalCapacity: Int, interpolationCount: Int) {
    }

    override fun appendLiteral(literal: String) { 
        values.add(literal)
    }

    override fun<T> appendInterpolation(value: T) {
        values.add(value.toString())
    }
}

interface ExpressibleByUnicodeScalarLiteral {
    //associatedtype UnicodeScalarLiteralType : _ExpressibleByBuiltinUnicodeScalarLiteral
    //init(unicodeScalarLiteral value: Self.UnicodeScalarLiteralType)
}

interface ExpressibleByExtendedGraphemeClusterLiteral : ExpressibleByUnicodeScalarLiteral {
    //associatedtype ExtendedGraphemeClusterLiteralType : _ExpressibleByBuiltinExtendedGraphemeClusterLiteral
    //init(extendedGraphemeClusterLiteral value: Self.ExtendedGraphemeClusterLiteralType)
}

interface ExpressibleByStringLiteral : ExpressibleByExtendedGraphemeClusterLiteral {
    //associatedtype StringLiteralType : _ExpressibleByBuiltinStringLiteral
    //init(stringLiteral value: Self.StringLiteralType)
}

interface ExpressibleByStringInterpolation<StringInterpolation> : ExpressibleByStringLiteral where StringInterpolation : StringInterpolationProtocol {
}

//extension ExpressibleByStringInterpolation where Self.StringInterpolation == DefaultStringInterpolation {
    //public init(stringInterpolation: DefaultStringInterpolation) // An interface may not have a constructor
//}
