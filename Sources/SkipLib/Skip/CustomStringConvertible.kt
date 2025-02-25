// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Typealias defined to satisfy `Swift.CustomStringConvertible`.
///
/// All types have `toString()`. We cannot define this  as a protocol because there is no way to make
/// existing Kotlin types (e.g. `kotlin.Int`) conform to new protocols.
typealias CustomStringConvertible = Any

/// Default all Swift `description` calls to using Kotlin `toString()`.
///
/// For types that implement a custom `description` property, the transpiler synthesizes a `toString()`
/// override to return their property value.
val Any.description: String
    get() = toString()

interface CustomDebugStringConvertible {
    val debugDescription: String
}
