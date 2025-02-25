// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Typealias defined to satisfy `Swift.Hashable`.
///
// This typealias is defined to satisfy references in Swift. All types have `hashCode()`. We cannot define this
// as a protocol because there is no way to make existing Kotlin types (e.g. `kotlin.Int`) conform to new protocols.
typealias Hashable = Any
typealias AnyHashable = Hashable

/// Map Swift's `hashValue` to Kotlin's `hashCode()`.
val Any.hashValue: Int
    get() = hashCode()

/// Kotlin representation of `Swift.Hasher`.
class Hasher {
    private var result = 1

    fun combine(value: Any?) {
        result = Companion.combine(result, value)
    }

    fun finalize(): Int = result

    companion object {
        fun combine(result: Int, value: Any?): Int {
            return result * 17 + (value?.hashCode() ?: 0)
        }
    }
}
