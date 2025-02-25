// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
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
