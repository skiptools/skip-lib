// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

// WARNING: Replicate all implemented immutable Sequence, Collections API in String.kt

// We use a Storage model wrapping internal Kotlin collections rather than implementing the collection
// interfaces directly (other than Iterable) for two reasons:
// 1. To avoid API conflicts
// 2. To be able to control when we sref() efficiently

/// Base iterable support on which we can implement `Swift.Sequence`.
interface IterableStorage<Element>: Iterable<Element> {
    // Kotlin iterable, not sref'd
    val iterable: Iterable<Element>

    // Iterator to use when content is exposed to consuming code - elements are sref'd
    override fun iterator(): Iterator<Element> {
        val iter = iterable.iterator()
        return object: Iterator<Element> {
            override fun hasNext(): Boolean = iter.hasNext()
            override fun next(): Element = iter.next().sref()
        }
    }
}

/// Extended collection support on which we can implement `Swift.Collection`.
interface CollectionStorage<Element>: IterableStorage<Element> {
    // Kotlin collections, not sref'd
    val collection: kotlin.collections.Collection<Element>
        get() = mutableCollection
    val mutableCollection: kotlin.collections.MutableCollection<Element>

    // Indexing to support slices
    val storageStartIndex: Int
        get() = 0
    val storageEndIndex: Int? // Exclusive, null = end of collection
        get() = null
    val effectiveStorageEndIndex: Int
        get() = storageEndIndex ?: collection.size

    // Callbacks
    fun willSliceStorage() = Unit
    fun willMutateStorage() = Unit
    fun didMutateStorage() = Unit

    override val iterable: Iterable<Element>
        get() {
            // If we're not a slice, we can return the native Kotlin collection
            if (storageStartIndex == 0 && storageEndIndex == null) {
                return collection
            }
            return object: Iterable<Element> {
                override fun iterator(): Iterator<Element> {
                    return object: Iterator<Element> {
                        private var index = storageStartIndex
                        override fun hasNext(): Boolean = index < effectiveStorageEndIndex
                        override fun next(): Element = collection.elementAt(index++)
                    }
                }
            }
        }
}

/// Extended mutable support on which we can implement `Swift.MutableCollection`, `Swift.RangeReplacableCollection`, etc.
interface MutableListStorage<Element>: CollectionStorage<Element> {
    val mutableList: MutableList<Element>

    override val mutableCollection: kotlin.collections.MutableCollection<Element>
        get() = mutableList
}

/// Kotlin representation of Swift.Sequence.
interface Sequence<Element>: IterableStorage<Element> {
    fun makeIterator(): IteratorProtocol<Element> {
        val iter = iterator()
        return object: IteratorProtocol<Element> {
            override fun next(): Element? {
                return if (iter.hasNext()) iter.next() else null
            }
        }
    }

    val underestimatedCount: Int
        get() = 0

    fun <T> withContiguousStorageIfAvailable(body: (Any) -> T): T? = null

    fun shuffled(using: InOut<RandomNumberGenerator>? = null): Array<Element> {
        val list = ArrayList<Element>()
        list.addAll(iterable)
        list.shuffle(using)
        return Array(list, nocopy = true)
    }

    fun <RE> map(transform: (Element) -> RE): Array<RE> {
        return transformToArray { it.map(transform) }
    }

    fun forEach(body: (Element) -> Unit) {
        iterable.forEach(body)
    }

    fun first(where: (Element) -> Boolean): Element? {
        return iterable.firstOrNull(where).sref()
    }

    fun suffix(maxLength: Int): Array<Element> {
        val numberToDrop = max(0, iterable.count() - maxLength)
        return dropFirst(numberToDrop)
    }

    fun dropFirst(k: Int = 1): Array<Element> {
        return transformToArray { it.drop(k) }
    }

    fun dropLast(k: Int = 1): Array<Element> {
        return transformToArray { it.toList().dropLast(k) }
    }

    fun drop(while_: (Element) -> Boolean): Array<Element> {
        return transformToArray { it.dropWhile(while_) }
    }

    fun prefix(maxLength: Int): Array<Element> {
        return transformToArray { it.take(maxLength) }
    }

    fun prefix(while_: (Element) -> Boolean): Array<Element> {
        return transformToArray { it.takeWhile(while_) }
    }

    fun enumerated(): Sequence<Tuple2<Int, Element>> {
        val enumeratedIterable = object: Iterable<Tuple2<Int, Element>> {
            override fun iterator(): Iterator<Tuple2<Int, Element>> {
                var offset = 0
                val iter = this@Sequence.iterator()
                return object: Iterator<Tuple2<Int, Element>> {
                    override fun hasNext(): Boolean = iter.hasNext()
                    override fun next(): Tuple2<Int, Element> = Tuple2(offset++, iter.next())
                }
            }
        }
        return object: Sequence<Tuple2<Int, Element>> {
            override val iterable: Iterable<Tuple2<Int, Element>>
                get() = enumeratedIterable
        }
    }

    fun min(): Element? {
        return iterable.minWithOrNull(object: Comparator<Element> {
            override fun compare(p0: Element, p1: Element): Int {
                @Suppress("UNCHECKED_CAST")
                return (p0 as Comparable<Element>).compareTo(p1)
            }
        })
    }

    fun min(by: (Element, Element) -> Boolean): Element? {
        return iterable.minWithOrNull(object: Comparator<Element> {
            override fun compare(p0: Element, p1: Element): Int {
                if (by(p0, p1)) {
                    return -1
                } else if (by(p1, p0)) {
                    return 1
                } else {
                    return 0
                }
            }
        })
    }

    fun max(): Element? {
        return iterable.maxWithOrNull(object: Comparator<Element> {
            override fun compare(p0: Element, p1: Element): Int {
                @Suppress("UNCHECKED_CAST")
                return (p0 as Comparable<Element>).compareTo(p1)
            }
        })
    }

    fun max(by: (Element, Element) -> Boolean): Element? {
        return iterable.maxWithOrNull(object: Comparator<Element> {
            override fun compare(p0: Element, p1: Element): Int {
                if (by(p0, p1)) {
                    return -1
                } else if (by(p1, p0)) {
                    return 1
                } else {
                    return 0
                }
            }
        })
    }

    fun starts(with: Sequence<Element>): Boolean {
        val itr = iterable.iterator()
        for (element in with.iterable) {
            if (!itr.hasNext() || element != itr.next()) {
                return false
            }
        }
        return true
    }

    fun starts(with: Sequence<Element>, by: (Element, Element) -> Boolean): Boolean {
        val itr = iterable.iterator()
        for (element in with.iterable) {
            if (!itr.hasNext() || !by(element, itr.next())) {
                return false
            }
        }
        return true
    }

    fun elementsEqual(other: Sequence<Element>, by: (Element, Element) -> Boolean = { it1, it2 -> it1 == it2 }): Boolean {
        val itr = this.iterable.iterator()
        val otherItr = other.iterable.iterator()
        while (itr.hasNext()) {
            if (!otherItr.hasNext() || !by(itr.next(), otherItr.next())) {
                return false
            }
        }
        return !otherItr.hasNext()
    }

    fun contains(where: (Element) -> Boolean): Boolean {
        iterable.forEach { if (where(it)) return true }
        return false
    }

    // WARNING: Although `initialResult` is not a labeled parameter in Swift, the transpiler inserts it
    // into our Kotlin call sites to differentiate between calls to the two `reduce()` functions. Do not change
    fun <R> reduce(initialResult: R, nextPartialResult: (R, Element) -> R): R {
        return iterable.fold(initialResult, nextPartialResult)
    }

    fun <R> reduce(unusedp: Nothing? = null, into: R, updateAccumulatingResult: (InOut<R>, Element) -> Unit): R {
        return iterable.fold(into) { result, element ->
            var accResult = result
            val inoutAccResult = InOut<R>({ accResult }, { accResult = it })
            updateAccumulatingResult(inoutAccResult, element)
            accResult
        }
    }

    fun allSatisfy(predicate: (Element) -> Boolean): Boolean {
        return iterable.all(predicate)
    }

    fun reversed(): Array<Element> {
        return transformToArray { it.reversed() }
    }

    fun <RE> flatMap(transform: (Element) -> Sequence<RE>): Array<RE> {
        return transformToArray { it.flatMap { transform(it).iterable } }
    }

    fun <RE> compactMap(transform: (Element) -> RE?): Array<RE> {
        return transformToArray { it.mapNotNull(transform) }
    }

    @Suppress("UNCHECKED_CAST")
    fun sorted(): Array<Element> {
        return sorted(by = { p0, p1 -> (p0 as Comparable<Element>).compareTo(p1) < 0 })
    }

    fun sorted(by: (Element, Element) -> Boolean): Array<Element> {
        return transformToArray { it.sortedWith(PredicateComparator(by)) }
    }

    fun contains(element: Element): Boolean {
        return iterable.contains(element)
    }
}

/// Implement as an extension function so that concrete collections can specialize its return type.
fun <Element> Sequence<Element>.filter(isIncluded: (Element) -> Boolean): Array<Element> {
    return Array(iterable.filter(isIncluded), nocopy = true)
}

/// Implement as an extension function so that String can specialize its return type.
fun <Element, RE> Sequence<Element>.joined(): Array<RE> where Element: Sequence<RE> = flatMap { it }

/// Implement as an extension function so that String can specialize its return type.
fun <Element, RE> Sequence<Element>.joined(separator: Element): Array<RE> where Element: Sequence<RE> {
    val joined = ArrayList<RE>()
    val itr = iterable.iterator()
    while (itr.hasNext()) {
        joined.addAll(itr.next())
        if (itr.hasNext()) {
            joined.addAll(separator)
        }
    }
    return Array(joined, nocopy = true)
}

fun Sequence<String>.joined(separator: String = ""): String {
    return iterable.joinToString(separator = separator)
}

// Helper for funcs that return a transformation of this sequence.
internal fun <Element, ResultElement> Sequence<Element>.transformToArray(operation: (Iterable<Element>) -> Iterable<ResultElement>): Array<ResultElement> {
    val iterable = this.iterable
    val result = operation(iterable)
    return Array(result, nocopy = result !== iterable)
}

// Helper to sort using a predicate.
internal class PredicateComparator<Element>(val lessThan: (Element, Element) -> Boolean): Comparator<Element> {
    override fun compare(p0: Element, p1: Element): Int {
        if (lessThan(p0, p1)) {
            return -1
        } else if (lessThan(p1, p0)) {
            return 1
        } else {
            return 0
        }
    }
}

/// Helper to shuffle a Kotlin list.
internal fun <Element> MutableList<Element>.shuffle(using: InOut<RandomNumberGenerator>?) {
    // Use same algorithm as Swift std library
    var amount = size
    var currentIndex = 0
    while (amount > 1) {
        val random = Int.random(0 until amount, using)
        amount -= 1
        val previous = this[currentIndex]
        this[currentIndex] = this[currentIndex + random]
        this[currentIndex + random] = previous
        currentIndex += 1
    }
}

/// Kotlin representation of `Swift.Collection`.
interface Collection<Element>: Sequence<Element>, CollectionStorage<Element> {
    val startIndex: Int
        get() = storageStartIndex
    val endIndex: Int
        get() = storageEndIndex ?: count

    val indices: Sequence<Int>
        get() {
            val indicesIterable = object: Iterable<Int> {
                override fun iterator(): Iterator<Int> {
                    var index = 0
                    return object: Iterator<Int> {
                        override fun hasNext(): Boolean = index < this@Collection.count
                        override fun next(): Int = index++
                    }
                }
            }
            return object: Sequence<Int> {
                override val iterable: Iterable<Int>
                    get() = indicesIterable
            }
        }

    val isEmpty: Boolean
        get() = storageStartIndex >= effectiveStorageEndIndex
    val count: Int
        get() = effectiveStorageEndIndex - storageStartIndex

    fun index(i: Int, offsetBy: Int): Int  = i + offsetBy
    fun distance(from: Int, to: Int): Int  = to - from
    fun index(after: Int): Int = after + 1

    fun formIndex(after: InOut<Int>) {
        after.value = after.value + 1
    }

    fun formIndex(i: InOut<Int>, offsetBy: Int) {
        i.value = i.value + offsetBy
    }

    fun randomElement(using: InOut<RandomNumberGenerator>? = null): Element? {
        return if(isEmpty) null else collection.elementAt(Int.random(storageStartIndex until effectiveStorageEndIndex, using = using))
    }

    fun popFirst(): Element? {
        return if (isEmpty) null else removeFirst()
    }

    fun removeFirst(): Element {
        willMutateStorage()
        val itr = mutableCollection.iterator()
        val ret = itr.next()
        itr.remove()
        didMutateStorage()
        return ret
    }

    fun removeFirst(k: Int) {
        willMutateStorage()
        val itr = mutableCollection.iterator()
        for (i in 0 until k) {
            itr.next()
            itr.remove()
        }
        didMutateStorage()
    }

    val first: Element?
        get() = if (isEmpty) null else collection.elementAt(storageStartIndex).sref()

    fun prefix(upTo: Int, unusedp: Any? = null): Array<Element> {
        if (upTo <= storageStartIndex) {
            return Array<Element>()
        }
        val list = ArrayList<Element>(upTo - startIndex)
        for (i in storageStartIndex until upTo) {
            list.add(collection.elementAt(i))
        }
        return Array(list, nocopy = true)
    }

    fun prefix(through: Int, unusedp0: Any? = null, unusedp1: Any? = null): Array<Element> {
        return prefix(upTo = through + 1)
    }

    fun suffix(from: Int, unusedp: Any? = null): Array<Element> {
        if (from >= effectiveStorageEndIndex) {
            return Array<Element>()
        }
        val list = ArrayList<Element>(effectiveStorageEndIndex - from)
        for (i in from until effectiveStorageEndIndex) {
            list.add(collection.elementAt(i))
        }
        return Array(list, nocopy = true)
    }

    fun firstIndex(of: Element): Int? {
        val index = indexOf(of)
        return if (index == -1) null else index
    }

    fun firstIndex(where: (Element) -> Boolean): Int? {
        val index = indexOfFirst(where)
        return if (index == -1) null else index
    }

    operator fun get(range: IntRange): Collection<Element> {
        // We translate open ranges to use Int.min and Int.max in Kotlin
        val lowerBound = if (range.start == Int.min) 0 else range.start
        val upperBound = if (range.endInclusive == Int.max) null else range.endInclusive + 1

        willSliceStorage()
        val collection = this
        return object: Collection<Element> {
            override val collection = collection.collection
            override val mutableCollection: kotlin.collections.MutableCollection<Element>
                get() = throw UnsupportedOperationException() // We don't support mutating slices
            override val storageStartIndex = lowerBound
            override val storageEndIndex = upperBound
        }
    }

    // From the RangeReplaceableCollection protocol, but we share the implementation across all our Colleciton types
    fun removeAll(keepingCapacity: Boolean = false) {
        willMutateStorage()
        mutableCollection.clear()
        didMutateStorage()
    }

    fun shuffle(using: InOut<RandomNumberGenerator>? = null) {
        transformMutableCollectionAsList { it.shuffle(using) }
    }

    @Suppress("UNCHECKED_CAST")
    fun sort() {
        sort({ p0, p1 -> (p0 as Comparable<Element>).compareTo(p1) < 0 })
    }

    fun sort(by: (Element, Element) -> Boolean) {
        transformMutableCollectionAsList { it.sortWith(PredicateComparator(by)) }
    }

    fun trimmingPrefix(while_: (Element) -> Boolean): Array<Element> {
        return transformToArray { it.dropWhile(while_) }
    }

    fun trimPrefix(while_: (Element) -> Boolean) {
        transformMutableCollectionAsList {
            val itr = it.iterator()
            while (itr.hasNext() && while_(itr.next())) {
                itr.remove()
            }
        }
    }
}

internal fun <Element> Collection<Element>.transformMutableCollectionAsList(operation: (MutableList<Element>) -> Unit) {
    val mutableCollection = this.mutableCollection
    val reassignStorage = mutableCollection !is MutableList<*>
    val list: MutableList<Element>
    if (reassignStorage) {
        list = ArrayList<Element>(mutableCollection.size)
        list.addAll(mutableCollection)
    } else {
        list = mutableCollection as MutableList<Element>
    }

    willMutateStorage()
    operation(list)
    if (reassignStorage) {
        mutableCollection.clear()
        mutableCollection.addAll(list)
    }
    didMutateStorage()
}

/// Implement subscript as an extension function so that `Dictionary` can implement it for keyed access instead.
///
/// - Warning: This means that you cannot access positional entries in a `Dictionary<Int, *>` because we'll return
/// the value for the `Int` key instead
operator fun <Element> Collection<Element>.get(position: Int): Element {
    return collection.elementAt(position).sref()
}

/// Kotlin representation of `Swift.BidirectionalCollection`.
interface BidirectionalCollection<Element>: Collection<Element>, MutableListStorage<Element> {
    // Add parameter to avoid conflict with index(after:)
    fun index(before: Int, unusedp: Any? = null): Int = before - 1

    // Add parameter to avoid conflict with formIndex(after:)
    fun formIndex(before: InOut<Int>, unusedp: Any? = null) {
        before.value = before.value - 1
    }

    fun last(where: (Element) -> Boolean): Element? {
        // If we're not a slice we can use the collection directly, otherwise use our sliced iterator
        if (storageStartIndex == 0 && storageEndIndex == null) {
            return collection.lastOrNull(where).sref()
        } else {
            return iterable.lastOrNull(where).sref()
        }
    }

    val last: Element?
        get() = if (isEmpty) null else elementAt(effectiveStorageEndIndex - 1).sref()

    fun lastIndex(of: Element): Int? {
        val lastIndex = collection.lastIndexOf(of)
        return if (lastIndex < storageStartIndex || lastIndex >= effectiveStorageEndIndex) null else lastIndex
    }

    fun lastIndex(where: (Element) -> Boolean): Int? {
        val lastIndex = collection.indexOfLast(where)
        return if (lastIndex < storageStartIndex || lastIndex >= effectiveStorageEndIndex) null else lastIndex
    }

    fun popLast(): Element? {
        willMutateStorage()
        val lastElement = mutableList.removeLast().sref()
        didMutateStorage()
        return lastElement
    }

    fun removeLast(k: Int = 1) {
        if (k > 0) {
            willMutateStorage()
            mutableList.subList(mutableList.size - k, mutableList.size).clear()
            didMutateStorage()
        }
    }
}

/// Kotlin representation of `Swift.RandomAccessCollection`.
interface RandomAccessCollection<Element>: BidirectionalCollection<Element> {
}

/// Kotlin representation of `Swift.RangeReplaceableCollection`.
interface RangeReplaceableCollection<Element>: Collection<Element>, MutableListStorage<Element> {
    fun append(newElement: Element) {
        willMutateStorage()
        mutableList.add(newElement.sref())
        didMutateStorage()
    }

    fun append(contentsOf: Sequence<Element>) {
        willMutateStorage()
        mutableList.addAll(contentsOf) // Will use sref'ing iterator to copy
        didMutateStorage()
    }

    fun insert(newElement: Element, at: Int) {
        willMutateStorage()
        mutableList.add(at, newElement.sref())
        didMutateStorage()
    }

    fun insert(contentsOf: Sequence<Element>, at: Int) {
        willMutateStorage()
        // Copy contents to sref
        val list = ArrayList<Element>(contentsOf.iterable.count())
        list.addAll(contentsOf)
        mutableList.addAll(at, list)
        didMutateStorage()
    }

    fun remove(at: Int): Element {
        willMutateStorage()
        val element = mutableList.removeAt(at)
        didMutateStorage()
        return element
    }

    fun removeAll(where: (Element) -> Boolean) {
        willMutateStorage()
        mutableList.removeAll(where)
        didMutateStorage()
    }
}

/// Kotlin representation of `Swift.MutableCollection`.
interface MutableCollection<Element>: Collection<Element>, MutableListStorage<Element> {
    operator fun set(position: Int, element: Element) {
        willMutateStorage()
        mutableList[position] = element.sref()
        didMutateStorage()
    }

    operator fun set(bounds: IntRange, elements: Collection<Element>) {
        // We translate open ranges to use Int.min and Int.max in Kotlin
        val lowerBound = if (bounds.start == Int.min) 0 else bounds.start
        val upperBound = if (bounds.endInclusive == Int.max) collection.size else bounds.endInclusive + 1

        willMutateStorage()
        mutableList.subList(lowerBound, upperBound).clear()
        mutableList.addAll(lowerBound, elements.collection.map { it.sref() })
        didMutateStorage()
    }

    fun swapAt(i: Int, j: Int) {
        willMutateStorage()
        val previous = mutableList[i]
        mutableList[i] = mutableList[j]
        mutableList[j] = previous
        didMutateStorage()
    }

    fun reverse() {
        willMutateStorage()
        mutableList.reverse()
        didMutateStorage()
    }
}

interface IteratorProtocol<Element> {
    fun next(): Element?
}

fun stride(from: Int, to: Int, by: Int): Sequence<Int> {
    return stride(from, to, false, by)
}

fun stride(from: Int, through: Int, by: Int, unusedp: Nothing? = null): Sequence<Int> {
    return stride(from, through, true, by)
}

private fun stride(from: Int, to: Int, inclusive: Boolean, by: Int): Sequence<Int> {
    var next = from
    val strideHasNext: () -> Boolean = {
        if (by >= 0) {
            if (to <= from) { false } else if (inclusive) { next <= to } else  { next < to }
        } else {
            if (to >= from) { false } else if (inclusive) { next >= to } else { next > to }
        }
    }
    val strideNext: () -> Int = {
        val ret = next
        next += by
        ret
    }
    return strideSequence(strideHasNext, strideNext)
}

private fun <T> strideSequence(strideHasNext: () -> Boolean, strideNext: () -> T): Sequence<T> {
    val strideIterable = object: Iterable<T> {
        override fun iterator(): Iterator<T> {
            return object: Iterator<T> {
                override fun hasNext(): Boolean = strideHasNext()
                override fun next(): T = strideNext()
            }
        }
    }
    return object: Sequence<T> {
        override val iterable: Iterable<T>
            get() = strideIterable
    }
}

fun stride(from: Long, to: Long, by: Long): Sequence<Long> {
    return stride(from, to, false, by)
}

fun stride(from: Long, through: Long, by: Long, unusedp: Nothing? = null): Sequence<Long> {
    return stride(from, through, true, by)
}

private fun stride(from: Long, to: Long, inclusive: Boolean, by: Long): Sequence<Long> {
    var next = from
    val strideHasNext: () -> Boolean = {
        if (by >= 0) {
            if (to <= from) { false } else if (inclusive) { next <= to } else  { next < to }
        } else {
            if (to >= from) { false } else if (inclusive) { next >= to } else { next > to }
        }
    }
    val strideNext: () -> Long = {
        val ret = next
        next += by
        ret
    }
    return strideSequence(strideHasNext, strideNext)
}

fun stride(from: Double, to: Double, by: Double): Sequence<Double> {
    return stride(from, to, false, by)
}

fun stride(from: Double, through: Double, by: Double, unusedp: Nothing? = null): Sequence<Double> {
    return stride(from, through, true, by)
}

private fun stride(from: Double, to: Double, inclusive: Boolean, by: Double): Sequence<Double> {
    var next = from
    val strideHasNext: () -> Boolean = {
        if (by >= 0) {
            if (to <= from) { false } else if (inclusive) { next <= to } else  { next < to }
        } else {
            if (to >= from) { false } else if (inclusive) { next >= to } else { next > to }
        }
    }
    val strideNext: () -> Double = {
        val ret = next
        next += by
        ret
    }
    return strideSequence(strideHasNext, strideNext)
}

fun <E1, E2> zip(sequence1: Sequence<E1>, sequence2: Sequence<E2>): Array<Tuple2<E1, E2>> {
    val zipped = sequence1.iterable.zip(sequence2.iterable)
    val list = ArrayList<Tuple2<E1, E2>>(zipped.size)
    for ((e1, e2) in zipped) {
        list.add(Tuple2(e1, e2))
    }
    return Array(list, nocopy = true)
}

val IntRange.upperBound: Int
    get() = if (endInclusive == Int.MAX_VALUE) Int.MAX_VALUE else endInclusive + 1
val IntRange.lowerBound: Int
    get() = start
// IntRange.isEmpty, IntRange.contains can be used as-is
