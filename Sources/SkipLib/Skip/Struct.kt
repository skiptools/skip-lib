// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// The transpiler adds conformance to this type to Kotlin classes translated from mutable Swift structs.
///
/// We use this API to mimic value type behavior in Kotlin classes.
interface MutableStruct {
    /// Create a copy of the struct.
    fun scopy(): MutableStruct
    /// Set a callback the struct will invoke with itself as an argument when it is mutated.
    var supdate: ((Any) -> Unit)?
    /// Track nested mutating calls so that leaving the last call will invoke `supdate`.
    var smutatingcount: Int

    /// Called before mutations.
    fun willmutate() {
        smutatingcount += 1
    }

    /// Called after mutations.
    fun didmutate() {
        smutatingcount -= 1
        if (smutatingcount <= 0) {
            supdate?.invoke(this)
        }
    }
}

/// Return a new reference to this potential struct.
///
/// The transpiler inserts calls to this function whenever a struct copy may be required to maintain
/// value semantics. We implement this as an extension function for cases when the object type is
/// unknown and may or may not be a mutable struct.
@Suppress("UNCHECKED_CAST")
fun <T> T.sref(onUpdate: ((T) -> Unit)? = null): T {
    if (this is MutableStruct) {
        val copy = scopy()
        copy.supdate = {
            if (onUpdate != null) {
                onUpdate(it as T)
            }
        }
        return copy as T
    }
    return this
}
