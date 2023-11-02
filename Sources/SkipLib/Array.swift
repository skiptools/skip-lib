// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

public struct Array<Element>: RandomAccessCollection, RangeReplaceableCollection, MutableCollection {
    public typealias Index = Int

    public init() {
    }

    public init(repeating: Element, count: Int) {
    }

    public init(_ sequence: any Sequence<Element>) {
    }
}

#endif
