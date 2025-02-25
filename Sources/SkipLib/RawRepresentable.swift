// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if SKIP

/// Kotlin representation of `Swift.RawRepresentable`.
public protocol RawRepresentable {
    associatedtype RawType
    var rawValue: RawType { get }
}

#endif
