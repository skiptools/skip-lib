// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

import java.lang.UnsupportedOperationException

/// Create a dictionary with the given content.
fun <K, V> dictionaryOf(vararg entries: Tuple2<K, V>): Dictionary<K, V> {
    val dictionary = Dictionary<K, V>()
    for (entry in entries) {
        dictionary.put(entry.element0, entry.element1)
    }
    return dictionary
}

/// Kotlin representation of a `Swift.Dictionary`.
///
/// - Seealso: `KotlinInterop.kt` for functions to convert to/from Kotlin collection types.
class Dictionary<K, V>: Collection<Tuple2<K, V>>, MutableStruct, KotlinConverting<MutableMap<*, *>> {
    // We attempt to avoid copying when possible. This may involve sharing storage. When storage is
    // shared, we copy on write and rely on our sharing partners to do the same. We may also maintain
    // an entry collection view of ourselves for serving Collection API
    private var isStorageShared = false
    internal var storage: LinkedHashMap<K, V>
    internal val mutableStorage: LinkedHashMap<K, V>
        get() {
            if (isStorageShared) {
                storage = LinkedHashMap(storage)
                isStorageShared = false
            }
            return storage
        }
    private val _entryCollection: EntryCollection<K, V>

    override val collection: kotlin.collections.Collection<Tuple2<K, V>>
        get() = _entryCollection
    override val mutableCollection: kotlin.collections.MutableCollection<Tuple2<K, V>>
        get() {
            mutableStorage // Accessing will copy storage if needed
            return _entryCollection
        }

    override fun willSliceStorage() {
        isStorageShared = true // Shared with slice
    }
    override fun willMutateStorage() = willmutate()
    override fun didMutateStorage() = didmutate()

    constructor(minimumCapacity: Int = 0) {
        storage = LinkedHashMap()
        _entryCollection = EntryCollection(this)
    }

    @Suppress("UNCHECKED_CAST")
    constructor(uniqueKeysWithValues: Sequence<Tuple2<K, V>>, nocopy: Boolean = false) {
        if (nocopy && uniqueKeysWithValues is Dictionary<*, *>) {
            // Share storage with the given dictionary, marking it as shared in both
            storage = (uniqueKeysWithValues as Dictionary<K, V>).storage
            uniqueKeysWithValues.isStorageShared = true
            isStorageShared = true
        } else if (nocopy && uniqueKeysWithValues is EntryCollection<*, *>) {
            // Share storage with the given dictionary, marking it as shared in both
            storage = (uniqueKeysWithValues as EntryCollection<K, V>).dictionary.storage
            uniqueKeysWithValues.dictionary.isStorageShared = true
            isStorageShared = true
        } else {
            storage = LinkedHashMap()
            for (entry in uniqueKeysWithValues.iterable) {
                if (nocopy) {
                    storage[entry._e0] = entry._e1
                } else {
                    storage[entry.element0] = entry.element1
                }
            }
        }
        _entryCollection = EntryCollection(this)
    }

    @Suppress("UNCHECKED_CAST")
    constructor(map: Map<K, V>, nocopy: Boolean = false, shared: Boolean = false) {
        if (nocopy && map is LinkedHashMap<*, *>) {
            storage = map as LinkedHashMap<K, V>
            isStorageShared = shared
        } else {
            storage = LinkedHashMap()
            for (entry in map) {
                if (nocopy) {
                    storage[entry.key] = entry.value
                } else {
                    storage[entry.key.sref()] = entry.value.sref()
                }
            }
        }
        _entryCollection = EntryCollection(this)
    }

    fun filter(isIncluded: (Tuple2<K, V>) -> Boolean): Dictionary<K, V> {
        return Dictionary(storage.filter { isIncluded(Tuple2(it.key, it.value)) }, nocopy = true)
    }

    operator fun get(key: K): V? {
        // Re-set this key if the returned MutableStruct reference is mutated
        return storage[key]?.sref({
            set(key, it)
        })
    }

    operator fun set(key: K, value: V?) {
        willmutate()
        if (value == null) {
            mutableStorage.remove(key)
        } else {
            mutableStorage[key.sref()] = value.sref()
        }
        didmutate()
    }

    operator fun get(key: K, default: () -> V): V {
        // Re-set this key if the returned MutableStruct reference is mutated
        return get(key) ?: default().sref({
            set(key, it)
        })
    }

    operator fun set(key: K, default: () -> V, value: V?) {
        willmutate()
        if (value == null) {
            mutableStorage.remove(key)
        } else {
            mutableStorage[key.sref()] = value.sref()
        }
        didmutate()
    }

    /// Adds the value to the dictionary, preserving nulls.
    fun put(key: K, value: V) {
        willmutate()
        mutableStorage[key.sref()] = value.sref()
        didmutate()
    }

    fun <T> mapValues(transform: (V) -> T): Dictionary<K, T> {
        val map = storage.mapValues { transform(it.value) }
        return Dictionary(map, nocopy = true)
    }

    fun <T> compactMapValues(transform: (V) -> T?): Dictionary<K, T> {
        val map = LinkedHashMap<K, T>()
        for (entry in storage) {
            val value = transform(entry.value)
            if (value != null) {
                map.put(entry.key, value)
            }
        }
        return Dictionary(map, nocopy = true)
    }

    fun updateValue(value: V, forKey: K): V? {
        willmutate()
        val ret = mutableStorage.put(forKey, value)
        didmutate()
        return ret
    }

    fun removeValue(forKey: K): V? {
        willmutate()
        val ret = mutableStorage.remove(forKey)
        didmutate()
        return ret
    }

    val keys: Collection<K>
        get() {
            return object: Collection<K> {
                override val collection = KeyCollection(this@Dictionary)
                override val mutableCollection: kotlin.collections.MutableCollection<K>
                    get() = throw UnsupportedOperationException()
            }
        }
    val values: Collection<V>
        get() {
            return object: Collection<V> {
                override val collection = ValueCollection(this@Dictionary)
                override val mutableCollection: kotlin.collections.MutableCollection<V>
                    get() = throw UnsupportedOperationException()
            }
        }

    override fun equals(other: Any?): Boolean {
        if (other === this) {
            return true
        }
        if (other as? Dictionary<*, *> == null) {
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
    override fun scopy(): MutableStruct = Dictionary(this, nocopy = true)

    override fun kotlin(nocopy: Boolean): MutableMap<*, *> {
        if (nocopy) {
            return mutableStorage
        } else {
            val map = LinkedHashMap<Any?, Any?>()
            for ((key, value) in storage) {
                map.put(key?.kotlin(), value?.kotlin())
            }
            return map
        }
    }

    companion object {
    }

    private class EntryCollection<K, V>(val dictionary: Dictionary<K, V>): AbstractMutableCollection<Tuple2<K, V>>() {
        override val size: Int
            get() = dictionary.storage.size

        override fun add(element: Tuple2<K, V>): Boolean {
            // No need to sref because Tuple does on the way out
            dictionary.storage[element.key] = element.value
            return true
        }

        override fun iterator(): MutableIterator<Tuple2<K, V>> {
            val storageIterator = dictionary.storage.iterator()
            return object: MutableIterator<Tuple2<K, V>> {
                private lateinit var lastEntry: MutableMap.MutableEntry<K, V>
                override fun hasNext(): Boolean {
                    return storageIterator.hasNext()
                }
                override fun next(): Tuple2<K, V> {
                    lastEntry = storageIterator.next()
                    return Tuple2(lastEntry.key, lastEntry.value)
                }
                override fun remove() {
                    dictionary.storage.remove(lastEntry.key)
                }
            }
        }

        override fun contains(element: Tuple2<K, V>): Boolean = dictionary.storage[element._e0] == element._e1
        override fun clear() = dictionary.storage.clear()
    }

    private class KeyCollection<K, V>(val dictionary: Dictionary<K, V>): AbstractCollection<K>() {
        override val size: Int
            get() = dictionary.storage.size

        override fun iterator(): Iterator<K> {
            val storageIterator = dictionary.storage.iterator()
            return object: Iterator<K> {
                override fun hasNext(): Boolean {
                    return storageIterator.hasNext()
                }
                override fun next(): K {
                    val entry = storageIterator.next()
                    return entry.key
                }
            }
        }

        override fun contains(element: K): Boolean = dictionary.storage.containsKey(element)
    }

    private class ValueCollection<K, V>(val dictionary: Dictionary<K, V>): AbstractCollection<V>() {
        override val size: Int
            get() = dictionary.storage.size

        override fun iterator(): Iterator<V> {
            val storageIterator = dictionary.storage.iterator()
            return object: Iterator<V> {
                override fun hasNext(): Boolean {
                    return storageIterator.hasNext()
                }
                override fun next(): V {
                    val entry = storageIterator.next()
                    return entry.value
                }
            }
        }

        override fun contains(element: V): Boolean = dictionary.storage.containsValue(element)
    }
}
