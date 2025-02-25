// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

public struct Set<Element>: Collection, SetAlgebra {
    public typealias Index = Int
    
    public init() {
    }

    public init(_ sequence: any Sequence<Element>) {
    }

    @available(*, unavailable)
    public init(minimumCapacity: Int) {
    }

    public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> Set<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public var capacity: Int {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
    }

    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    }
}

#endif
