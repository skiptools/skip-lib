// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

import kotlin.time.TimeSource
import kotlin.time.DurationUnit
import kotlin.time.toDuration
import kotlin.time.Duration as KtDuration

/**
 * Kotlin representation of Swift's `InstantProtocol`.
 *
 * Concrete clock `Instant` types implement this marker interface and provide
 * `advanced(by:)`, `duration(to:)`, and `Comparable` semantics directly.
 */
interface InstantProtocol

/**
 * Kotlin representation of Swift's `Clock` protocol.
 *
 * Implementations measure time and offer a `sleep(until:tolerance:)` primitive.
 * `Instant` is the type returned by `now`; the associated duration is always
 * `skip.lib.Duration`.
 */
interface Clock<I : InstantProtocol> {
    val now: I
    val minimumResolution: Duration

    suspend fun sleep(until: I, tolerance: Duration? = null)

    suspend fun sleep(for_: Duration) {
        Task.sleep(for_ = for_)
    }

    suspend fun measure(work: suspend () -> Unit): Duration {
        val start = now
        work()
        val end = now
        return durationBetween(start, end)
    }

    fun durationBetween(start: I, end: I): Duration
}

/// Convert a `skip.lib.Duration` to a `kotlin.time.Duration`.
internal fun Duration.toKotlinDuration(): KtDuration =
    toNanoseconds().toDuration(DurationUnit.NANOSECONDS)

/// Convert a `kotlin.time.Duration` to a `skip.lib.Duration`.
internal fun KtDuration.toSkipDuration(): Duration =
    Duration.nanoseconds(inWholeNanoseconds)

/**
 * Kotlin representation of Swift's `ContinuousClock`.
 *
 * Backed by `kotlin.time.TimeSource.Monotonic`, which on the JVM is
 * implemented by `System.nanoTime()` and continues to advance while the host
 * is idle. The Swift distinction between continuous and suspending clocks
 * does not exist on Android; the two clock classes share an implementation
 * but Swift code that names `ContinuousClock` explicitly continues to work.
 */
class ContinuousClock : Clock<ContinuousClock.Instant> {

    /**
     * A point in time on a `ContinuousClock`.
     *
     * Backed by a `kotlin.time.TimeSource.Monotonic.ValueTimeMark`.
     */
    class Instant internal constructor(internal val mark: TimeSource.Monotonic.ValueTimeMark) : InstantProtocol, Comparable<Instant> {

        fun advanced(by: Duration): Instant {
            return Instant(mark + by.toKotlinDuration())
        }

        fun duration(to: Instant): Duration {
            return (to.mark - mark).toSkipDuration()
        }

        operator fun plus(duration: Duration): Instant = advanced(by = duration)
        operator fun minus(duration: Duration): Instant = Instant(mark - duration.toKotlinDuration())
        operator fun minus(other: Instant): Duration = other.duration(to = this)

        override fun compareTo(other: Instant): Int = mark.compareTo(other.mark)

        override fun equals(other: Any?): Boolean {
            val o = other as? Instant ?: return false
            return mark == o.mark
        }

        override fun hashCode(): Int = mark.hashCode()
        override fun toString(): String = "ContinuousClock.Instant($mark)"

        companion object {
            val now: Instant
                get() = Instant(TimeSource.Monotonic.markNow())
        }
    }

    override val now: Instant
        get() = Instant.now

    override val minimumResolution: Duration
        get() = Duration.nanoseconds(1L)

    override suspend fun sleep(until: Instant, tolerance: Duration?) {
        val remaining = -until.mark.elapsedNow()
        if (remaining <= KtDuration.ZERO) return
        Task.sleep(for_ = remaining.toSkipDuration())
    }

    override fun durationBetween(start: Instant, end: Instant): Duration {
        return start.duration(to = end)
    }

    companion object {
        val now: Instant
            get() = Instant.now

        // Mirror Swift's `Clock.continuous` shorthand.
        val continuous: ContinuousClock = ContinuousClock()
    }
}

/**
 * Kotlin representation of Swift's `SuspendingClock`.
 *
 * On Android there is no first-class distinction between a continuous and a
 * suspending clock: both are backed by `kotlin.time.TimeSource.Monotonic`.
 * The class exists so Swift code that names `SuspendingClock` transpiles
 * cleanly.
 */
class SuspendingClock : Clock<SuspendingClock.Instant> {

    /**
     * A point in time on a `SuspendingClock`.
     *
     * Backed by a `kotlin.time.TimeSource.Monotonic.ValueTimeMark`.
     */
    class Instant internal constructor(internal val mark: TimeSource.Monotonic.ValueTimeMark) : InstantProtocol, Comparable<Instant> {

        fun advanced(by: Duration): Instant {
            return Instant(mark + by.toKotlinDuration())
        }

        fun duration(to: Instant): Duration {
            return (to.mark - mark).toSkipDuration()
        }

        operator fun plus(duration: Duration): Instant = advanced(by = duration)
        operator fun minus(duration: Duration): Instant = Instant(mark - duration.toKotlinDuration())
        operator fun minus(other: Instant): Duration = other.duration(to = this)

        override fun compareTo(other: Instant): Int = mark.compareTo(other.mark)

        override fun equals(other: Any?): Boolean {
            val o = other as? Instant ?: return false
            return mark == o.mark
        }

        override fun hashCode(): Int = mark.hashCode()
        override fun toString(): String = "SuspendingClock.Instant($mark)"

        companion object {
            val now: Instant
                get() = Instant(TimeSource.Monotonic.markNow())
        }
    }

    override val now: Instant
        get() = Instant.now

    override val minimumResolution: Duration
        get() = Duration.nanoseconds(1L)

    override suspend fun sleep(until: Instant, tolerance: Duration?) {
        val remaining = -until.mark.elapsedNow()
        if (remaining <= KtDuration.ZERO) return
        Task.sleep(for_ = remaining.toSkipDuration())
    }

    override fun durationBetween(start: Instant, end: Instant): Duration {
        return start.duration(to = end)
    }

    companion object {
        val now: Instant
            get() = Instant.now

        // Mirror Swift's `Clock.suspending` shorthand.
        val suspending: SuspendingClock = SuspendingClock()
    }
}
