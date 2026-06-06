// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite class ClockTests {

    // Convert a Duration to a Double seconds count for tolerance-based checks.
    func toSecondsDouble(_ d: Duration) -> Double {
        return Double(d.components.seconds) + Double(d.components.attoseconds) / 1.0e18
    }

    // MARK: - ContinuousClock

    @Test func continuousClockNowAdvances() async throws {
        let clock = ContinuousClock()
        let a = clock.now
        try await Task.sleep(for: .milliseconds(20))
        let b = clock.now
        #expect(a < b)
        #expect(!(b < a))
        #expect(a != b)
    }

    @Test func continuousClockInstantAdvancedBy() {
        let clock = ContinuousClock()
        let a = clock.now
        let b = a.advanced(by: .seconds(1))
        let diff = a.duration(to: b)
        // The advance is exactly 1 second within the precision of our representation.
        #expect(toSecondsDouble(diff) >= 0.999)
        #expect(toSecondsDouble(diff) <= 1.001)
        #expect(a < b)
    }

    @Test func continuousClockInstantDurationToReverseIsNegative() {
        let clock = ContinuousClock()
        let a = clock.now
        let b = a.advanced(by: .milliseconds(500))
        let forward = a.duration(to: b)
        let backward = b.duration(to: a)
        #expect(toSecondsDouble(forward) > 0.0)
        #expect(toSecondsDouble(backward) < 0.0)
    }

    @Test func continuousClockMeasureSleep() async throws {
        let clock = ContinuousClock()
        let elapsed = try await clock.measure {
            try await Task.sleep(for: .milliseconds(100))
        }
        let elapsedSeconds = toSecondsDouble(elapsed)
        #expect(elapsedSeconds >= 0.08)
        // Upper bound is wide so a grinding CI runner that pauses inside the sleep does not flake.
        #expect(elapsedSeconds < 30.0)
    }

    @Test func continuousClockSleepUntil() async throws {
        let clock = ContinuousClock()
        let elapsed = try await clock.measure {
            let deadline = clock.now.advanced(by: .milliseconds(100))
            try await clock.sleep(until: deadline, tolerance: nil)
        }
        let elapsedSeconds = toSecondsDouble(elapsed)
        #expect(elapsedSeconds >= 0.08)
        #expect(elapsedSeconds < 30.0)
    }

    @Test func continuousClockSleepUntilInPastReturnsImmediately() async throws {
        let clock = ContinuousClock()
        // Use a deadline far in the past so the spread between the "early return" path (~0 ms) and the
        // "actually slept for the full duration" path (60 s) is large enough that even a heavily loaded
        // CI runner with multi-second scheduling pauses still lands clearly on the early-return side.
        let elapsed = try await clock.measure {
            let deadline = clock.now.advanced(by: .seconds(-60))
            try await clock.sleep(until: deadline, tolerance: nil)
        }
        #expect(toSecondsDouble(elapsed) < 10.0)
    }

    @Test func continuousClockMinimumResolutionIsPositive() {
        let clock = ContinuousClock()
        let res = clock.minimumResolution
        let resSeconds = toSecondsDouble(res)
        #expect(resSeconds > 0.0)
        #expect(resSeconds < 1.0)
    }

    // MARK: - SuspendingClock

    @Test func suspendingClockNowAdvances() async throws {
        let clock = SuspendingClock()
        let a = clock.now
        try await Task.sleep(for: .milliseconds(20))
        let b = clock.now
        #expect(a < b)
    }

    @Test func suspendingClockInstantAdvancedBy() {
        let clock = SuspendingClock()
        let a = clock.now
        let b = a.advanced(by: .seconds(1))
        let diff = a.duration(to: b)
        #expect(toSecondsDouble(diff) >= 0.999)
        #expect(toSecondsDouble(diff) <= 1.001)
        #expect(a < b)
    }

    @Test func suspendingClockMeasureSleep() async throws {
        let clock = SuspendingClock()
        let elapsed = try await clock.measure {
            try await Task.sleep(for: .milliseconds(100))
        }
        let elapsedSeconds = toSecondsDouble(elapsed)
        #expect(elapsedSeconds >= 0.08)
        #expect(elapsedSeconds < 30.0)
    }

    @Test func suspendingClockSleepUntil() async throws {
        let clock = SuspendingClock()
        let elapsed = try await clock.measure {
            let deadline = clock.now.advanced(by: .milliseconds(100))
            try await clock.sleep(until: deadline, tolerance: nil)
        }
        let elapsedSeconds = toSecondsDouble(elapsed)
        #expect(elapsedSeconds >= 0.08)
        #expect(elapsedSeconds < 30.0)
    }
}
