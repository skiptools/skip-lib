// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

// - We move the majority of the API into extensions so that we don't have to repeat it in the
//   symbols of our implementing types
// - We're overly non-specific with some parameter types and overly specific with some return types
// - to simplify type inference - we can rely on the Swift compiler to prevent any type mismatches
// - We use Int for all Index types to match Kotlin

public protocol Sequence<Element> {
    associatedtype Element
    public func makeIterator() -> any IteratorProtocol<Element>
}

extension Sequence {
    public var underestimatedCount: Int {
        fatalError()
    }

    public func withContiguousStorageIfAvailable<R>(_ body: (Any) throws -> R) rethrows -> R? {
        fatalError()
    }

    public func shuffled<T: RandomNumberGenerator>(using generator: inout T) -> [Element] {
        fatalError()
    }

    public func shuffled() -> [Element] {
        fatalError()
    }

    @available(*, unavailable)
    public var lazy: any Sequence<Element> {
        fatalError()
    }

    public func map<RE>(_ transform: (Element) throws -> RE) rethrows -> [RE] {
        fatalError()
    }

    public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        fatalError()
    }

    public func forEach(_ body: (Element) throws -> Void) rethrows {
    }

    public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) throws -> Bool) rethrows -> [Element] /* ArraySlice<Element> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func suffix(_ maxLength: Int) -> [Element] {
        fatalError()
    }

    public func dropFirst(_ k: Int = 1) -> [Element] /* DropFirstSequence<Self> */ {
        fatalError()
    }

    public func dropLast(_ k: Int = 1) -> [Element] {
        fatalError()
    }

    @available(*, unavailable)
    public func drop(while predicate: (Element) throws -> Bool) rethrows -> [Element] /* DropWhileSequence<Self> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(_ maxLength: Int) -> [Element] /* PrefixSequence<Self> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(while predicate: (Element) throws -> Bool) rethrows -> [Element] {
        fatalError()
    }

    public func enumerated() -> any Sequence<(offset: Int, element: Element)> {
        fatalError()
    }
    
    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {
        fatalError()
    }

    public func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element? {
        fatalError()
    }

    public func starts(with possiblePrefix: Any, by areEquivalent: (Element, Element) throws -> Bool) rethrows -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func elementsEqual(_ other: Any, by areEquivalent: (Element, Element) throws -> Bool) rethrows -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func lexicographicallyPrecedes(_ other: Any, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool {
        fatalError()
    }

    public func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        fatalError()
    }

    public func reduce<R>(_ initialResult: R, _ nextPartialResult: (_ partialResult: R, Element) throws -> R) rethrows -> R {
        fatalError()
    }

    public func reduce<R>(into initialResult: R, _ updateAccumulatingResult: (_ partialResult: inout R, Element) throws -> Void) rethrows -> R {
        fatalError()
    }

    public func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        fatalError()
    }

    public func reversed() -> [Element] {
        fatalError()
    }

    public func flatMap<RE>(_ transform: (Element) throws -> any Sequence<RE>) rethrows -> [RE] {
        fatalError()
    }

    public func compactMap<RE>(_ transform: (Element) throws -> RE?) rethrows -> [RE] {
        fatalError()
    }

    public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {
        fatalError()
    }

    public func joined<RE>() -> [RE] where Element: Sequence<RE> /* FlattenSequence<Self> */ {
        fatalError()
    }

    public func joined<RE>(separator: any Sequence<RE>) -> [RE] where Element: Sequence<RE> /* JoinedSequence<Self> */ {
        fatalError()
    }

    public func joined(separator: String) -> String {
        fatalError()
    }

    @available(*, unavailable)
    public func split(separator: Element, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [Element] /* ArraySlice<Element> */ {
        fatalError()
    }

    public func starts(with possiblePrefix: Any) -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func elementsEqual(_ other: Any) -> Bool {
        fatalError()
    }

    public func contains(_ element: Element) -> Bool {
        fatalError()
    }

    public func min() -> Element? {
        fatalError()
    }

    public func max() -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func lexicographicallyPrecedes(_ other: Any) -> Bool {
        fatalError()
    }

    public func sorted() -> [Element] {
        fatalError()
    }
}

public protocol Collection : Sequence {
    typealias Index = Int
}

extension Collection {
    public var startIndex: Int {
        fatalError()
    }

    public var endIndex: Int {
        fatalError()
    }

    public subscript(position: Int) -> Element {
        fatalError()
    }

    public var indices: any Sequence<Int> {
        fatalError()
    }

    public var isEmpty: Bool {
        fatalError()
    }

    public var count: Int {
        fatalError()
    }

    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        fatalError()
    }

    @available(*, unavailable)
    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        fatalError()
    }

    public func distance(from start: Int, to end: Int) -> Int {
        fatalError()
    }

    public func index(after i: Int) -> Int {
        fatalError()
    }

    @available(*, unavailable)
    public func formIndex(after i: inout Int) {
    }

    @available(*, unavailable)
    public func formIndex(_ i: inout Int, offsetBy distance: Int) {
    }

    @available(*, unavailable)
    public func formIndex(_ i: inout Int, offsetBy distance: Int, limitedBy limit: Int) -> Bool {
        fatalError()
    }

    public func randomElement() -> Element? {
        fatalError()
    }

    public func randomElement(using generator: inout any RandomNumberGenerator) -> Element? {
        fatalError()
    }

    public mutating func popFirst() -> Element? {
        fatalError()
    }

    public var first: Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(upTo end: Int) -> [Element] /* Collection<Element> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func suffix(from start: Int) -> [Element] /* Collection<Element> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(through end: Int) -> [Element] /* Collection<Element> */ {
        fatalError()
    }

    public mutating func removeFirst() -> Element {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func removeFirst(_ k: Int) {
    }

    public func firstIndex(of element: Element) -> Int? {
        fatalError()
    }

    public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int {
        fatalError()
    }

    public mutating func shuffle() {
    }

    public mutating func shuffle<T: RandomNumberGenerator>(using generator: inout T) {
    }

    public mutating func sort() {
    }

    public mutating func sort(by areIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
    }

    // SKIP NOWARN
    public subscript(bounds: Range<Int>) -> any Collection<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func trimmingPrefix(while predicate: (Element) throws -> Bool) rethrows -> [Element] /* Collection<Element> */ {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func trimPrefix(while predicate: (Element) throws -> Bool) throws {
    }

    @available(*, unavailable)
    public func firstRange(of other: Any) -> Range<Int>? {
        fatalError()
    }

    @available(*, unavailable)
    public func ranges(of other: Any) -> [Range<Int>] {
        fatalError()
    }

    @available(*, unavailable)
    public func split(separator: any Collection<Element>, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [[Element]] /* Collection<Collection<Element>> */ {
        fatalError()
    }

    @available(*, unavailable)
    public func trimmingPrefix(_ prefix: any Sequence<Element>) -> [Element] /* Collection<Element> */ {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func trimPrefix(_ prefix: any Sequence<Element>) {
    }
}

public protocol BidirectionalCollection : Collection {
}

extension BidirectionalCollection {
    @available(*, unavailable)
    public func index(before i: Int) -> Int {
        fatalError()
    }

    @available(*, unavailable)
    public func formIndex(before i: inout Int) {
    }

    public var last: Element? {
        fatalError()
    }

    public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func lastIndex(of element: Element) -> Int? {
        fatalError()
    }

    @available(*, unavailable)
    public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        fatalError()
    }

    @available(*, unavailable)
    public func difference(from other: Any) -> CollectionDifference<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func difference(from other: any Collection<Element>, by areEquivalent: (Element, Element) -> Bool) -> CollectionDifference<Element> {
        fatalError()
    }

    public mutating func popLast() -> Element? {
        fatalError()
    }

    public mutating func removeLast(_ k: Int = 1) {
    }

    @available(*, unavailable)
    public func contains(_ regex: some RegexComponent) -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func firstRange(of regex: some RegexComponent) -> Range<Int>? {
        fatalError()
    }

    @available(*, unavailable)
    public func ranges(of regex: some RegexComponent) -> [Range<Int>] {
        fatalError()
    }

    @available(*, unavailable)
    public func trimmingPrefix(_ regex: some RegexComponent) -> [Element] {
        fatalError()
    }

    @available(*, unavailable)
    public func firstMatch(of r: some RegexComponent) -> Any? {
        fatalError()
    }

    @available(*, unavailable)
    public func matches(of r: some RegexComponent) -> [Any] {
        fatalError()
    }

    @available(*, unavailable)
    public func split(separator: some RegexComponent, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [[Element]] {
        fatalError()
    }

    @available(*, unavailable)
    public func starts(with regex: some RegexComponent) -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func wholeMatch(of r: some RegexComponent) -> Any {
        fatalError()
    }

    @available(*, unavailable)
    public func prefixMatch(of r: some RegexComponent) -> Any {
        fatalError()
    }
}

public protocol RandomAccessCollection : BidirectionalCollection {
}

public protocol RangeReplaceableCollection : Collection {
}

extension RangeReplaceableCollection {
    @available(*, unavailable)
    public mutating func replaceSubrange(_ subrange: any RangeExpression<Int>, with newElements: any Collection<Element>) {
    }

    @available(*, unavailable)
    public mutating func reserveCapacity(_ n: Int) {
    }

    public mutating func append(_ newElement: Element) {
    }

    public mutating func append(contentsOf newElements: any Sequence<Element>) {
    }

    public mutating func insert(_ newElement: Element, at i: Int) {
    }

    @available(*, unavailable)
    public mutating func insert(contentsOf newElements: any Sequence<Element>, at i: Int) {
    }

    @available(*, unavailable)
    public mutating func remove(at i: Int) -> Element {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func removeSubrange(_ bounds: any RangeExpression<Int>) {
    }

    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    }

    @available(*, unavailable)
    public mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
    }

    @available(*, unavailable)
    public func applying(_ difference: CollectionDifference<Element>) -> Self? {
        fatalError()
    }

    @available(*, unavailable)
    public func replacing(_ other: any Collection<Element>, with replacement: any Collection<Element>, subrange: Range<Int>, maxReplacements: Int = Int.max) -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public func replacing(_ other: any Collection<Element>, with replacement: any Collection<Element>, maxReplacements: Int = Int.max) -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func replace(_ other: any Collection<Element>, with replacement: any Collection<Element>, maxReplacements: Int = Int.max) {
    }

    @available(*, unavailable)
    public func replacing(_ regex: some RegexComponent, with replacement: any Collection<Character>, maxReplacements: Int = Int.max) -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public func replacing(_ regex: some RegexComponent, with replacement: any Collection<Character>, subrange: Range<Int>, maxReplacements: Int = Int.max) -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func replace(_ regex: some RegexComponent, with replacement: any Collection<Character>, maxReplacements: Int = Int.max) -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public func replacing(_ regex: some RegexComponent, maxReplacements: Int = Int.max, with replacement: (Any) throws -> any Collection<Character>) rethrows {
    }

    @available(*, unavailable)
    public func replacing(_ regex: some RegexComponent, subrange: Range<Int>, maxReplacements: Int = Int.max, with replacement: (Any) throws -> any Collection<Character>) rethrows -> Self {
        fatalError()
    }

    @available(*, unavailable)
    public mutating func replace(_ regex: some RegexComponent, maxReplacements: Int = Int.max, with replacement: (Any) throws -> any Collection<Character>) rethrows {
    }

    @available(*, unavailable)
    public mutating func trimPrefix(_ regex: some RegexComponent) {
    }
}

public protocol MutableCollection : Collection {
}

extension MutableCollection {
    subscript(position: Int) -> Element {
        get { fatalError() }
        set {}
    }

    subscript(bounds: Range<Int>) -> any Collection<Element> {
        get { fatalError() }
        set {}
    }

    @available(*, unavailable)
    mutating func swapAt(_ i: Int, _ j: Int) {
    }

    @available(*, unavailable)
    public mutating func reverse() {
    }
}

// MARK: - Functions

@available(*, unavailable)
public func repeatElement<T>(_ element: T, count n: Int) -> [T] /* Repeated<T> */ {
    fatalError()
}

@available(*, unavailable)
public func sequence<T>(first: T, next: @escaping (T) -> T?) -> [T] /* UnfoldFirstSequence<T> */ {
    fatalError()
}

@available(*, unavailable)
public func sequence<T, State>(state: State, next: @escaping (inout State) -> T?) -> [T] /* UnfoldSequence<T, State> */ {
    fatalError()
}

public func stride<T>(from start: T, to end: T, by stride: T) -> any Sequence<T> {
    fatalError()
}

public func stride<T>(from start: T, through end: T, by stride: T) -> any Sequence<T> {
    fatalError()
}

// MARK: - Helpers

@available(*, unavailable)
public struct ClosedRange<Bound> {
}

@available(*, unavailable)
public struct CollectionOfOne<Element> {
}

@available(*, unavailable)
public struct CollectionDifference<ChangeElement> {
}

@available(*, unavailable)
public struct DefaultIndices<Elements> {
}

@available(*, unavailable)
public struct DropFirstSequence<Base> {
}

@available(*, unavailable)
public struct DropWhileSequence<Base> {
}

@available(*, unavailable)
public struct EmptyCollection<Element> {
}

@available(*, unavailable)
public struct FlattenSequence<Element> {
}

@available(*, unavailable)
public struct IndexingIterator<Elements> {
}

public protocol IteratorProtocol<Element> {
    associatedtype Element
    mutating func next() -> Element?
}

@available(*, unavailable)
public struct IteratorSequence<Base> {
}

@available(*, unavailable)
public struct JoinedSequence<Element> {
}

@available(*, unavailable)
public struct KeyValuePairs<Key, Value> {
}

@available(*, unavailable)
public struct PartialRangeFrom<Bound> {
}

@available(*, unavailable)
public struct PartialRangeThrough<Bound> {
}

@available(*, unavailable)
public struct PartialRangeUpTo<Bound> {
}

@available(*, unavailable)
public struct PrefixSequence<Base> {
}

@available(*, unavailable)
public protocol RangeExpression<Bound> {
    associatedtype Bound
}

// We only support this API on Kotlin IntRange
public struct Range<Bound> {
    public let lowerBound: Bound
    public let upperBound: Bound

    public func contains(_ element: Bound) -> Bool {
        fatalError()
    }

    public var isEmpty: Bool {
        fatalError()
    }
}

@available(*, unavailable)
public struct Repeated<Element> {
}

@available(*, unavailable)
public protocol Strideable {
}

@available(*, unavailable)
public struct StrideThrough<Element> {
}

@available(*, unavailable)
public struct StrideThroughIterator<Element> {
}

@available(*, unavailable)
public struct StrideTo<Element> {
}

@available(*, unavailable)
public struct StrideToIterator<Element> {
}

@available(*, unavailable)
public struct UnfoldSequence<Element, State> {
}

#endif
