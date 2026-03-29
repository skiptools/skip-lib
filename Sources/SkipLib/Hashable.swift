// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
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
