// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

public struct IntSet: BidirectionalCollection, SetAlgebra {
    public typealias Index = Int
    public typealias Element = Int

    public init(integersIn range: any RangeExpression<Int>) {
    }

    public init(integer: Int) {
    }

    public init() {
    }

    @available(*, unavailable)
    public var rangeView: Any {
        fatalError()
    }

    @available(*, unavailable)
    public func rangeView(of range: any RangeExpression<Int>) -> Any {
    }

    public func integerGreaterThan(_ integer: Int) -> Int? {
        return nil
    }

    public func integerLessThan(_ integer: Int) -> Int? {
        return nil
    }

    public func integerGreaterThanOrEqualTo(_ integer: Int) -> Int? {
        return nil
    }

    public func integerLessThanOrEqualTo(_ integer: Int) -> Int? {
        return nil
    }

    @available(*, unavailable)
    public func indexRange(in range: any RangeExpression<Int>) -> Range<Int> {
        fatalError()
    }

    public func count(in range: any RangeExpression<Int>) -> Int {
        return 0
    }

    public func contains(integersIn range: any RangeExpression<Int>) -> Bool {
        return false
    }

    public func contains(integersIn indexSet: IntSet) -> Bool {
        return false
    }

    public func intersects(integersIn range: any RangeExpression<Int>) -> Bool {
        return false
    }

    public mutating func insert(integersIn range: any RangeExpression<Int>) {
    }

    public mutating func remove(integersIn range: any RangeExpression<Int>) {
    }

    public func filteredIndexSet(in range: any RangeExpression<Int>, includeInteger: (Int) throws -> Bool) rethrows -> IntSet {
        return self
    }

    public func filteredIndexSet(includeInteger: (Int) throws -> Bool) rethrows -> IntSet {
        return self
    }

    @available(*, unavailable)
    public mutating func shift(startingAt integer: Int, by delta: Int) {
    }
}

#endif
