// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if SKIP
public protocol RandomNumberGenerator {
    func next() -> UInt64
}

public struct SystemRandomNumberGenerator : RawRepresentable, RandomNumberGenerator {
    public let rawValue: java.security.SecureRandom

    public init(rawValue: java.security.SecureRandom = java.security.SecureRandom()) {
        self.rawValue = rawValue
    }

    public func next() -> UInt64 {
        return rawValue.nextLong().toULong()
    }
}
#endif

#if SKIP
/// A seeded random number generator that is not cryptographically secure.
/// Provided for use in randomized testing, etc.
public struct PseudoRandomNumberGenerator : RawRepresentable, RandomNumberGenerator {
    public let rawValue: java.util.Random

    public init(rawValue: java.util.Random = java.util.Random()) {
        self.rawValue = rawValue
    }

    public static func seeded(seed: Int64) -> PseudoRandomNumberGenerator {
        return PseudoRandomNumberGenerator(rawValue: java.util.Random(seed))
    }

    public func next() -> UInt64 {
        return rawValue.nextLong().toULong()
    }
}
#else
import protocol Swift.RandomNumberGenerator
import struct Swift.SystemRandomNumberGenerator

/// A seeded random number generator that is not cryptographically secure.
/// Provided for use in randomized testing, etc.
///
/// The implementation follows the Java `java.util.Random` seeded random:
/// it uses a 48-bit seed, which is modified using a linear congruential formula. (See Donald Knuth, The Art of Computer Programming, Volume 2, Section 3.2.1.)
public struct PseudoRandomNumberGenerator : RandomNumberGenerator {
    private let multiplier: Int64 = 0x5DEECE66D
    private let addend: Int64 = 0xB
    private let mask: Int64 = (1 << 48) - 1
    public var seed: Int64
    public let algorithm: Algorithm

    public enum Algorithm {
        case linearCongruential
        //case mersenneTwister
        //case xorShift
    }

    public init(algorithm: Algorithm = .linearCongruential, seed: Int64) {
        self.algorithm = algorithm
        self.seed = (seed ^ multiplier) & mask
    }

    public static func seeded(seed: Int64) -> PseudoRandomNumberGenerator {
        PseudoRandomNumberGenerator(seed: seed)
    }

    @inlinable public mutating func next() -> UInt64 {
        let long = (Int64(nextInt()) << 32) + Int64(nextInt())
        return UInt64(bitPattern: long)
    }

    @usableFromInline mutating func next(_ bits: Int32) -> Int64 {
        seed = (seed &* multiplier + addend) & mask
        return seed >> (48 - bits)
    }

    @usableFromInline mutating func nextInt() -> Int32 {
        Int32(truncatingIfNeeded: next(32))
    }
}
#endif
