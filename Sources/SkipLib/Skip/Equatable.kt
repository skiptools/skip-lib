// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

/// Typealias defined to satisfy `Swift.Equatable`.
///
// This typealias is defined to satisfy references in Swift. All types have `equals()`. We cannot define this
// as a protocol because there is no way to make existing Kotlin types (e.g. `kotlin.Int`) conform to new protocols
typealias Equatable = Any
