// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
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
