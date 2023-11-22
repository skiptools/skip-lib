// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

/// General API to convert a transpiled Swift instance to its Kotlin equivalent.
///
/// This default implementation performs a `sref()` copy, or returns the
// existing instance if `nocopy` is requested.
fun <T> T.kotlin(nocopy: Boolean = false): T {
    return if (nocopy) this else sref()
}

/// General API to convert a Kotlin instance to its Swift equivalent.
///
/// This default implementation performs a `sref()` copy, or returns the
// existing instance if `nocopy` is requested.
fun <T> T.swift(nocopy: Boolean = false): T {
    return if (nocopy) this else sref()
}

fun <Element> Array<Element>.kotlin(nocopy: Boolean = false): MutableList<Element> {
    if (nocopy) {
        mutableList.let { return it }
    }
    val list = ArrayList<Element>()
    list.addAll(this)
    return list
}

fun <Element> List<Element>.swift(nocopy: Boolean = false): Array<Element> {
    return Array(this, nocopy = nocopy)
}

fun <Element> Set<Element>.kotlin(nocopy: Boolean = false): MutableSet<Element> {
    if (nocopy) {
        return mutableStorage
    }
    val set = LinkedHashSet<Element>()
    set.addAll(this)
    return set
}

fun <Element> kotlin.collections.Set<Element>.swift(nocopy: Boolean = false): Set<Element> {
    return Set(this, nocopy = nocopy)
}

fun <Key, Value> Dictionary<Key, Value>.kotlin(nocopy: Boolean = false): MutableMap<Key, Value> {
    if (nocopy) {
        return mutableStorage
    }
    val map = LinkedHashMap<Key, Value>()
    forEach { map.put(it.key, it.value) }
    return map
}

fun <Key, Value> Map<Key, Value>.swift(nocopy: Boolean = false): Dictionary<Key, Value> {
    return Dictionary(this, nocopy = nocopy)
}

fun IntSet.kotlin(nocopy: Boolean = false): java.util.TreeSet<Int> {
    val set = java.util.TreeSet<Int>()
    set.addAll(storage)
    return set
}

fun java.util.TreeSet<Int>.swift(nocopy: Boolean = false): IntSet {
    return IntSet(this)
}

fun <Element> IteratorProtocol<Element>.kotlin(nocopy: Boolean = false): Iterator<Element> {
    val iter = this
    return object: Iterator<Element> {
        private var next: Element? = null
        private var isAtEnd = false

        override fun hasNext(): Boolean {
            setNext()
            return !isAtEnd
        }

        override fun next(): Element {
            setNext()
            return next!!
        }

        private fun setNext() {
            if (next == null && !isAtEnd) {
                next = iter.next()
                if (next == null) {
                    isAtEnd = true
                }
            }
        }
    }
}

fun <Element> Iterator<Element>.swift(nocopy: Boolean = false): IteratorProtocol<Element> {
    val iter = this
    return object: IteratorProtocol<Element> {
        override fun next(): Element? {
            return if (iter.hasNext()) iter.next() else null
        }
    }
}