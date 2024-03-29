// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

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
