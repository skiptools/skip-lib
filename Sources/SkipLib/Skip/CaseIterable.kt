// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Kotlin equivalent of `Swift.CaseIterable`.
interface CaseIterable {
}
interface CaseIterableCompanion<T> {
    val allCases: Array<T>
}
