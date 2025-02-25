// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

extension Int8: CustomStringConvertible {
    public static let max: Int8 = 0
    public static let min: Int8 = 0
    public static func random(in range: Range<Int8>) -> Int8 { fatalError() }
    public static func random(in range: Range<Int8>, using gen: inout RandomNumberGenerator) -> Int8 { fatalError() }
    public var description: String { return "" }
}

extension Int16: CustomStringConvertible {
    public static let max: Int16 = 0
    public static let min: Int16 = 0
    public static func random(in range: Range<Int16>) -> Int16 { fatalError() }
    public static func random(in range: Range<Int16>, using gen: inout RandomNumberGenerator) -> Int16 { fatalError() }
    public var description: String { return "" }
}

extension Int32: CustomStringConvertible {
    public static let max: Int32 = 0
    public static let min: Int32 = 0
    public static func random(in range: Range<Int32>) -> Int32 { fatalError() }
    public static func random(in range: Range<Int32>, using gen: inout RandomNumberGenerator) -> Int32 { fatalError() }
    public var description: String { return "" }
}

extension Int: CustomStringConvertible {
    public static let max: Int = 0
    public static let min: Int = 0
    public static func random(in range: Range<Int>) -> Int { fatalError() }
    public static func random(in range: Range<Int>, using gen: inout RandomNumberGenerator) -> Int { fatalError() }
    public var description: String { return "" }
}

extension Int64: CustomStringConvertible {
    public static let max: Int64 = 0
    public static let min: Int64 = 0
    public static func random(in range: Range<Int64>) -> Int64 { fatalError() }
    public static func random(in range: Range<Int64>, using gen: inout RandomNumberGenerator) -> Int64 { fatalError() }
    public var description: String { return "" }
}

extension Int128: CustomStringConvertible {
    @available(*, unavailable)
    public static let max: Int128 = 0
    @available(*, unavailable)
    public static let min: Int128 = 0
    @available(*, unavailable)
    public static func random(in range: Range<Int128>) -> Int128 { fatalError() }
    @available(*, unavailable)
    public static func random(in range: Range<Int128>, using gen: inout RandomNumberGenerator) -> Int128 { fatalError() }
    public var description: String { return "" }
}

extension UInt8: CustomStringConvertible {
    public static let max: UInt8 = 0
    public static let min: UInt8 = 0
    public static func random(in range: Range<UInt8>) -> UInt8 { fatalError() }
    public static func random(in range: Range<UInt8>, using gen: inout RandomNumberGenerator) -> UInt8 { fatalError() }
    public var description: String { return "" }
}

extension UInt16: CustomStringConvertible {
    public static let max: UInt16 = 0
    public static let min: UInt16 = 0
    public static func random(in range: Range<UInt16>) -> UInt16 { fatalError() }
    public static func random(in range: Range<UInt16>, using gen: inout RandomNumberGenerator) -> UInt16 { fatalError() }
    public var description: String { return "" }
}

extension UInt32: CustomStringConvertible {
    public static let max: UInt32 = 0
    public static let min: UInt32 = 0
    public static func random(in range: Range<UInt32>) -> UInt32 { fatalError() }
    public static func random(in range: Range<UInt32>, using gen: inout RandomNumberGenerator) -> UInt32 { fatalError() }
    public var description: String { return "" }
}

extension UInt: CustomStringConvertible {
    public static let max: UInt = 0
    public static let min: UInt = 0
    public static func random(in range: Range<UInt>) -> UInt { fatalError() }
    public static func random(in range: Range<UInt>, using gen: inout RandomNumberGenerator) -> UInt { fatalError() }
    public var description: String { return "" }
}

extension UInt64: CustomStringConvertible {
    public static let max: UInt64 = 0
    public static let min: UInt64 = 0
    public static func random(in range: Range<UInt64>) -> UInt64 { fatalError() }
    public static func random(in range: Range<UInt64>, using gen: inout RandomNumberGenerator) -> UInt64 { fatalError() }
    public var description: String { return "" }
}

extension UInt128: CustomStringConvertible {
    @available(*, unavailable)
    public static let max: UInt128 = 0
    @available(*, unavailable)
    public static let min: UInt128 = 0
    @available(*, unavailable)
    public static func random(in range: Range<UInt128>) -> UInt128 { fatalError() }
    @available(*, unavailable)
    public static func random(in range: Range<UInt128>, using gen: inout RandomNumberGenerator) -> UInt128 { fatalError() }
    public var description: String { return "" }
}

extension Float: CustomStringConvertible {
    public static let nan: Float = 0.0
    public static let infinity: Float = 0.0
    public static let pi: Float = 0.0
    public var description: String { return "" }
    public var isNaN: Bool { return false }
    public var isFinite: Bool { return false }
    public var isInfinite: Bool { return false }
    public static func random(in range: Range<Float>) -> Float { fatalError() }
    @available(*, unavailable)
    public static func random(in range: Range<Float>, using gen: inout RandomNumberGenerator) -> Float { fatalError() }
    public func rounded() -> Float
    public func rounded(_ rule: FloatingPointRoundingRule) -> Float
}

extension Double: CustomStringConvertible {
    public static let nan: Double = 0.0
    public static let infinity: Double = 0.0
    public static let pi: Double = 0.0
    public var description: String { return "" }
    public var isNaN: Bool { return false }
    public var isFinite: Bool { return false }
    public var isInfinite: Bool { return false }
    public static func random(in range: Range<Double>) -> Double { fatalError() }
    @available(*, unavailable)
    public static func random(in range: Range<Double>, using gen: inout RandomNumberGenerator) -> Double { fatalError() }
    public func rounded() -> Double
    public func rounded(_ rule: FloatingPointRoundingRule) -> Double
}

public typealias BigInteger = java.math.BigInteger

public let M_E: Double = 0.0
public let M_LOG2E: Double = 0.0
public let M_LOG10E: Double = 0.0
public let M_LN2: Double = 0.0
public let M_LN10: Double = 0.0
public let M_PI: Double = 0.0

public let MSEC_PER_SEC = UInt64(0)
public let NSEC_PER_SEC = UInt64(0)
public let NSEC_PER_MSEC = UInt64(0)
public let USEC_PER_SEC = UInt64(0)
public let NSEC_PER_USEC = UInt64(0)

#endif
