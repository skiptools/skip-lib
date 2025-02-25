// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

// - We move the majority of the API into extensions so that we don't have to repeat it in the
//   symbols of our implementing types

public protocol SetAlgebra<Element> {
    associatedtype Element
}

extension SetAlgebra {
    public func contains(_ element: Element) -> Bool {
        fatalError()
    }

    public func union(_ other: Self) -> Self {
        fatalError()
    }

    public func intersection(_ other: Self) -> Self {
        fatalError()
    }

    public func symmetricDifference(_ other: Self) -> Self {
        fatalError()
    }

    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
    }

    public mutating func remove(_ member: Element) -> Element? {
    }

    public mutating func update(with newMember: Element) -> Element? {
        fatalError()
    }

    public mutating func formUnion(_ other: Self) {
    }

    public mutating func formIntersection(_ other: Self) {
    }

    public mutating func formSymmetricDifference(_ other: Self) {
    }

    public func subtracting(_ other: Self) -> Self {
        fatalError()
    }

    public func isSubset(of other: Self) -> Bool {
        fatalError()
    }

    public func isDisjoint(with other: Self) -> Bool {
        fatalError()
    }

    public func isSuperset(of other: Self) -> Bool {
        fatalError()
    }

    public var isEmpty: Bool {
        fatalError()
    }

    public mutating func subtract(_ other: Self) {
    }

    public func isStrictSubset(of other: Self) -> Bool {
        fatalError()
    }

    public func isStrictSuperset(of other: Self) -> Bool {
        fatalError()
    }
}

#endif
