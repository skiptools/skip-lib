// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

// The transpiler adds the 'optional' prefix to Optional type functions to avoid conflicts with other API

/// Kotlin representation of `Swift.Optional.map`.
fun <T, U> T?.optionalmap(transform: (T) -> U): U? {
    if (this == null) {
        return null
    } else {
        return transform(this)
    }
}

/// Kotlin representation of `Swift.Optional.flatMap`.
fun <T, U> T?.optionalflatMap(transform: (T) -> U?): U? {
    if (this == null) {
        return null
    } else {
        return transform(this)
    }
}
