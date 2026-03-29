// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
// SKIP SYMBOLFILE

#if SKIP

/// A representation of a duration of time, compatible with Swift's `Duration` type.
///
/// Internally stores the duration as a count of attoseconds (10^-18 seconds),
/// split into two components: seconds and attoseconds within the current second.
public struct Duration: Hashable, Comparable, Sendable, CustomStringConvertible {

    /// The seconds component of the duration.
    public let seconds: Int64

    /// The attoseconds component of the duration (0 ..< 1_000_000_000_000_000_000).
    public let attoseconds: Int64

    /// Creates a duration from seconds and attoseconds components.
    public init(secondsComponent: Int64, attosecondsComponent: Int64) {
        fatalError()
    }

    // MARK: - Static Constructors

    /// Creates a duration given a number of seconds.
    public static func seconds(_ seconds: Int) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of seconds as a Double.
    public static func seconds(_ seconds: Double) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of milliseconds.
    public static func milliseconds(_ milliseconds: Int) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of milliseconds as a Double.
    public static func milliseconds(_ milliseconds: Double) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of microseconds.
    public static func microseconds(_ microseconds: Int) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of microseconds as a Double.
    public static func microseconds(_ microseconds: Double) -> Duration {
        fatalError()
    }

    /// Creates a duration given a number of nanoseconds.
    public static func nanoseconds(_ nanoseconds: Int) -> Duration {
        fatalError()
    }

    // MARK: - Arithmetic

    public static func + (lhs: Duration, rhs: Duration) -> Duration {
        fatalError()
    }

    public static func - (lhs: Duration, rhs: Duration) -> Duration {
        fatalError()
    }

    public static func / (lhs: Duration, rhs: Int) -> Duration {
        fatalError()
    }

    public static func * (lhs: Duration, rhs: Int) -> Duration {
        fatalError()
    }

    public static func / (lhs: Duration, rhs: Double) -> Duration {
        fatalError()
    }

    public static func * (lhs: Duration, rhs: Double) -> Duration {
        fatalError()
    }

    // MARK: - Comparison

    public static func < (lhs: Duration, rhs: Duration) -> Bool {
        fatalError()
    }

    // MARK: - Description

    public var description: String {
        fatalError()
    }

    // MARK: - Zero

    public static var zero: Duration {
        fatalError()
    }
}

#endif
