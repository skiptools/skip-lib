// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

import kotlin.coroutines.*
import kotlinx.coroutines.*
import kotlinx.coroutines.selects.select
import kotlin.reflect.KClass

/// Kotlin representation of `Swift.Task`.
class Task<T> {
    internal var deferred: Deferred<T>
    private val state = TaskState()

    constructor(priority: TaskPriority? = null, operation: suspend () -> T): this(isMainActor = false, priority = priority, operation = operation) {
    }

    @OptIn(DelicateCoroutinesApi::class)
    constructor(isMainActor: Boolean, scope: CoroutineScope? = null, priority: TaskPriority? = null, operation: suspend () -> T) {
        state.priority = priority ?: Companion.currentState.get()?.priority
        val dispatcher = if (isMainActor) Dispatchers.Main else priority.dispatcher
        // Store a TaskState in our context-aware storage so that we can access it statically in e.g. Task.isCancelled
        deferred = (scope ?: GlobalScope).async(dispatcher + Companion.currentState.asContextElement(state)) {
            operation()
        }
    }

    suspend fun value(): T {
        try {
            return deferred.await()
        } catch (e: CancellationException) {
            cancel() // In case exception did not come from explicit cancel
            throw CancellationError(e)
        }
    }

    fun cancel() {
        val onCancellation: kotlin.Array<() -> Unit>
        synchronized (state) {
            if (state.isCancelled) {
                return
            }
            // In Swift, Task cancellation is cooperative. We simply mark the Task as cancelled and invoke
            // the cancellation handlers rather than cancel the underlying Job
            state.isCancelled = true
            onCancellation = state.onCancellation.toTypedArray()
            state.onCancellation.clear()
        }
        try {
            for (cancellation in onCancellation) {
                cancellation()
            }
        } catch (_: Exception) {
        }
    }

    val isCancelled: Boolean
        get() = synchronized (state) { state.isCancelled }

    companion object {
        private val currentState = ThreadLocal<TaskState?>()

        fun <T> detached(priority: TaskPriority? = null, operation: suspend () -> T): Task<T> = Task(isMainActor = false, priority = priority, operation = operation)

        val isCancelled: Boolean
            get() {
                val state = currentState.get()
                if (state == null) {
                    return false
                } else {
                    synchronized (state) {
                        return state.isCancelled
                    }
                }
            }

        fun checkCancellation() {
            if (isCancelled) {
                throw CancellationError()
            }
        }

        suspend fun sleep(nanoseconds: Long) = sleep(ULong(nanoseconds))
        suspend fun sleep(nanoseconds: ULong) {
            val job = Job()
            withContext(job) {
                withTaskCancellationHandler(operation = {
                    delay(timeMillis = Long(nanoseconds / 1_000_000UL))
                }, onCancel = {
                    job.cancel()
                })
            }
        }

        suspend fun yield() = globalYield()

        /// Internal implementation of global `withTaskCancellationHandler` function.
        internal suspend fun <T> withTaskCancellationHandler(operation: suspend () -> T, onCancel: () -> Unit): T {
            val state = currentState.get()
            if (state == null) {
                // Handle a situation where we're not in a Task for better integration with regular
                // Kotlin async code
                val job = currentCoroutineContext()[Job]
                if (job?.isCancelled == true) {
                    onCancel()
                } else {
                    job?.invokeOnCompletion { cause ->
                        if (cause is CancellationException) {
                            onCancel()
                        }
                    }
                }
                return operation()
            } else {
                var isCancelled = false
                synchronized (state) {
                    isCancelled = state.isCancelled
                    if (!isCancelled) {
                        state.onCancellation.add(onCancel)
                    }
                }
                if (isCancelled) {
                    onCancel()
                    return operation()
                } else {
                    try {
                        return operation()
                    } finally {
                        synchronized (state) { state.onCancellation.remove(onCancel) }
                    }
                }
            }
        }
    }
}

suspend fun <T> withCheckedContinuation(function: String = "", body: (CheckedContinuation<T, Never>) -> Unit): T {
    return suspendCoroutine { continuation ->
        body(CheckedContinuation(continuation = UnsafeContinuation(success = { value ->
            continuation.resume(value)
        }, failure = { error ->
            continuation.resumeWithException(error)
        })))
    }
}

suspend fun <T> withCheckedThrowingContinuation(function: String = "", body: (CheckedContinuation<T, Error>) -> Unit): T {
    return suspendCoroutine { continuation ->
        body(CheckedContinuation(continuation = UnsafeContinuation(success = { value ->
            continuation.resume(value)
        }, failure = { error ->
            continuation.resumeWithException(error as Throwable)
        })))
    }
}


class UnsafeContinuation<T, E> where E : Error  {
    private val success: (T) -> Unit
    private val failure: (E) -> Unit

    internal constructor(success: (T) -> Unit, failure: (E) -> Unit) {
        this.success = success
        this.failure = failure
    }

    fun resume(returning: T) {
        success(returning)
    }

    fun resume(unusedp: Nothing? = null, throwing: E) {
        failure(throwing)
    }
}

class CheckedContinuation<T, E> where E : Error {
    private val continuation: UnsafeContinuation<T, E>

    constructor(continuation: UnsafeContinuation<T, E>, function: String = "") {
        this.continuation = continuation
    }

    fun resume(returning: T) {
        this.continuation.resume(returning = returning)
    }

    fun resume(unusedp: Nothing? = null, throwing: E) {
        this.continuation.resume(throwing = throwing)
    }

    fun resume(unusedp0: Nothing? = null, unusedp1: Nothing? = null, with: Result<T, E>) {
        val result = with
        when (result) {
            is Result.SuccessCase -> {
                val success = result.associated0
                this.continuation.resume(returning = success)
            }
            is Result.FailureCase -> {
                val error = result.associated0
                this.continuation.resume(throwing = error)
            }
        }
    }
}

suspend fun <T> withTaskCancellationHandler(operation: suspend () -> T, onCancel: () -> Unit): T {
    return Task.withTaskCancellationHandler(operation, onCancel)
}

// Use a mutable state holder to be able to set the `Task` status to cancelled. We use a flag rather than
// canceling the underlying `Job` itself because Kotlin cancellation is not cooperative like Swift. A
// cancelled `Job` always causes a `CancellationException` when trying to get its value.
private class TaskState {
    var priority: TaskPriority? = null
    var isCancelled = false
    val onCancellation = mutableListOf<() -> Unit>()
}

/// Allows us to call the global `yield` function from our same-named `Task` function.
private suspend fun globalYield() {
    yield()
}

/// Kotlin representation of `Swift.TaskPriority`.
class TaskPriority(override val rawValue: Int): RawRepresentable<Int> {
    override fun equals(other: Any?): Boolean {
        return rawValue == (other as? TaskPriority)?.rawValue
    }

    override fun hashCode(): Int = rawValue.hashCode()

    companion object {
        val high = TaskPriority(25)
        val medium = TaskPriority(21)
        val low = TaskPriority(17)
        val userInitiated = high
        val utility = low
        val background = TaskPriority(9)
    }
}

private val TaskPriority?.dispatcher: CoroutineDispatcher
    // Priorities and Dispatchers are not equivalent. Dispatchers.Default is supposedly designed for CPU-intensive
    // operations, while Dispatchers.IO is designed for IO operations. We expect CPU operations to be shorter than
    // IO ones, so perhaps Dispatchers.Default will be better for our high priority tasks that probably don't involve
    // a lot of waiting, while Dispatchers.IO will be better for background tasks that don't mind being preempted
    get() = if (this == TaskPriority.high) Dispatchers.Default else Dispatchers.IO

/// Kotlin representation of `Swift.TaskGroup` as well as its Discarding and Throwing variants.
open class TaskGroup<ChildTaskResult>(private val throwErrors: Boolean = false): AsyncSequence<ChildTaskResult> {
    private val coroutineScope = CoroutineScope(Job())
    private val tasks = mutableListOf<Task<Result<ChildTaskResult, Error>>>()
    private var _isCancelled = false

    fun addTask(priority: TaskPriority? = null, operation: suspend () -> ChildTaskResult) {
        // We create an actual Task so that the running code has access to cancellation context, etc.
        // An exception in one Task should not fail the group unless it escapes, so we collect the
        // success and exception values in a Result for each Task
        val task: Task<Result<ChildTaskResult, Error>> = Task(isMainActor = false, scope = coroutineScope, priority) {
            try {
                val success = operation()
                Result.success(success)
            } catch (e: CancellationException) {
                Result.failure(CancellationError(e))
            } catch (e: Exception) {
                val error = (e as? Error) ?: ErrorException(e)
                Result.failure(error)
            }
        }
        if (isCancelled) {
            task.cancel()
        }
        tasks.add(task)
    }

    fun addTaskUnlessCancelled(priority: TaskPriority? = null, operation: suspend () -> ChildTaskResult): Boolean {
        if (isCancelled) {
            return false
        }
        addTask(priority, operation)
        return true
    }

    suspend fun next(): ChildTaskResult? {
        val result = nextResult()
        if (result == null) {
            return null
        }
        try {
            return result.get()
        } catch (e: Exception) {
            if (throwErrors) {
                throw e
            } else {
                return null
            }
        }
    }

    suspend fun nextResult(): Result<ChildTaskResult, Error>? {
        if (isCancelled) {
            return null
        }
        if (tasks.isEmpty()) {
            return null
        }
        try {
            return select<Result<ChildTaskResult, Error>> {
                tasks.withIndex().forEach { (index, task) ->
                    task.deferred.onAwait {
                        // Remove Tasks as they are consumed
                        tasks.removeAt(index)
                        it
                    }
                }
            }
        } catch (_: CancellationException) { // Parent Task's Job was cancelled?
            return null
        }
    }

    suspend fun waitForAll() {
        try {
            val deferreds = tasks.map { it.deferred }
            if (!deferreds.isEmpty()) {
                deferreds.awaitAll()
            }
        } catch (_: CancellationException) { // Parent Task's Job was cancelled?
        }
    }

    val isEmpty: Boolean
        get() = tasks.isEmpty()

    fun cancelAll() {
        _isCancelled = true
        // Cancellation is cooperative
        tasks.forEach { it.cancel() }
    }

    val isCancelled: Boolean
        get() = _isCancelled

    override fun makeAsyncIterator(): Iterator<ChildTaskResult> {
        return Iterator(this)
    }

    class Iterator<ChildTaskResult>(private val taskGroup: TaskGroup<ChildTaskResult>): AsyncIteratorProtocol<ChildTaskResult> {
        override suspend fun next(): ChildTaskResult? {
            return taskGroup.next()
        }

        fun cancel() {
            taskGroup.cancelAll()
        }
    }
}

/// In Kotlin, `ThrowingTaskGroup` is just a `TaskGroup` that throws encountered errors.
class ThrowingTaskGroup<ChildTaskResult>: TaskGroup<ChildTaskResult>(throwErrors = true) {
}

/// In Kotlin, `DiscardingTaskGroup` is just a subset of a `TaskGroup` with `Unit` result type.
class DiscardingTaskGroup: TaskGroup<Unit>() {
}

/// In Kotlin, `ThrowingDiscardingTaskGroup` is just a subset of a `TaskGroup` with `Unit` result
// type that throws errors.
class ThrowingDiscardingTaskGroup: TaskGroup<Unit>(throwErrors = true) {
}

suspend fun <ChildTaskResult, GroupResult> withTaskGroup(of: KClass<ChildTaskResult>, returning: KClass<GroupResult>? = null, body: suspend (TaskGroup<ChildTaskResult>) -> GroupResult): GroupResult where ChildTaskResult : Any, GroupResult: Any {
    val taskGroup = TaskGroup<ChildTaskResult>()
    return withTaskCancellationHandler(operation = {
        try {
            body(taskGroup)
        } finally {
            taskGroup.waitForAll()
        }
    }, onCancel = {
        taskGroup.cancelAll()
    })
}

suspend fun <GroupResult> withDiscardingTaskGroup(returning: KClass<GroupResult>? = null, body: suspend (DiscardingTaskGroup) -> GroupResult): GroupResult where GroupResult: Any {
    val discardingTaskGroup = DiscardingTaskGroup()
    return withTaskCancellationHandler(operation = {
        try {
            body(discardingTaskGroup)
        } finally {
            discardingTaskGroup.waitForAll()
        }
    }, onCancel = {
        discardingTaskGroup.cancelAll()
    })
}

suspend fun <ChildTaskResult, GroupResult> withThrowingTaskGroup(of: KClass<ChildTaskResult>, returning: KClass<GroupResult>? = null, body: suspend (ThrowingTaskGroup<ChildTaskResult>) -> GroupResult): GroupResult where ChildTaskResult : Any, GroupResult: Any {
    val taskGroup = ThrowingTaskGroup<ChildTaskResult>()
    return withTaskCancellationHandler(operation = {
        try {
            body(taskGroup)
        } catch (e: Exception) {
            taskGroup.cancelAll()
            throw e
        } finally {
            taskGroup.waitForAll()
        }
    }, onCancel = {
        taskGroup.cancelAll()
    })
}

suspend fun <GroupResult> withThrowingDiscardingTaskGroup(returning: KClass<GroupResult>? = null, body: suspend (ThrowingDiscardingTaskGroup) -> GroupResult): GroupResult where GroupResult: Any {
    val discardingTaskGroup = ThrowingDiscardingTaskGroup()
    return withTaskCancellationHandler(operation = {
        try {
            body(discardingTaskGroup)
        } catch (e: Exception) {
            discardingTaskGroup.cancelAll()
            throw e
        } finally {
            discardingTaskGroup.waitForAll()
        }
    }, onCancel = {
        discardingTaskGroup.cancelAll()
    })
}

/// Kotlin representation of `Swift.AnyActor`.
interface AnyActor {
}

/// Kotlin representation of `Swift.Actor`.
interface Actor: AnyActor {
    val isolatedContext: CoroutineContext

    companion object {
        /// Factory for actor contexts.
        @OptIn(ExperimentalCoroutinesApi::class)
        fun isolatedContext(): CoroutineContext {
            return Dispatchers.Default.limitedParallelism(1)
        }

        /// Run a block on the given actor.
        suspend fun <T> run(actor: Actor, body: suspend () -> T): T {
            if (coroutineContext[ContinuationInterceptor] == actor.isolatedContext[ContinuationInterceptor]) {
                return body()
            } else {
                return withContext(actor.isolatedContext) {
                    body()
                }
            }
        }
    }
}

class MainActor {
    companion object {
        /// Run a block on the main actor.
        ///
        /// The Swift version of `MainActor.run()` takes a non-async closure. Because we have to transpile
        /// in calls around main actor-bound code that may contains async sub-expressions, however, we
        /// need the closure to be suspending. E.g. to transpile:
        ///   await mainActorFunc(arg: suspendingFunc())
        /// we generate code like:
        ///   MainActor.run { mainActorFunc(arg = suspendingFunc()) }
        suspend fun <T> run(body: suspend () -> T): T {
            return withContext(Dispatchers.Main.immediate) {
                body()
            }
        }
    }
}

/// Extension member function that executes a block on the main actor.
///
/// The transpiler generates calls to `mainactor()` when moving main actor-bound code back to the main
/// thread in async call chains.
suspend fun <T, R> T.mainactor(perform: suspend (T) -> R): R {
    val self = this
    return withContext(Dispatchers.Main.immediate) {
        perform(self)
    }
}

/// Run an async block.
///
/// The transpiler generates calls to `Async.run()` for the bodies of non-actor-bound async funcs and closures.
class Async {
    companion object {
        suspend fun <T> run(operation: suspend () -> T): T {
            return withContext(Dispatchers.Default) {
                operation()
            }
        }
    }
}

/// Allow use of `Swift.Sendable`.
typealias Sendable = Any

/// Kotlin representation of `Swift.CancellationError` when a `Task` is cancelled.
class CancellationError(cause: Throwable? = null): Exception(cause), Error {
}

/// Kotlin representation of `Swift.AsyncSequence` that can be used in Kotlin for-in loops.
interface AsyncSequence<Element> {
    fun makeAsyncIterator(): AsyncIteratorProtocol<Element>

    /// We can't implement Iterable and return a true `Iterator`, because we have to use suspending functions.
    operator fun iterator() = AsyncSequenceIterator(makeAsyncIterator())

    fun <RE> map(transform: suspend (Element) -> RE): AsyncSequence<RE> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<RE> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<RE> {
                return object: AsyncIteratorProtocol<RE> {
                    override suspend fun next(): RE? {
                        val next = itr.next()
                        return if (next == null) null else transform(next)
                    }
                }
            }
        }
    }

    fun filter(isIncluded: suspend (Element) -> Boolean): AsyncSequence<Element> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<Element> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<Element> {
                return object: AsyncIteratorProtocol<Element> {
                    override suspend fun next(): Element? {
                        while (true) {
                            val next = itr.next()
                            if (next == null) {
                                return null
                            } else if (isIncluded(next)) {
                                return next
                            }
                        }
                    }
                }
            }
        }
    }

    suspend fun first(where: suspend (Element) -> Boolean): Element? {
        val itr = makeAsyncIterator()
        while (true) {
            val next = itr.next()
            if (next == null) {
                return null
            } else if (where(next)) {
                return next
            }
        }
    }

    fun dropFirst(k: Int = 1): AsyncSequence<Element> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<Element> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<Element> {
                return object: AsyncIteratorProtocol<Element> {
                    private var hasDropped = false
                    override suspend fun next(): Element? {
                        if (!hasDropped) {
                            hasDropped = true
                            for (i in 0..<k) {
                                if (itr.next() == null) {
                                    return null
                                }
                            }
                        }
                        return itr.next()
                    }
                }
            }
        }
    }

    fun drop(while_: suspend (Element) -> Boolean): AsyncSequence<Element> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<Element> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<Element> {
                return object: AsyncIteratorProtocol<Element> {
                    private var hasDropped = false
                    override suspend fun next(): Element? {
                        if (!hasDropped) {
                            hasDropped = true
                            while (true) {
                                val next = itr.next()
                                if (next == null) {
                                    return null
                                } else if (!while_(next)) {
                                    return next
                                }
                            }
                        } else {
                            return itr.next()
                        }
                    }
                }
            }
        }
    }

    fun prefix(maxLength: Int): AsyncSequence<Element> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<Element> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<Element> {
                return object: AsyncIteratorProtocol<Element> {
                    private var remaining = maxLength
                    override suspend fun next(): Element? {
                        if (remaining == 0) {
                            return null
                        }
                        val next = itr.next()
                        if (next == null) {
                            return null
                        }
                        remaining--
                        return next
                    }
                }
            }
        }
    }

    fun prefix(while_: suspend (Element) -> Boolean): AsyncSequence<Element> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<Element> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<Element> {
                return object: AsyncIteratorProtocol<Element> {
                    override suspend fun next(): Element? {
                        val next = itr.next()
                        if (next == null || !while_(next)) {
                            return null
                        }
                        return next
                    }
                }
            }
        }
    }

    suspend fun min(by: suspend (Element, Element) -> Boolean): Element? {
        val itr = makeAsyncIterator()
        var min: Element? = null
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else if (min == null || by(next, min)) {
                min = next
            }
        }
        return min
    }

    suspend fun max(by: suspend (Element, Element) -> Boolean): Element? {
        val itr = makeAsyncIterator()
        var max: Element? = null
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else if (max == null || by(max, next)) {
                max = next
            }
        }
        return max
    }

    suspend fun contains(where_: suspend (Element) -> Boolean): Boolean {
        val itr = makeAsyncIterator()
        while (true) {
            val next = itr.next()
            if (next == null) {
                return false
            } else if (where_(next)) {
                return true
            }
        }
    }

    // WARNING: Although `initialResult` is not a labeled parameter in Swift, the transpiler inserts it
    // into our Kotlin call sites to differentiate between calls to the two `reduce()` functions. Do not change
    suspend fun <R> reduce(initialResult: R, nextPartialResult: suspend (R, Element) -> R): R {
        val itr = makeAsyncIterator()
        var result = initialResult
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else {
                result = nextPartialResult(result, next)
            }
        }
        return result
    }

    suspend fun <R> reduce(unusedp: Nothing? = null, into: R, updateAccumulatingResult: suspend (InOut<R>, Element) -> Unit): R {
        val itr = makeAsyncIterator()
        var result = into
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else {
                updateAccumulatingResult(InOut({ result }, { result = it }), next)
            }
        }
        return result
    }

    suspend fun allSatisfy(predicate: suspend (Element) -> Boolean): Boolean {
        val itr = makeAsyncIterator()
        while (true) {
            val next = itr.next()
            if (next == null) {
                return true
            } else if (!predicate(next)) {
                return false
            }
        }
    }

    fun <RE> flatMap(transform: suspend (Element) -> AsyncSequence<RE>): AsyncSequence<RE> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<RE> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<RE> {
                return object: AsyncIteratorProtocol<RE> {
                    private var currentItr: AsyncIteratorProtocol<RE>? = null
                    override suspend fun next(): RE? {
                        while (true) {
                            if (currentItr == null) {
                                val next = itr.next()
                                if (next == null) {
                                    return null
                                } else {
                                    currentItr = transform(next).makeAsyncIterator()
                                }
                            } else {
                                val next = currentItr!!.next()
                                if (next == null) {
                                    currentItr = null
                                } else {
                                    return next
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    fun <RE> compactMap(transform: suspend (Element) -> RE?): AsyncSequence<RE> {
        val itr = makeAsyncIterator()
        return object: AsyncSequence<RE> {
            override fun makeAsyncIterator(): AsyncIteratorProtocol<RE> {
                return object: AsyncIteratorProtocol<RE> {
                    override suspend fun next(): RE? {
                        while (true) {
                            val next = itr.next()
                            if (next == null) {
                                return null
                            } else {
                                val re = transform(next)
                                if (re != null) {
                                    return re
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    suspend fun contains(element: Element): Boolean {
        val itr = makeAsyncIterator()
        while (true) {
            val next = itr.next()
            if (next == null) {
                return false
            } else if (next == element) {
                return true
            }
        }
    }

    suspend fun min(): Element? {
        val itr = makeAsyncIterator()
        var min: Element? = null
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else if (min == null || (next as Comparable<Element>) < min) {
                min = next
            }
        }
        return min
    }

    suspend fun max(): Element? {
        val itr = makeAsyncIterator()
        var max: Element? = null
        while (true) {
            val next = itr.next()
            if (next == null) {
                break
            } else if (max == null || (next as Comparable<Element>) > max) {
                max = next
            }
        }
        return max
    }
}

class AsyncSequenceIterator<Element>(private val iter: AsyncIteratorProtocol<Element>) {
    private var cachedNext: Element? = null
    private var hasCachedNext = false

    operator suspend fun hasNext(): Boolean {
        if (!hasCachedNext) {
            cachedNext = iter.next()
            hasCachedNext = true
        }
        return cachedNext != null
    }

    operator suspend fun next(): Element {
        if (hasCachedNext) {
            val next = cachedNext!!
            cachedNext = null
            hasCachedNext = false
            return next
        }
        return iter.next()!!
    }
}

interface AsyncIteratorProtocol<Element> {
    suspend fun next(): Element?
}
