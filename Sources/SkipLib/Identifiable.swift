// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if SKIP

/// Kotlin representation of `Swift.Identifiable`.
public protocol Identifiable {
    associatedtype ID : Hashable
    var id: ID { get }
}

extension Identifiable {
    var id: ID {
        return ObjectIdentifier(self) as! ID
    }
}

#endif
