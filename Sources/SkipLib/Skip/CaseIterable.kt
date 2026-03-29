// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

/// Kotlin equivalent of `Swift.CaseIterable`.
interface CaseIterable {
}
interface CaseIterableCompanion<T> {
    val allCases: Array<T>
}
