// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/**
 * A representation of a duration of time, compatible with Swift's `Duration` type.
 *
 * Internally stores the duration as seconds and attoseconds (10^-18 seconds)
 * within the current second.
 */
data class Duration private constructor(
    val seconds: Long,
    val attoseconds: Long,
    @Suppress("UNUSED_PARAMETER") private val tag: Unit
) : Comparable<Duration> {

    constructor(secondsComponent: Long, attosecondsComponent: Long) : this(
        seconds = secondsComponent + attosecondsComponent / ATTOSECONDS_PER_SECOND,
        attoseconds = attosecondsComponent % ATTOSECONDS_PER_SECOND,
        tag = Unit
    )

    companion object {
        const val ATTOSECONDS_PER_SECOND: Long = 1_000_000_000_000_000_000L
        const val ATTOSECONDS_PER_MILLISECOND: Long = 1_000_000_000_000_000L
        const val ATTOSECONDS_PER_MICROSECOND: Long = 1_000_000_000_000L
        const val ATTOSECONDS_PER_NANOSECOND: Long = 1_000_000_000L

        private fun create(seconds: Long, attoseconds: Long): Duration =
            Duration(seconds = seconds, attoseconds = attoseconds, tag = Unit)

        val zero: Duration = create(0L, 0L)

        fun seconds(seconds: Int): Duration = create(seconds.toLong(), 0L)
        fun seconds(seconds: Long): Duration = create(seconds, 0L)
        fun seconds(seconds: Double): Duration {
            val secs = seconds.toLong()
            val frac = seconds - secs.toDouble()
            return create(secs, (frac * ATTOSECONDS_PER_SECOND).toLong())
        }

        fun milliseconds(milliseconds: Int): Duration {
            val ms = milliseconds.toLong()
            return create(ms / 1000L, (ms % 1000L) * ATTOSECONDS_PER_MILLISECOND)
        }
        fun milliseconds(milliseconds: Long): Duration {
            return create(milliseconds / 1000L, (milliseconds % 1000L) * ATTOSECONDS_PER_MILLISECOND)
        }
        fun milliseconds(milliseconds: Double): Duration {
            val totalSeconds = milliseconds / 1000.0
            val secs = totalSeconds.toLong()
            val frac = totalSeconds - secs.toDouble()
            return create(secs, (frac * ATTOSECONDS_PER_SECOND).toLong())
        }

        fun microseconds(microseconds: Int): Duration {
            val us = microseconds.toLong()
            return create(us / 1_000_000L, (us % 1_000_000L) * ATTOSECONDS_PER_MICROSECOND)
        }
        fun microseconds(microseconds: Long): Duration {
            return create(microseconds / 1_000_000L, (microseconds % 1_000_000L) * ATTOSECONDS_PER_MICROSECOND)
        }
        fun microseconds(microseconds: Double): Duration {
            val totalSeconds = microseconds / 1_000_000.0
            val secs = totalSeconds.toLong()
            val frac = totalSeconds - secs.toDouble()
            return create(secs, (frac * ATTOSECONDS_PER_SECOND).toLong())
        }

        fun nanoseconds(nanoseconds: Int): Duration {
            val ns = nanoseconds.toLong()
            return create(ns / 1_000_000_000L, (ns % 1_000_000_000L) * ATTOSECONDS_PER_NANOSECOND)
        }
        fun nanoseconds(nanoseconds: Long): Duration {
            return create(nanoseconds / 1_000_000_000L, (nanoseconds % 1_000_000_000L) * ATTOSECONDS_PER_NANOSECOND)
        }
    }

    /** Total duration in nanoseconds. */
    fun toNanoseconds(): Long {
        return seconds * 1_000_000_000L + attoseconds / ATTOSECONDS_PER_NANOSECOND
    }

    /** Total duration in milliseconds. */
    fun toMilliseconds(): Long {
        return seconds * 1000L + attoseconds / ATTOSECONDS_PER_MILLISECOND
    }

    /** Total duration in seconds as a Double. */
    fun toDouble(): Double {
        return seconds.toDouble() + attoseconds.toDouble() / ATTOSECONDS_PER_SECOND.toDouble()
    }

    // Arithmetic

    operator fun plus(other: Duration): Duration {
        var atto = attoseconds + other.attoseconds
        var secs = seconds + other.seconds
        if (atto >= ATTOSECONDS_PER_SECOND) {
            atto -= ATTOSECONDS_PER_SECOND
            secs += 1L
        }
        return create(secs, atto)
    }

    operator fun minus(other: Duration): Duration {
        var atto = attoseconds - other.attoseconds
        var secs = seconds - other.seconds
        if (atto < 0L) {
            atto += ATTOSECONDS_PER_SECOND
            secs -= 1L
        }
        return create(secs, atto)
    }

    operator fun div(divisor: Int): Duration {
        val totalNanos = toNanoseconds()
        return nanoseconds(totalNanos / divisor.toLong())
    }

    operator fun times(multiplier: Int): Duration {
        val totalNanos = toNanoseconds()
        return nanoseconds(totalNanos * multiplier.toLong())
    }

    operator fun div(divisor: Double): Duration {
        val totalSeconds = toDouble() / divisor
        return seconds(totalSeconds)
    }

    operator fun times(multiplier: Double): Duration {
        val totalSeconds = toDouble() * multiplier
        return seconds(totalSeconds)
    }

    // Comparable

    override fun compareTo(other: Duration): Int {
        val cmp = seconds.compareTo(other.seconds)
        return if (cmp != 0) cmp else attoseconds.compareTo(other.attoseconds)
    }

    // Description

    override fun toString(): String {
        val totalSeconds = toDouble()
        return "${totalSeconds} seconds"
    }
}
