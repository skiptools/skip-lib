// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
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
