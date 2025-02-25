// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Typealiases defined to satisfy `Swift.BitwiseCopyable` and `Swift.Copyable`.
///
// This typealias is defined to satisfy references in Swift. We cannot define this as a protocol because there
// is no way to make existing Kotlin types (e.g. `kotlin.Int`) conform to new protocols
typealias BitwiseCopyable = Any
typealias Copyable = Any
