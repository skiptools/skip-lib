// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

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

@available(*, unavailable)
public struct TaskGroup<ChildTaskResult> {
}

@available(*, unavailable)
public struct ThrowingTaskGroup<ChildTaskResult, Failure> where Failure : Error {
}

public struct CancellationError: Error {
}

public protocol Sendable {
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
public func withTaskGroup<ChildTaskResult, GroupResult>(of childTaskResultType: ChildTaskResult.Type, returning returnType: GroupResult.Type = GroupResult.self, body: (inout TaskGroup<ChildTaskResult>) async -> GroupResult) async -> GroupResult {
    fatalError()
}

@available(*, unavailable)
@inlinable public func withThrowingTaskGroup<ChildTaskResult, GroupResult>(of childTaskResultType: ChildTaskResult.Type, returning returnType: GroupResult.Type = GroupResult.self, body: (inout ThrowingTaskGroup<ChildTaskResult, Error>) async throws -> GroupResult) async rethrows -> GroupResult {
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

public protocol AsyncSequence<Element> {
    associatedtype Element
    public func makeAsyncIterator() -> any AsyncIteratorProtocol<Element>
}

extension AsyncSequence {
    @available(*, unavailable)
    public func map<RE>(_ transform: (Element) async throws -> RE) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    @available(*, unavailable)
    public func filter(_ isIncluded: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func first(where predicate: (Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func dropFirst(_ k: Int = 1) -> any AsyncSequence<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func drop(while predicate: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(_ maxLength: Int) -> any AsyncSequence<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func prefix(while predicate: (Element) async throws -> Bool) rethrows -> any AsyncSequence<Element> {
        fatalError()
    }

    @available(*, unavailable)
    public func min(by areInIncreasingOrder: (Element, Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func max(by areInIncreasingOrder: (Element, Element) async throws -> Bool) async rethrows -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func contains(where predicate: (Element) async throws -> Bool) async rethrows -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func reduce<R>(_ initialResult: R, _ nextPartialResult: (_ partialResult: R, Element) async throws -> R) async rethrows -> R {
        fatalError()
    }

    @available(*, unavailable)
    public func reduce<R>(into initialResult: R, _ updateAccumulatingResult: (_ partialResult: inout R, Element) async throws -> Void) async rethrows -> R {
        fatalError()
    }

    @available(*, unavailable)
    public func allSatisfy(_ predicate: (Element) async throws -> Bool) async rethrows -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func flatMap<RE>(_ transform: (Element) async throws -> any AsyncSequence<RE>) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    @available(*, unavailable)
    public func compactMap<RE>(_ transform: (Element) async throws -> RE?) rethrows -> any AsyncSequence<RE> {
        fatalError()
    }

    @available(*, unavailable)
    public func contains(_ element: Element) async -> Bool {
        fatalError()
    }

    @available(*, unavailable)
    public func min() async -> Element? {
        fatalError()
    }

    @available(*, unavailable)
    public func max() async -> Element? {
        fatalError()
    }
}

public protocol AsyncIteratorProtocol<Element> {
    associatedtype Element
    mutating func next() async -> Element?
}

#endif
