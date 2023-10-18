// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

extension Int8: CustomStringConvertible {
    public static let max: Int8 = 0
    public static let min: Int8 = 0
    public var description: String { return "" }
}

extension Int16: CustomStringConvertible {
    public static let max: Int16 = 0
    public static let min: Int16 = 0
    public var description: String { return "" }
}

extension Int32: CustomStringConvertible {
    public static let max: Int32 = 0
    public static let min: Int32 = 0
    public var description: String { return "" }
}

extension Int: CustomStringConvertible {
    public static let max: Int = 0
    public static let min: Int = 0
    public var description: String { return "" }
}

extension Int64: CustomStringConvertible {
    public static let max: Int64 = 0
    public static let min: Int64 = 0
    public var description: String { return "" }
}

extension UInt8: CustomStringConvertible {
    public static let max: UInt8 = 0
    public static let min: UInt8 = 0
    public var description: String { return "" }
}

extension UInt16: CustomStringConvertible {
    public static let max: UInt16 = 0
    public static let min: UInt16 = 0
    public var description: String { return "" }
}

extension UInt32: CustomStringConvertible {
    public static let max: UInt32 = 0
    public static let min: UInt32 = 0
    public var description: String { return "" }
}

extension UInt: CustomStringConvertible {
    public static let max: UInt = 0
    public static let min: UInt = 0
    public var description: String { return "" }
}

extension UInt64: CustomStringConvertible {
    public static let max: UInt64 = 0
    public static let min: UInt64 = 0
    public var description: String { return "" }
}

extension Float: CustomStringConvertible {
    static let nan: Float = 0.0
    static let infinity: Float = 0.0
    static let pi: Float = 0.0
    public var description: String { return "" }
    public var isNaN: Bool { return false }
    public var isFinite: Bool { return false }
    public var isInfinite: Bool { return false }
}

extension Double: CustomStringConvertible {
    static let nan: Double = 0.0
    static let infinity: Double = 0.0
    static let pi: Double = 0.0
    public var description: String { return "" }
    public var isNaN: Bool { return false }
    public var isFinite: Bool { return false }
    public var isInfinite: Bool { return false }
}

public let M_E: Double = 0.0
public let M_LOG2E: Double = 0.0
public let M_LOG10E: Double = 0.0
public let M_LN2: Double = 0.0
public let M_LN10: Double = 0.0
public let M_PI: Double = 0.0

#endif
