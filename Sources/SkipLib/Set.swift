// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

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
