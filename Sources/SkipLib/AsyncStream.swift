// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

import kotlinx.coroutines.channels.BufferOverflow
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.consumeAsFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.launch

public final class AsyncStream<Element>: AsyncSequence, KotlinConverting<Flow<Element>> where Element: Any {
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
            channel.close()
            if let onTermination {
                self.onTermination = nil
                onTermination(Termination.finished)
            }
        }

        public var onTermination: ((Termination) -> Void)?
    }

    var continuation: Continuation<Element>? // Internal for makeStream()
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

    public init(flow: Flow<Element>, bufferingPolicy limit: Continuation.BufferingPolicy = Continuation.BufferingPolicy.unbounded) {
        self.init(nil, limit, { continuation in
            Task {
                flow.collect { value in
                    continuation.yield(value)
                }
                continuation.finish()
            }
        })
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
            do {
                if let channel = stream.continuation?.channel {
                    let result = channel.receiveCatching()
                    return result.getOrNull()
                } else if let producer = stream.producer {
                    return producer()
                } else {
                    return nil
                }
            } catch is CancellationError {
                if let onCancel = stream.onCancel {
                    stream.onCancel = nil
                } else if let onTermination = stream.continuation?.onTermination {
                    stream.continuation?.onTermination = nil
                    onTermination(AsyncStream.Continuation.Termination.cancelled)
                }
                return nil
            }
        }
    }

    public override func kotlin(nocopy: Bool = false) -> Flow<Element> {
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

#endif
