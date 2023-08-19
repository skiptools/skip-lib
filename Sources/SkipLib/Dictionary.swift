// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

public struct Dictionary<Key, Value>: Collection {
    public typealias Index = Int
    public typealias Element = (key: Key, value: Value)

    public init() {
    }

    public init(minimumCapacity: Int) {
    }

    public init(uniqueKeysWithValues keysAndValues: any Sequence<(Key, Value)>) {
    }

    @available(*, unavailable)
    public init(_ keysAndValues: any Sequence<(Key, Value)>, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {
    }

    @available(*, unavailable)
    public init(grouping values: any Sequence<Value>, by keyForValue: (Value) throws -> Key) rethrows {
    }

    public func filter(_ isIncluded: ((Key, Value)) throws -> Bool) rethrows -> Dictionary<Key, Value> {
        fatalError()
    }

    public subscript(key: Key) -> Value? {
        get { fatalError() }
        set {}
    }

    public subscript(key: Key, default defaultValue: /* @autoclosure () -> Value */ Value) -> Value {
        fatalError()
    }

    public func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> Dictionary<Key, T> {
        fatalError()
    }

    public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> Dictionary<Key, T> {
        fatalError()
    }

    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func merge(_ other: any Sequence<(Key, Value)>, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {
    }

    @available(*, unavailable)
    public mutating func merge(_ other: Dictionary<Key, Value>, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {
    }

    @available(*, unavailable)
    public func merging(_ other: any Sequence<(Key, Value)>, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows -> Dictionary<Key, Value> {
        fatalError()
    }

    @available(*, unavailable)
    public func merging(_ other: Dictionary<Key, Value>, uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows -> Dictionary<Key, Value> {
        fatalError()
    }

    public mutating func removeValue(forKey key: Key) -> Value? {
        fatalError()
    }

    public var keys: any Collection<Key> {
        fatalError()
    }

    public var values: any Collection<Value> {
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
