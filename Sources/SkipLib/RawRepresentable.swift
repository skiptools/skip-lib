// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
#if SKIP

/// Kotlin representation of `Swift.RawRepresentable`.
public protocol RawRepresentable {
    associatedtype RawType
    var rawValue: RawType { get }
}

#endif
