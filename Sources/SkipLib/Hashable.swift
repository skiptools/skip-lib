// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

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
