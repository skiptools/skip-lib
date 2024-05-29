// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

public struct String: RandomAccessCollection {
    public typealias Element = Character
    public typealias Index = Int

    public init() {
    }

    public init(_ string: String) {
    }

    public init(_ substring: Substring) {
    }

    public init(describing instance: Any?) {
    }

    public init(repeating: String, count: Int) {
    }

    public func lowercased() -> String {
        fatalError()
    }

    public func uppercased() -> String {
        fatalError()
    }

    public func hasPrefix(_ prefix: String) -> Bool {
        fatalError()
    }

    public func hasSuffix(_ suffix: String) -> Bool {
        fatalError()
    }

    public func contains(_ string: String) -> Bool {
        fatalError()
    }

    public func dropFirst(_ k: Int = 1) -> String {
        fatalError()
    }

    public func dropLast(_ k: Int = 1) -> String {
        fatalError()
    }

    public subscript(bounds: Range<Index>) -> Substring {
        fatalError()
    }

    // Support in String although it is not yet supported in Collection
    public func split(separator: Character, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [String] {
        fatalError()
    }

    public func matches(of r: Regex) -> [Regex.Match] {
        fatalError()
    }

    public func replacing(_ regex: Regex, with: String) -> String {
        fatalError()
    }
}

public struct Substring: RandomAccessCollection {
    public typealias Element = Character

    public func lowercased() -> String {
        fatalError()
    }
    
    public func uppercased() -> String {
        fatalError()
    }

    public func hasPrefix(_ prefix: String) -> Bool {
        fatalError()
    }

    public func hasSuffix(_ suffix: String) -> Bool {
        fatalError()
    }

    public func contains(_ string: String) -> Bool {
        fatalError()
    }

    public func dropFirst(_ k: Int = 1) -> String {
        fatalError()
    }

    public func dropLast(_ k: Int = 1) -> String {
        fatalError()
    }

    public func filter(_ isIncluded: (Character) throws -> Bool) rethrows -> String {
        fatalError()
    }

    public subscript(bounds: Range<Index>) -> Substring {
        fatalError()
    }

    // Support in String although it is not yet supported in Collection
    public func split(separator: Character, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [String] {
        fatalError()
    }
}

/// String(format:) constructor.
public func String(format: String, _ args: Any...) -> String {
    fatalError()
}

/// String(format:) constructor.
public func String(format: String, arguments: [Any]) -> String {
    fatalError()
}

public struct Character {
    public init(_ character: Character) {
    }

    public init(_ string: String) {
    }

    public var isASCII: Bool {
        fatalError()
    }

    public var asciiValue: UInt8? {
        fatalError()
    }

    public var isWhitespace: Bool {
        fatalError()
    }

    public var isNewline: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isNumber: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isWholeNumber: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var wholeNumberValue: Int? {
        fatalError()
    }

    @available(*, unavailable)
    public var isHexDigit: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var hexDigitValue: Int? {
        fatalError()
    }

    @available(*, unavailable)
    public var isLetter: Bool {
        fatalError()
    }

    public func uppercased() -> String {
        fatalError()
    }

    public func lowercased() -> String {
        fatalError()
    }

    @available(*, unavailable)
    public var isUppercase: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isLowercase: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isCased: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isSymbol: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isMathSymbol: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isCurrencySymbol: Bool {
        fatalError()
    }

    @available(*, unavailable)
    public var isPunctuation: Bool {
        fatalError()
    }
}

public typealias CChar = Character

public typealias StaticString = String

#endif
