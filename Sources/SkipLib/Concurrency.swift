// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

// Note that we don't attach 'nodispatch' attributes to Task API because the transpiler automatically
// adjusts the dispatch behavior of closures passed to Tasks

public struct Task<Success, Failure> where Failure: Error {
    public var value: Success {
        get async throws { fatalError() }
    }

    @available(*, unavailable)
    public var result: Result<Success, Failure> {
        get async { fatalError() }
    }

    public func cancel() {
    }

    @available(*, unavailable)
    public static var currentPriority: TaskPriority {
        fatalError()
    }

    @available(*, unavailable)
    public static var basePriority: TaskPriority? {
        fatalError()
    }

    public init(priority: TaskPriority? = nil, operation: @escaping () async throws -> Success) {
    }

    // SKIP NOWARN
    public static func detached(priority: TaskPriority? = nil, operation: @escaping () async -> Success) -> Task<Success, Failure> {
        fatalError()
    }

    public static func yield() async {
    }

    public var isCancelled: Bool {
        fatalError()
    }

    public static var isCancelled: Bool {
        fatalError()
    }

    public static func checkCancellation() throws {
    }

    public static func sleep(nanoseconds duration: UInt64) async throws {
    }

    // public static func sleep<C>(until deadline: C.Instant, tolerance: C.Instant.Duration? = nil, clock: C) async throws where C : Clock
    @available(*, unavailable)
    public static func sleep(until deadline: Any, tolerance: Any? = nil, clock: Any) async throws {
    }

    @available(*, unavailable)
    public static func sleep(for duration: /* Duration */ Double) async throws {
    }
}

public struct TaskPriority : RawRepresentable {
    public var rawValue: /* UInt8 */ Int {
        fatalError()
    }

    public init(rawValue: /* UInt8 */ Int) {
    }

    public static var high: TaskPriority {
        fatalError()
    }
    public static var medium: TaskPriority {
        fatalError()
    }
    public static var low: TaskPriority {
        fatalError()
    }
    public static var userInitiated: TaskPriority {
        fatalError()
    }
    public static var utility: TaskPriority {
        fatalError()
    }
    public static var background: TaskPriority {
        fatalError()
    }
}

public struct TaskGroup<ChildTaskResult>: AsyncSequence<ChildTaskResult> {
    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTask(priority: TaskPriority? = nil, operation: () async -> ChildTaskResult) {
    }

    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTaskUnlessCancelled(priority: TaskPriority? = nil, operation: () async -> ChildTaskResult) -> Bool {
        return false
    }

    public mutating func next() async -> ChildTaskResult? {
        return nil
    }

    public mutating func waitForAll() async {
    }

    public var isEmpty: Bool {
        return false
    }

    public func cancelAll() {
    }

    public var isCancelled: Bool {
        return false
    }

    public func makeAsyncIterator() -> Iterator<ChildTaskResult> {
        fatalError()
    }

    public struct Iterator<ChildTaskResult>: AsyncIteratorProtocol<ChildTaskResult> {
        public mutating func next() async -> ChildTaskResult? {
            return nil
        }

        public mutating func cancel() {
        }
    }
}

public struct DiscardingTaskGroup {
    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTask(priority: TaskPriority? = nil, operation: () async -> Void) {
    }

    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTaskUnlessCancelled(priority: TaskPriority? = nil, operation: () async -> Void) -> Bool {
        return false
    }

    public var isEmpty: Bool {
        return false
    }

    public func cancelAll() {
    }

    public var isCancelled: Bool {
        return false
    }
}

public struct ThrowingTaskGroup<ChildTaskResult, Failure>: AsyncSequence<ChildTaskResult> where Failure : Error {
    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTask(priority: TaskPriority? = nil, operation: () async throws -> ChildTaskResult) {
    }

    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTaskUnlessCancelled(priority: TaskPriority? = nil, operation: () async throws -> ChildTaskResult) -> Bool {
        return false
    }

    public mutating func next() async throws -> ChildTaskResult? {
        return nil
    }

    public mutating func nextResult() async -> Result<ChildTaskResult, Failure>? {
        return nil
    }

    public mutating func waitForAll() async throws {
    }

    public var isEmpty: Bool {
        return false
    }

    public func cancelAll() {
    }

    public var isCancelled: Bool {
        return false
    }

    public func makeAsyncIterator() -> Iterator<ChildTaskResult> {
        fatalError()
    }

    public struct Iterator<ChildTaskResult>: AsyncIteratorProtocol<ChildTaskResult> {
        public mutating func next() async throws -> ChildTaskResult? {
            return nil
        }

        public mutating func cancel() {
        }
    }
}

public struct ThrowingDiscardingTaskGroup<Failure> where Failure : Error {
    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTask(priority: TaskPriority? = nil, operation: () async throws -> Void) {
    }

    // SKIP ATTRIBUTES: nodispatch
    public mutating func addTaskUnlessCancelled(priority: TaskPriority? = nil, operation: () async throws -> Void) -> Bool {
        return false
    }

    public var isEmpty: Bool {
        return false
    }

    public func cancelAll() {
    }

    public var isCancelled: Bool {
        return false
    }
}

// SKIP ATTRIBUTES: nodispatch
public func withTaskGroup<ChildTaskResult, GroupResult>(of childTaskResultType: ChildTaskResult.Type, returning returnType: GroupResult.Type? = nil, body: (TaskGroup<ChildTaskResult>) async -> GroupResult) async -> GroupResult {
    fatalError()
}

// SKIP ATTRIBUTES: nodispatch
public func withDiscardingTaskGroup<GroupResult>(returning returnType: GroupResult.Type? = nil, body: (DiscardingTaskGroup) async -> GroupResult) async -> GroupResult {
    fatalError()
}

// SKIP ATTRIBUTES: nodispatch
public func withThrowingTaskGroup<ChildTaskResult, GroupResult>(of childTaskResultType: ChildTaskResult.Type, returning returnType: GroupResult.Type? = nil, body: (ThrowingTaskGroup<ChildTaskResult, Error>) async throws -> GroupResult) async rethrows -> GroupResult {
    fatalError()
}

// SKIP ATTRIBUTES: nodispatch
public func withThrowingDiscardingTaskGroup<GroupResult>(returning returnType: GroupResult.Type? = nil, body: (ThrowingDiscardingTaskGroup<Error>) async throws -> GroupResult) async throws -> GroupResult {
    fatalError()
}

public struct CancellationError: Error {
}

public protocol Sendable {
}

public protocol AnyActor {
}

public protocol Actor: AnyActor {
}

public class MainActor {
    @available(*, unavailable)
    public static var shared: MainActor {
        fatalError()
    }

    @available(*, unavailable)
    nonisolated final public var unownedExecutor: UnownedSerialExecutor {
        fatalError()
    }

    @available(*, unavailable)
    public static var sharedUnownedExecutor: UnownedSerialExecutor {
        fatalError()
    }

    @available(*, unavailable)
    nonisolated final public func enqueue(_ job: UnownedJob) {
    }

    // SKIP ATTRIBUTES: nodispatch
    public static func run<T>(body: () throws -> T) async -> T {
        fatalError()
    }
}

@available(*, unavailable)
public struct UnownedJob {
}

@available(*, unavailable)
public struct UnownedSerialExecutor {
}

@available(*, unavailable)
public struct UnsafeContinuation<T, E> where E : Error {
}

@available(*, unavailable)
public struct UnsafeCurrentTask {
}

@available(*, unavailable)
public func withCheckedContinuation<T>(function: String = "", _ body: (CheckedContinuation<T, Never>) -> Void) async -> T {
    fatalError()
}

@available(*, unavailable)
@inlinable public func withCheckedThrowingContinuation<T>(function: String = "", _ body: (CheckedContinuation<T, Error>) -> Void) async throws -> T {
    fatalError()
}

@available(*, unavailable)
public func withTaskCancellationHandler<T>(operation: () async throws -> T, onCancel handler: () -> Void) async rethrows -> T {
    fatalError()
}

@available(*, unavailable)
public func withUnsafeContinuation<T>(_ fn: (UnsafeContinuation<T, Never>) -> Void) async -> T {
    fatalError()
}

@available(*, unavailable)
public func withUnsafeCurrentTask<T>(body: (UnsafeCurrentTask?) throws -> T) rethrows -> T {
    fatalError()
}

@available(*, unavailable)
public func withUnsafeThrowingContinuation<T>(_ fn: (UnsafeContinuation<T, Error>) -> Void) async throws -> T {
    fatalError()
}

public protocol AsyncSequence {
    associatedtype Element
    public func makeAsyncIterator() -> any AsyncIteratorProtocol<Element>
}

extension AsyncSequence {
    public func map<RE>(_ transform: (Element) async throws -> RE) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    public func filter(_ isIncluded: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    public func first(where predicate: (Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    public func dropFirst(_ k: Int = 1) -> any AsyncSequence<Element> {
        fatalError()
    }

    public func drop(while predicate: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    public func prefix(_ maxLength: Int) -> any AsyncSequence<Element> {
        fatalError()
    }

    public func prefix(while predicate: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    public func min(by areInIncreasingOrder: (Element, Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    public func max(by areInIncreasingOrder: (Element, Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    public func contains(where predicate: (Element) async throws -> Bool) async rethrows -> Bool {
        fatalError()
    }

    public func reduce<R>(_ initialResult: R, _ nextPartialResult: (_ partialResult: R, Element) async throws -> R) async rethrows -> R {
        fatalError()
    }

    public func reduce<R>(into initialResult: R, _ updateAccumulatingResult: (_ partialResult: inout R, Element) async throws -> Void) async rethrows -> R {
        fatalError()
    }

    public func allSatisfy(_ predicate: (Element) async throws -> Bool) async rethrows -> Bool {
        fatalError()
    }

    public func flatMap<RE>(_ transform: (Element) async throws -> any AsyncSequence<RE>) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    public func compactMap<RE>(_ transform: (Element) async throws -> RE?) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    public func contains(_ element: Element) async -> Bool {
        fatalError()
    }

    public func min() async -> Element? {
        fatalError()
    }

    public func max() async -> Element? {
        fatalError()
    }
}

public protocol AsyncIteratorProtocol {
    associatedtype Element
    mutating func next() async -> Element?
}

#endif
