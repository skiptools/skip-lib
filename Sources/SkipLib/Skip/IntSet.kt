// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

/// Kotlin equivalent of `Foundation.IndexSet`.
///
/// We implement this in SkipLib to colocate it with other built-in collection types.
///
/// - Seealso: `KotlinInterop.kt` for functions to convert to/from Kotlin collection types.
class IntSet: BidirectionalCollection<Int>, MutableCollection<Int>, SetAlgebra<IntSet, Int>, MutableStruct, KotlinConverting<MutableList<Int>> {
    // We attempt to avoid copying when possible. This may involve sharing storage. When storage is
    // shared, we copy on write and rely on our sharing partners to do the same
    private var isStorageShared = false
    internal var storage: MutableList<Int>
    internal val mutableStorage: MutableList<Int>
        get() {
            if (isStorageShared) {
                storage = MutableList(storage.size) { storage[it] }
                isStorageShared = false
            }
            return storage
        }

    override val collection: kotlin.collections.Collection<Int>
        get() = storage
    override val mutableList: kotlin.collections.MutableList<Int>
        get() = mutableStorage

    override fun willSliceStorage() {
        isStorageShared = true // Shared with slice
    }
    override fun willMutateStorage() = willmutate()
    override fun didMutateStorage() = didmutate()

    constructor() {
        storage = mutableListOf()
    }

    @Suppress("UNCHECKED_CAST")
    constructor(collection: Sequence<Int>, nocopy: Boolean = false, shared: Boolean = false) {
        if (nocopy && collection is IntSet && shared) {
            // Share storage with the given set, marking it as shared in both
            storage = collection.storage
            collection.isStorageShared = true
            isStorageShared = true
        } else if (collection is IntSet) {
            storage = MutableList(collection.storage.size) { collection.storage[it] }
        } else {
            storage = mutableListOf()
            for (i in collection) {
                if (storage.binarySearch(i) < 0) {
                    storage.add(i)
                }
            }
            storage.sort()
        }
    }

    constructor(collection: Iterable<Int>, nocopy: Boolean = false, shared: Boolean = false) {
        storage = mutableListOf()
        for (i in collection) {
            if (storage.binarySearch(i) < 0) {
                storage.add(i)
            }
        }
        storage.sort()
    }

    constructor(integersIn: IntRange): this() {
        integersIn.forEach { storage.add(it) }
    }

    constructor(integer: Int): this() {
        storage.add(integer)
    }

    fun integerGreaterThan(integer: Int): Int? {
        val index = storage.binarySearch(integer)
        val nextIndex = if (index < 0) -index - 1 else index + 1
        return if (nextIndex < count) storage[nextIndex] else null
    }

    fun integerLessThan(integer: Int): Int? {
        val index = storage.binarySearch(integer)
        val previousIndex = if (index < 0) -index - 2 else index - 1
        return if (previousIndex >= 0) storage[previousIndex] else null
    }

    fun integerGreaterThanOrEqualTo(integer: Int): Int? {
        val index = storage.binarySearch(integer)
        val nextIndex = if (index < 0) -index - 1 else index
        return if (nextIndex < count) storage[nextIndex] else null
    }

    fun integerLessThanOrEqualTo(integer: Int): Int? {
        val index = storage.binarySearch(integer)
        val previousIndex = if (index < 0) -index - 2 else index
        return if (previousIndex >= 0) storage[previousIndex] else null
    }

    fun count(in_: IntRange): Int {
        var count = 0
        in_.forEach { if (storage.contains(it)) count += 1 }
        return count
    }

    fun contains(integersIn: IntRange): Boolean {
        return integersIn.firstOrNull { !storage.contains(it) } == null
    }

    fun contains(integersIn: IntSet): Boolean {
        return storage.containsAll(integersIn.storage)
    }

    fun intersects(integersIn: IntRange): Boolean {
        return storage.firstOrNull { integersIn.contains(it) } != null
    }

    fun insert(integersIn: IntRange) {
        willmutate()
        for (i in integersIn) {
            val index = mutableStorage.binarySearch(i)
            if (index < 0) {
                mutableStorage.add(-index - 1, i)
            }
        }
        didmutate()
    }

    fun remove(integersIn: IntRange) {
        willmutate()
        for (i in integersIn) {
            val index = mutableStorage.binarySearch(i)
            if (index >= 0) {
                mutableStorage.removeAt(index)
            }
        }
        didmutate()
    }

    fun filteredIndexSet(in_: IntRange, includeInteger: (Int) -> Boolean): IntSet {
        val filtered = IntSet()
        for (i in in_) {
            if (storage.binarySearch(i) >= 0 && includeInteger(i)) {
                filtered.storage.add(i)
            }
        }
        return filtered
    }

    fun filteredIndexSet(includeInteger: (Int) -> Boolean): IntSet {
        val filtered = IntSet()
        for (i in storage) {
            if (includeInteger(i)) {
                filtered.storage.add(i)
            }
        }
        return filtered
    }

    // MARK: - SetAlgebra

    override val isEmpty: Boolean
        get() = storage.isEmpty()

    override fun contains(element: Int): Boolean {
        return storage.binarySearch(element) >= 0
    }

    override fun union(other: IntSet): IntSet {
        val ret = IntSet(other)
        for (i in storage) {
            val index = ret.storage.binarySearch(i)
            if (index < 0) {
                ret.storage.add(-index - 1, i)
            }
        }
        return ret
    }

    override fun intersection(other: IntSet): IntSet {
        val ret = IntSet()
        for (i in storage) {
            if (other.contains(i)) {
                ret.storage.add(i)
            }
        }
        return ret
    }

    override fun symmetricDifference(other: IntSet): IntSet {
        val ret = IntSet(other)
        for (i in storage) {
            val index = ret.storage.binarySearch(i)
            if (index >= 0) {
                ret.storage.removeAt(index)
            } else {
                ret.storage.add(-index - 1, i)
            }
        }
        return ret
    }

    override fun insert(element: Int): Tuple2<Boolean, Int> {
        val index = storage.binarySearch(element)
        if (index >= 0) {
            return Tuple2(false, element)
        } else {
            willmutate()
            mutableStorage.add(-index - 1, element)
            didmutate()
            return Tuple2(true, element)
        }
    }

    override fun remove(element: Int): Int? {
        val index = storage.binarySearch(element)
        if (index >= 0) {
            willmutate()
            mutableStorage.removeAt(index)
            didmutate()
            return element
        } else {
            return null
        }
    }

    override fun update(with: Int): Int? {
        return if (contains(with)) with else null
    }

    override fun formUnion(other: IntSet) {
        willmutate()
        for (i in other.storage) {
            val index = mutableStorage.binarySearch(i)
            if (index < 0) {
                mutableStorage.add(-index - 1, i)
            }
        }
        didmutate()
    }

    override fun formIntersection(other: IntSet) {
        willmutate()
        for (index in mutableStorage.size - 1 downTo 0) {
            if (!other.contains(mutableStorage[index])) {
                mutableStorage.removeAt(index)
            }
        }
        didmutate()
    }

    override fun formSymmetricDifference(other: IntSet) {
        val diff = symmetricDifference(other)
        willmutate()
        mutableStorage.clear()
        mutableStorage.addAll(diff.storage)
        didmutate()
    }

    override fun subtracting(other: IntSet): IntSet {
        val ret = IntSet(this)
        for (i in other.storage) {
            ret.storage.remove(i)
        }
        return ret
    }

    override fun isSubset(of: IntSet): Boolean {
        return of.contains(integersIn = this)
    }

    override fun isDisjoint(with: IntSet): Boolean {
        return union(with).isEmpty
    }

    override fun isSuperset(of: IntSet): Boolean {
        return contains(integersIn = of)
    }

    override fun subtract(other: IntSet) {
        willmutate()
        for (i in other) {
            mutableStorage.remove(i)
        }
        didmutate()
    }

    override fun isStrictSubset(of: IntSet): Boolean {
        return isSubset(of) && of.count > count
    }

    override fun isStrictSuperset(of: IntSet): Boolean {
        return isSuperset(of) && count > of.count
    }

    override fun equals(other: Any?): Boolean {
        if (other === this) {
            return true
        }
        if (other !is Sequence<*>) {
            return false
        }
        @Suppress("UNCHECKED_CAST")
        return elementsEqual(other as Sequence<Int>)
    }

    override fun hashCode(): Int {
        return storage.hashCode()
    }

    override fun toString(): String {
        return storage.joinToString()
    }

    override var supdate: ((Any) -> Unit)? = null
    override var smutatingcount = 0
    override fun scopy(): MutableStruct = IntSet(this, nocopy = true, shared = true)

    override fun kotlin(nocopy: Boolean): MutableList<Int> {
        if (nocopy) {
            return mutableList
        } else {
            val list = ArrayList<Int>()
            list.addAll(storage)
            return list
        }
    }
}

