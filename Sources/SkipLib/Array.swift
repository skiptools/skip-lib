// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
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
