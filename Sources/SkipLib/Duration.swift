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

    /// The seconds and attoseconds components, matching Swift's `Duration.components`.
    public var components: (seconds: Int64, attoseconds: Int64) {
        fatalError()
    }

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

/// A type that defines a specific point in time for a given `Clock`.
public protocol InstantProtocol<Duration>: Hashable, Comparable, Sendable {
    associatedtype Duration

    func advanced(by duration: Duration) -> Self
    func duration(to other: Self) -> Duration
}

extension InstantProtocol {
    public static func + (lhs: Self, rhs: Duration) -> Self {
        fatalError()
    }

    public static func - (lhs: Self, rhs: Duration) -> Self {
        fatalError()
    }

    public static func - (lhs: Self, rhs: Self) -> Duration {
        fatalError()
    }

    public static func += (lhs: inout Self, rhs: Duration) {
        fatalError()
    }

    public static func -= (lhs: inout Self, rhs: Duration) {
        fatalError()
    }
}

/// A mechanism in which to measure time, and delay work until a given point in time.
public protocol Clock<Duration>: Sendable {
    associatedtype Duration
    associatedtype Instant: InstantProtocol where Self.Instant.Duration == Self.Duration

    var now: Instant { get }
    var minimumResolution: Duration { get }

    func sleep(until deadline: Instant, tolerance: Duration?) async throws
}

extension Clock {
    public func sleep(for duration: Duration) async throws {
        fatalError()
    }

    public func measure(_ work: () async throws -> Void) async rethrows -> Duration {
        fatalError()
    }
}

/// A clock that measures time that always increments and does not stop
/// incrementing while the system is asleep.
public struct ContinuousClock: Clock, Sendable {
    public struct Instant: InstantProtocol, Hashable, Comparable, Sendable, CustomStringConvertible {
        public func advanced(by duration: Duration) -> Instant {
            fatalError()
        }

        public func duration(to other: Instant) -> Duration {
            fatalError()
        }

        public static func < (lhs: Instant, rhs: Instant) -> Bool {
            fatalError()
        }

        public var description: String {
            fatalError()
        }

        public static var now: Instant {
            fatalError()
        }
    }

    public init() {
    }

    public var now: Instant {
        fatalError()
    }

    public var minimumResolution: Duration {
        fatalError()
    }

    public func sleep(until deadline: Instant, tolerance: Duration? = nil) async throws {
        fatalError()
    }

    public static var now: Instant {
        fatalError()
    }
}

extension Clock where Self == ContinuousClock {
    public static var continuous: ContinuousClock {
        fatalError()
    }
}

/// A clock that measures time that always increments, but stops incrementing
/// while the system is asleep.
public struct SuspendingClock: Clock, Sendable {
    public struct Instant: InstantProtocol, Hashable, Comparable, Sendable, CustomStringConvertible {
        public func advanced(by duration: Duration) -> Instant {
            fatalError()
        }

        public func duration(to other: Instant) -> Duration {
            fatalError()
        }

        public static func < (lhs: Instant, rhs: Instant) -> Bool {
            fatalError()
        }

        public var description: String {
            fatalError()
        }

        public static var now: Instant {
            fatalError()
        }
    }

    public init() {
    }

    public var now: Instant {
        fatalError()
    }

    public var minimumResolution: Duration {
        fatalError()
    }

    public func sleep(until deadline: Instant, tolerance: Duration? = nil) async throws {
        fatalError()
    }

    public static var now: Instant {
        fatalError()
    }
}

extension Clock where Self == SuspendingClock {
    public static var suspending: SuspendingClock {
        fatalError()
    }
}

#endif
