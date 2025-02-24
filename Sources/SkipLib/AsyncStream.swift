// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine
import kotlinx.coroutines.launch
import kotlinx.coroutines.channels.BufferOverflow
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.consumeAsFlow
import kotlinx.coroutines.flow.flow

public final class AsyncStream<Element>: AsyncSequence, SwiftCustomBridged, KotlinConverting<kotlinx.coroutines.flow.Flow<Element>> where Element: Any {
    // SKIP NOWARN
    public final class Continuation<Element> : Sendable {
        // SKIP NOWARN
        public enum Termination: Hashable {
            case finished
            case cancelled
        }

        // SKIP NOWARN
        public enum YieldResult<Element> {
            case enqueued(remaining: Int)
            case dropped(Element)
            case terminated
        }

        // SKIP NOWARN
        public enum BufferingPolicy {
            case unbounded
            case bufferingOldest(Int)
            case bufferingNewest(Int)
        }

        let channel: Channel<Element>

        public init(channel: Channel<Element>) {
            self.channel = channel
        }

        public func yield(_ value: Element) -> YieldResult<Element> {
            let result = channel.trySend(value)
            if result.isClosed {
                return YieldResult.terminated
            } else if result.isFailure {
                return YieldResult.dropped(value)
            } else {
                return YieldResult.enqueued(remaining: 0)
            }
        }

        public func yield(with result: Result<Element, Never>) -> YieldResult<Element> {
            if case .success(let success) = result {
                return yield(success)
            } else {
                finish()
                return YieldResult.terminated
            }
        }

        public func yield() -> YieldResult<Element> {
            yield(() as! Element)
        }

        public func finish() {
            let _ = channel.close()
        }

        public var onTermination: ((Termination) -> Void)?
    }

    var continuation: Continuation<Element>? // Internal for makeStream()

    public private(set) var swiftDataSource: AsyncStreamSwiftDataSource<Element>? // Bridging support
    private var producer: (() async -> Element?)?
    private var onCancel: (() -> Void)?

    public init(_ elementType: Element.Type? = nil, bufferingPolicy limit: Continuation.BufferingPolicy = Continuation.BufferingPolicy.unbounded, _ build: (Continuation<Element>) -> Void) {
        let channel: Channel<Element>
        switch limit {
        case .bufferingNewest(let capacity):
            channel = Channel<Element>(capacity, onBufferOverflow: BufferOverflow.DROP_OLDEST)
        case .bufferingOldest(let capacity):
            channel = Channel<Element>(capacity, onBufferOverflow: BufferOverflow.DROP_LATEST)
        case .unbounded:
            channel = Channel<Element>(Channel.UNLIMITED)
        }
        self.continuation = Continuation<Element>(channel: channel)
        build(continuation!)
    }

    public init(unfolding producer: () async -> Element?, onCancel: (() -> Void)? = nil) {
        self.producer = producer
        self.onCancel = onCancel
    }

    public init(flow: kotlinx.coroutines.flow.Flow<Element>, bufferingPolicy limit: Continuation.BufferingPolicy = Continuation.BufferingPolicy.unbounded) {
        self.init(nil, limit, { continuation in
            Task {
                flow.collect { value in
                    continuation.yield(value)
                }
                continuation.finish()
            }
        })
    }

    public init(swiftDataSource: AsyncStreamSwiftDataSource<Element>) {
        self.swiftDataSource = swiftDataSource
        self.producer = { await swiftDataSource.next() }
    }

    public func makeAsyncIterator() -> Iterator<Element> {
        return Iterator<Element>(stream: self)
    }

    public static func makeStream<Element>(of elementType: Element.Type? = nil, bufferingPolicy limit: Continuation.BufferingPolicy = AsyncStream.Continuation.BufferingPolicy.unbounded) -> (stream: AsyncStream<Element>, continuation: Continuation<Element>) where Element: Any {
        let stream = AsyncStream<Element>(bufferingPolicy: limit) { _ in }
        return (stream, stream.continuation!)
    }

    // SKIP NOWARN
    public final class Iterator<Element>: AsyncIteratorProtocol where Element: Any {
        private let stream: AsyncStream<Element>

        init(stream: AsyncStream<Element>) {
            self.stream = stream
        }

        public mutating func next() async throws -> Element? {
            if Task.isCancelled {
                onCancel()
                return nil
            }
            withTaskCancellationHandler {
                if let channel = stream.continuation?.channel {
                    let result = channel.receiveCatching()
                    if result.isClosed {
                        if let onTermination = stream.continuation?.onTermination {
                            stream.continuation?.onTermination = nil
                            onTermination(Continuation.Termination.finished)
                        }
                        return nil
                    } else {
                        return result.getOrNull()
                    }
                } else if let producer = stream.producer {
                    return producer()
                } else {
                    return nil
                }
            } onCancel: {
                onCancel()
            }
        }

        private func onCancel() {
            stream.continuation?.channel.close()
            if let onTermination = stream.continuation?.onTermination {
                stream.continuation?.onTermination = nil
                onTermination(AsyncStream.Continuation.Termination.cancelled)
            } else if let onCancel = stream.onCancel {
                stream.onCancel = nil
                onCancel()
            }
        }
    }

    public override func kotlin(nocopy: Bool = false) -> kotlinx.coroutines.flow.Flow<Element> {
        if let channel = continuation?.channel {
            return channel.consumeAsFlow()
        } else if let producer {
            return flow {
                while true {
                    if let value = producer() {
                        emit(value)
                    } else {
                        break
                    }
                }
            }
        } else {
            return flow { }
        }
    }
}

// Unfortunately because of minor API differences between `AsyncStream` and `AsyncThrowingStream`, we can't
// really share any code between them

public final class AsyncThrowingStream<Element, Failure>: AsyncSequence, SwiftCustomBridged, KotlinConverting<kotlinx.coroutines.flow.Flow<Element>> where Element: Any, Failure: Error {
    // SKIP NOWARN
    public final class Continuation<Element, Failure> : Sendable where Element: Any, Failure: Error {
        // SKIP NOWARN
        public enum Termination<Failure>: Hashable {
            case finished(Failure?)
            case cancelled
        }

        // SKIP NOWARN
        public enum YieldResult<Element> {
            case enqueued(remaining: Int)
            case dropped(Element)
            case terminated
        }

        // SKIP NOWARN
        public enum BufferingPolicy {
            case unbounded
            case bufferingOldest(Int)
            case bufferingNewest(Int)
        }

        let channel: Channel<Element>
        var terminationError: Failure?

        public init(channel: Channel<Element>) {
            self.channel = channel
        }

        public func yield(_ value: Element) -> YieldResult<Element> {
            let result = channel.trySend(value)
            if result.isClosed {
                return YieldResult.terminated
            } else if result.isFailure {
                return YieldResult.dropped(value)
            } else {
                return YieldResult.enqueued(remaining: 0)
            }
        }

        public func yield(with result: Result<Element, Failure>) -> YieldResult<Element> {
            switch result {
            case .success(let success):
                return yield(success)
            case .failure(let error):
                finish(throwing: error)
                return YieldResult.terminated
            }
        }

        public func yield() -> YieldResult<Element> {
            yield(() as! Element)
        }

        public func finish(throwing error: Failure? = nil) {
            channel.close()
            terminationError = error
        }

        public var onTermination: ((Termination) -> Void)?
    }

    var continuation: Continuation<Element, Failure>? // Internal for makeStream()

    public private(set) var swiftDataSource: AsyncThrowingStreamSwiftDataSource<Element>? // Bridging support
    private var producer: (() async throws -> Element?)?
    private var onCancel: (() -> Void)?

    public init(_ elementType: Element.Type? = nil, bufferingPolicy limit: Continuation.BufferingPolicy = Continuation.BufferingPolicy.unbounded, _ build: (Continuation<Element, Failure>) -> Void) {
        let channel: Channel<Element>
        switch limit {
        case .bufferingNewest(let capacity):
            channel = Channel<Element>(capacity, onBufferOverflow: BufferOverflow.DROP_OLDEST)
        case .bufferingOldest(let capacity):
            channel = Channel<Element>(capacity, onBufferOverflow: BufferOverflow.DROP_LATEST)
        case .unbounded:
            channel = Channel<Element>(Channel.UNLIMITED)
        }
        self.continuation = Continuation<Element, Failure>(channel: channel)
        build(continuation!)
    }

    public init(unfolding producer: () async throws -> Element?, onCancel: (() -> Void)? = nil) {
        self.producer = producer
        self.onCancel = onCancel
    }

    public init(flow: kotlinx.coroutines.flow.Flow<Element>, bufferingPolicy limit: Continuation.BufferingPolicy = Continuation.BufferingPolicy.unbounded) {
        self.init(nil, limit, { continuation in
            Task {
                do {
                    flow.collect { value in
                        continuation.yield(value)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error as? Failure)
                }
            }
        })
    }

    public init(swiftDataSource: AsyncThrowingStreamSwiftDataSource<Element>) {
        self.swiftDataSource = swiftDataSource
        self.producer = { try await swiftDataSource.next() }
    }

    public func makeAsyncIterator() -> Iterator<Element, Failure> {
        return Iterator<Element, Failure>(stream: self)
    }

    // SKIP NOWARN
    public static func makeStream<Element>(of elementType: Element.Type? = nil, throwing failureType: Any.Type? = nil, bufferingPolicy limit: Continuation.BufferingPolicy = AsyncThrowingStream.Continuation.BufferingPolicy.unbounded) -> (stream: AsyncThrowingStream<Element, Error>, continuation: Continuation<Element, Error>) where Element: Any {
        let stream = AsyncThrowingStream<Element, Error>(bufferingPolicy: limit) { _ in }
        return (stream, stream.continuation!)
    }

    // SKIP NOWARN
    public final class Iterator<Element, Failure>: AsyncIteratorProtocol where Element: Any, Failure: Error {
        private let stream: AsyncThrowingStream<Element, Failure>

        init(stream: AsyncThrowingStream<Element, Failure>) {
            self.stream = stream
        }

        public mutating func next() async throws -> Element? {
            if Task.isCancelled {
                onCancel()
                return nil
            }
            withTaskCancellationHandler {
                if let channel = stream.continuation?.channel {
                    let result = channel.receiveCatching()
                    if result.isClosed {
                        let terminationError = stream.continuation?.terminationError
                        stream.continuation?.terminationError = nil
                        if let onTermination = stream.continuation?.onTermination {
                            stream.continuation?.onTermination = nil
                            onTermination(Continuation.Termination.finished(terminationError))
                        }
                        if let terminationError {
                            throw terminationError as! Throwable
                        } else {
                            return nil
                        }
                    } else {
                        return result.getOrThrow()
                    }
                } else if let producer = stream.producer {
                    return producer()
                } else {
                    return nil
                }
            } onCancel: {
                onCancel()
            }
        }

        private func onCancel() {
            stream.continuation?.channel.close()
            if let onTermination = stream.continuation?.onTermination {
                stream.continuation?.onTermination = nil
                onTermination(AsyncThrowingStream.Continuation.Termination.cancelled)
            } else if let onCancel = stream.onCancel {
                stream.onCancel = nil
                onCancel()
            }
        }
    }

    public override func kotlin(nocopy: Bool = false) -> kotlinx.coroutines.flow.Flow<Element> {
        if let channel = continuation?.channel {
            return channel.consumeAsFlow()
        } else if let producer {
            return flow {
                while true {
                    if let value = producer() {
                        emit(value)
                    } else {
                        break
                    }
                }
            }
        } else {
            return flow { }
        }
    }
}

// MARK: Bridge Support

public final class AsyncStreamBridgingDataSource {
    private var stream: AsyncStream<Any>?
    private var throwingStream: AsyncThrowingStream<Any, Error>?
    private var flow: kotlinx.coroutines.flow.Flow<Any>?

    public init(stream: AsyncStream<Any>) {
        self.stream = stream
    }

    public init(stream: AsyncThrowingStream<Any, Error>) {
        self.throwingStream = stream
    }

    public init(flow: kotlinx.coroutines.flow.Flow<Any>) {
        self.flow = flow
    }

    public func collect(onNext: (Any) -> Void, onFinish: (Throwable?) -> Void) {
        Task {
            if let stream {
                let itr = stream.makeAsyncIterator()
                while let next = await itr.next() {
                    onNext(next)
                }
                onFinish(nil)
            } else if let throwingStream {
                let itr = throwingStream.makeAsyncIterator()
                do {
                    while let next = try await itr.next() {
                        onNext(next)
                    }
                    onFinish(nil)
                } catch {
                    onFinish(error as? Throwable)
                }
            } else if let flow {
                do {
                    flow.collect {
                        onNext($0)
                    }
                    onFinish(nil)
                } catch {
                    onFinish(error as? Throwable)
                }
            }
        }
    }
}

public final class AsyncStreamSwiftDataSource<Element> {
    public private(set) var Swift_producer: Int64

    public init(Swift_producer: Int64) {
        self.Swift_producer = Swift_producer
    }

    deinit {
        Swift_producer = Swift_release(Swift_producer)
    }

    public func next() async throws -> Element? {
        suspendCoroutine { continuation in
            Swift_next(Swift_producer) { element in
                continuation.resume(element as? Element)
            }
        }
    }

    public func asFlow() -> kotlinx.coroutines.flow.Flow<Element> {
        return flow {
            while true {
                if let value = next() {
                    emit(value)
                } else {
                    break
                }
            }
        }
    }

    // @JvmName is needed for test cases, as the name is otherwise mangled to append "$SkipLib_debug"
    // SKIP INSERT: @JvmName("Swift_next")
    // SKIP EXTERN
    func Swift_next(Swift_producer: Int64, callback: (Any?) -> Void)
    // SKIP EXTERN
    func Swift_release(Swift_producer: Int64) -> Int64
}

public final class AsyncThrowingStreamSwiftDataSource<Element> {
    public private(set) var Swift_producer: Int64

    public init(Swift_producer: Int64) {
        self.Swift_producer = Swift_producer
    }

    deinit {
        Swift_producer = Swift_release(Swift_producer: Swift_producer)
    }

    public func next() async throws -> Element? {
        suspendCoroutine { continuation in
            Swift_next(Swift_producer) { element, error in
                if let error {
                    continuation.resumeWithException(error)
                } else {
                    continuation.resume(element as? Element)
                }
            }
        }
    }

    public func asFlow() -> kotlinx.coroutines.flow.Flow<Element> {
        return flow {
            while true {
                if let value = next() {
                    emit(value)
                } else {
                    break
                }
            }
        }
    }

    // @JvmName is needed for test cases, as the name is otherwise mangled to append "$SkipLib_debug"
    // SKIP INSERT: @JvmName("Swift_next")
    // SKIP EXTERN
    func Swift_next(Swift_producer: Int64, callback: (Any?, Throwable?) -> Void)
    // SKIP EXTERN
    func Swift_release(Swift_producer: Int64) -> Int64
}

#endif
