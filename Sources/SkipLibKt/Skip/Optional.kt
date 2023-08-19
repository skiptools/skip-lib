// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
