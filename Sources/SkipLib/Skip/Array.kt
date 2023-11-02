// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

/// Create an array with the given content.
fun <Element> arrayOf(vararg elements: Element): Array<Element> {
    val storage = ArrayList<Element>()
    for (element in elements) {
        storage.add(element.sref())
    }
    return Array(storage, nocopy = true)
}

/// Kotlin representation of a `Swift.Array`.
///
/// - Seealso: `KotlinInterop.kt` for functions to convert to/from Kotlin collection types.
class Array<Element>: RandomAccessCollection<Element>, RangeReplaceableCollection<Element>, MutableCollection<Element>, MutableStruct {
    // We attempt to avoid copying when possible. This may involve sharing storage. When storage is
    // shared, we copy on write and rely on our sharing partners to do the same. We may also maintain
    // a given read-only collection until write. One of _mutableList or _collection will always be non-nil
    private var isStorageShared = false
    private var _mutableList: MutableList<Element>? = null
    private var _collection: List<Element>? = null

    override val collection: kotlin.collections.Collection<Element>
        get() = _mutableList ?: _collection!!
    override val mutableList: MutableList<Element>
        get() {
            if (!isStorageShared) {
                val storage = _mutableList
                if (storage != null) {
                    return storage
                }
            }
            val storage = ArrayList(collection)
            isStorageShared = false
            _mutableList = storage
            _collection = null
            return storage
        }

    override fun willSliceStorage() {
        isStorageShared = true // Shared with slice
    }
    override fun willMutateStorage() = willmutate()
    override fun didMutateStorage() = didmutate()

    constructor() {
        _mutableList = ArrayList()
    }

    @Suppress("UNCHECKED_CAST")
    constructor(repeating: Element, count: Int) {
        _collection = List(count) { repeating }
    }

    @Suppress("UNCHECKED_CAST")
    constructor(collection: Sequence<Element>, nocopy: Boolean = false, shared: Boolean = false) {
        if (nocopy) {
            if (collection is Array<Element>) {
                // Share storage with the given array, marking it as shared in both
                val storage = collection._mutableList
                if (storage != null) {
                    if (shared) {
                        collection.isStorageShared = true
                        isStorageShared = true
                    }
                    _mutableList = storage
                } else {
                    // No need to mark as shared because will be copied on write regardless
                    _collection= collection._collection
                }
            } else if (collection is MutableListStorage<*> && collection.storageStartIndex == 0 && collection.storageEndIndex == null) {
                _mutableList = collection.mutableList as MutableList<Element>
                isStorageShared = shared
            } else if (collection is CollectionStorage<*> && collection.storageStartIndex == 0 && collection.storageEndIndex == null) {
                val collectionStorage = collection.collection
                if (collectionStorage is List<*>) { // Do not use e.g. Sets as array internals
                    _collection = collectionStorage as List<Element>
                }
            }
        }
        if (_mutableList == null && _collection == null) {
            val storage = ArrayList<Element>()
            storage.addAll(collection)
            _mutableList = storage
        }
    }

    constructor(collection: Iterable<Element>, nocopy: Boolean = false, shared: Boolean = false) {
        if (nocopy) {
            if (collection is MutableList<Element>) {
                _mutableList = collection
                isStorageShared = shared
            } else if (collection is List<Element>) { // Do not use e.g. Sets as array internals
                _collection = collection
                // No need to mark as shared because will be copied on write regardless
            }
        }
        if (_mutableList == null && _collection == null) {
            val storage = ArrayList<Element>()
            collection.forEach { storage.add(it.sref()) }
            _mutableList = storage
        }
    }

    operator fun plus(array: Array<Element>): Array<Element> {
        if (array.isEmpty) return this
        if (isEmpty) return array
        val result = Array(this)
        result.append(contentsOf = array)
        return result
    }

    operator fun get(position: Int): Element {
        // Re-set this index if the returned MutableStruct reference is mutated
        return collection.elementAt(position).sref({
            set(position, it)
        })
    }

    override fun equals(other: Any?): Boolean {
        if (other === this) {
            return true
        }
        if (other as? Array<*> == null) {
            return false
        }
        return other.collection == collection
    }

    override fun hashCode(): Int {
        return collection.hashCode()
    }

    override fun toString(): String {
        return collection.joinToString()
    }

    override var supdate: ((Any) -> Unit)? = null
    override var smutatingcount = 0
    override fun scopy(): MutableStruct = Array(this, nocopy = true, shared = true)
}
