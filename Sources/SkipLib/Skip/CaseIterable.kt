// Copyright 2023–2026 Skip
package skip.lib

/// Kotlin equivalent of `Swift.CaseIterable`.
interface CaseIterable {
}
interface CaseIterableCompanion<T> {
    val allCases: Array<T>
}
