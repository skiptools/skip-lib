// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

public protocol Hashable: Equatable {
    var hashValue: Int { get }
}

typealias AnyHashable = Hashable

public struct Hasher {
    public init() {
    }

    public mutating func combine(_ value: Any?) {
    }

    public func finalize() -> Int {
        fatalError()
    }

    static func combine(result: Int, value: Any?) -> Int {
        fatalError()
    }
}

#endif
