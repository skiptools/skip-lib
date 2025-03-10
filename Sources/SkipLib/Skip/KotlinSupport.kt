// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// A type that can convert to an underlying Kotlin instance.
interface KotlinConverting<T> {
    /// Convert a transpiled Swift instance to its Kotlin equivalent.
    ///
    /// - Parameter nocopy: Set to `true` as a hint to the receiver to directly return its
    ///   underlying Kotlin object if possible. This also prevents deep conversions, e.g.
    ///   this prevents an `Array` from calling `.kotlin()` on all of its elements
    fun kotlin(nocopy: Boolean = false): T
}

/// General function to convert values for use in Kotlin.
///
/// If this instance is `KotlinConverting`, it will be converted using that interface.
/// If this is a `MutableStruct` and `nocopy` is false, it will be copied with `sref()`.
/// Otherwise, returns `this`.
fun Any.kotlin(nocopy: Boolean = false): Any {
    val converting = this as? KotlinConverting<*>
    if (converting != null) {
        return converting.kotlin(nocopy = nocopy) as Any
    } else if (!nocopy && this is MutableStruct) {
        return this.sref()
    } else {
        return this
    }
}
