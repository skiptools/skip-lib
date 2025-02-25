// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Create a set with the given content.
fun <Element> setOf(vararg elements: Element): Set<Element> {
    val storage = LinkedHashSet<Element>()
    for (element in elements) {
        storage.add(element.sref())
    }
    return Set(storage, nocopy = true)
}

/// Create a set with the characters of the given string.
///
/// We can't make this a true constructor because Kotlin doesn't have enough information to infer the element type.
fun Set(string: String): Set<Char> {
    val storage = LinkedHashSet<Char>()
    for (c in string) {
        storage.add(c)
    }
    return Set(storage, nocopy = true)
}

/// Kotlin representation of a Swift Set.
///
/// - Seealso: `KotlinInterop.kt` for functions to convert to/from Kotlin collection types.
class Set<Element>: Collection<Element>, SetAlgebra<Set<Element>, Element>, MutableStruct, KotlinConverting<MutableSet<*>> {
    // We attempt to avoid copying when possible. This may involve sharing storage. When storage is
    // shared, we copy on write and rely on our sharing partners to do the same
    private var isStorageShared = false
    internal var storage: LinkedHashSet<Element>
    internal val mutableStorage: LinkedHashSet<Element>
        get() {
            if (isStorageShared) {
                storage = LinkedHashSet(storage)
                isStorageShared = false
            }
            return storage
        }

    override val collection: kotlin.collections.Collection<Element>
        get() = storage
    override val mutableCollection: kotlin.collections.MutableCollection<Element>
        get() = mutableStorage

    override fun willSliceStorage() {
        isStorageShared = true // Shared with slice
    }
    override fun willMutateStorage() = willmutate()
    override fun didMutateStorage() = didmutate()

    constructor(minimumCapacity: Int = 0) {
        storage = LinkedHashSet()
    }

    constructor(collection: Sequence<Element>, nocopy: Boolean = false) {
        if (nocopy && collection is Set<Element>) {
            // Share storage with the given set, marking it as shared in both
            storage = collection.storage
            collection.isStorageShared = true
            isStorageShared = true
        } else {
            storage = LinkedHashSet()
            storage.addAll(collection)
        }
    }

    constructor(collection: Iterable<Element>, nocopy: Boolean = false, shared: Boolean = false) {
        if (nocopy && collection is LinkedHashSet<Element>) {
            storage = collection
            isStorageShared = shared
        } else {
            storage = LinkedHashSet()
            if (nocopy) {
                storage.addAll(collection)
            } else {
                collection.forEach { storage.add(it.sref()) }
            }
        }
    }

    fun filter(isIncluded: (Element) -> Boolean): Set<Element> {
        return Set(storage.filter(isIncluded), nocopy = true)
    }

    override val isEmpty: Boolean
        get() = count == 0

    fun union(other: Sequence<Element>): Set<Element> {
        val union = storage.union(other.iterable)
        return Set(union, nocopy = true)
    }

    fun intersection(other: Sequence<Element>): Set<Element> {
        val intersection = storage.intersect(other.iterable)
        return Set(intersection, nocopy = true)
    }

    fun symmetricDifference(other: Sequence<Element>): Set<Element> {
        val ret = Set(other)
        for (element in storage) {
            if (ret.remove(element) == null) {
                ret.insert(element)
            }
        }
        return ret
    }

    fun formUnion(other: Sequence<Element>) {
        willmutate()
        other.iterable.forEach { mutableStorage.add(it.sref()) }
        didmutate()
    }

    fun formIntersection(other: Sequence<Element>) {
        willmutate()
        other.iterable.forEach { mutableStorage.remove(it) }
        didmutate()
    }

    fun formSymmetricDifference(other: Sequence<Element>) {
        willmutate()
        for (element in other.iterable) {
            if (!mutableStorage.remove(element)) {
                mutableStorage.add(element.sref())
            }
        }
        didmutate()
    }

    fun subtracting(other: Sequence<Element>): Set<Element> {
        val subtraction = storage.subtract(other.iterable)
        return Set(subtraction, nocopy = true)
    }

    fun isSubset(of: Sequence<Element>): Boolean {
        for (element in storage) {
            if (!of.contains(element)) {
                return false
            }
        }
        return true
    }

    fun isDisjoint(with: Sequence<Element>): Boolean {
        for (element in with.iterable) {
            if (contains(element)) {
                return false
            }
        }
        return true
    }

    fun isSuperset(of: Sequence<Element>): Boolean {
        for (element in of.iterable) {
            if (!storage.contains(element)) {
                return false
            }
        }
        return true
    }

    fun subtract(other: Sequence<Element>) {
        willmutate()
        mutableStorage.removeAll(other.iterable)
        didmutate()
    }

    fun isStrictSubset(of: Sequence<Element>): Boolean {
        return count < of.iterable.count() && isSubset(of)
    }

    fun isStrictSuperset(of: Sequence<Element>): Boolean {
        return count > of.iterable.count() && isSuperset(of)
    }

    // MARK: - SetAlgebra

    override fun contains(element: Element): Boolean = storage.contains(element)
    override fun union(other: Set<Element>): Set<Element> = union(other as Sequence<Element>)
    override fun intersection(other: Set<Element>): Set<Element> = intersection(other as Sequence<Element>)
    override fun symmetricDifference(other: Set<Element>): Set<Element> = symmetricDifference(other as Sequence<Element>)

    override fun insert(element: Element): Tuple2<Boolean, Element> {
        val indexOf = storage.indexOf(element)
        if (indexOf != -1) {
            return Tuple2(false, storage.elementAt(indexOf))
        }
        willmutate()
        mutableStorage.add(element.sref())
        didmutate()
        return Tuple2(true, element)
    }

    override fun remove(element: Element): Element? {
        willmutate()
        val index = storage.indexOf(element)
        val ret: Element?
        if (index == -1) {
            ret = null
        } else {
            ret = storage.elementAt(index)
            mutableStorage.remove(element)
        }
        didmutate()
        return ret
    }

    override fun update(with: Element): Element? {
        willmutate()
        val index = storage.indexOf(with)
        val ret: Element?
        if (index == -1) {
            ret = null
        } else {
            ret = storage.elementAt(index)
            mutableStorage.remove(with)
        }
        mutableStorage.add(with.sref())
        didmutate()
        return ret
    }

    override fun formUnion(other: Set<Element>) = formUnion(other as Sequence<Element>)
    override fun formIntersection(other: Set<Element>) = formIntersection(other as Sequence<Element>)
    override fun formSymmetricDifference(other: Set<Element>) = formSymmetricDifference(other as Sequence<Element>)
    override fun subtracting(other: Set<Element>): Set<Element> = subtracting(other as Sequence<Element>)
    override fun isSubset(of: Set<Element>): Boolean = isSubset(of as Sequence<Element>)
    override fun isDisjoint(with: Set<Element>): Boolean = isDisjoint(with as Sequence<Element>)
    override fun isSuperset(of: Set<Element>): Boolean = isSuperset(of as Sequence<Element>)
    override fun subtract(other: Set<Element>) = subtract(other as Sequence<Element>)
    override fun isStrictSubset(of: Set<Element>): Boolean = isStrictSubset(of as Sequence<Element>)
    override fun isStrictSuperset(of: Set<Element>): Boolean = isStrictSuperset(of as Sequence<Element>)

    override fun equals(other: Any?): Boolean {
        if (other === this) {
            return true
        }
        if (other as? Set<*> == null) {
            return false
        }
        return other.storage == storage
    }

    override fun hashCode(): Int {
        return storage.hashCode()
    }

    override fun toString(): String {
        return storage.toString()
    }

    override var supdate: ((Any) -> Unit)? = null
    override var smutatingcount = 0
    override fun scopy(): MutableStruct = Set(this, nocopy = true)

    override fun kotlin(nocopy: Boolean): MutableSet<*> {
        if (nocopy) {
            return mutableStorage
        } else {
            val set = LinkedHashSet<Any?>()
            for (element in storage) {
                set.add(element?.kotlin())
            }
            return set
        }
    }

    companion object {
    }
}
