// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

// Supported tuple arities. The transpiler translates Swift tuples into these types

// These types are not themselves mutable, but their members might be, and a destructuring assignment can
// access members without calling `sref()` on them. So support `sref()` on the tuples themselves. Note that
// because the tuples aren't mutable, we can ignore the `MutableStruct.onUpdate` closures

data class Tuple2<E0, E1>(val _e0: E0, val _e1: E1): Comparable<Tuple2<E0, E1>> {
    val element0: E0
        get() = _e0.sref()
    val element1: E1
        get() = _e1.sref()

    @Suppress("UNCHECKED_CAST")
    override fun compareTo(other: Tuple2<E0, E1>): Int {
        if (_e0 !is Comparable<*>) return 0
        val e0cmp = (_e0 as Comparable<E0>).compareTo(other._e0)
        if (e0cmp != 0) return e0cmp

        if (_e1 !is Comparable<*>) return 0
        return (_e1 as Comparable<E1>).compareTo(other._e1)
    }

    fun sref(@Suppress("UNUSED_PARAMETER") onUpdate: ((Tuple2<E0, E1>) -> Unit)? = null): Tuple2<E0, E1> {
        val e0 = _e0.sref()
        val e1 = _e1.sref()
        if (e0 !== _e0 || e1 !== _e1) {
            return Tuple2(e0, e1)
        }
        return this
    }
}

data class Tuple3<E0, E1, E2>(val _e0: E0, val _e1: E1, val _e2: E2): Comparable<Tuple3<E0, E1, E2>> {
    val element0: E0
        get() = _e0.sref()
    val element1: E1
        get() = _e1.sref()
    val element2: E2
        get() = _e2.sref()

    @Suppress("UNCHECKED_CAST")
    override fun compareTo(other: Tuple3<E0, E1, E2>): Int {
        if (_e0 !is Comparable<*>) return 0
        val e0cmp = (_e0 as Comparable<E0>).compareTo(other._e0)
        if (e0cmp != 0) return e0cmp

        if (_e1 !is Comparable<*>) return 0
        val e1cmp = (_e1 as Comparable<E1>).compareTo(other._e1)
        if (e1cmp != 0) return e1cmp

        if (_e2 !is Comparable<*>) return 0
        return (_e2 as Comparable<E2>).compareTo(other._e2)
    }

    fun sref(@Suppress("UNUSED_PARAMETER") onUpdate: ((Tuple3<E0, E1, E2>) -> Unit)? = null): Tuple3<E0, E1, E2> {
        val e0 = _e0.sref()
        val e1 = _e1.sref()
        val e2 = _e2.sref()
        if (e0 !== _e0 || e1 !== _e1 || e2 !== _e2) {
            return Tuple3(e0, e1, e2)
        }
        return this
    }
}

data class Tuple4<E0, E1, E2, E3>(val _e0: E0, val _e1: E1, val _e2: E2, val _e3: E3): Comparable<Tuple4<E0, E1, E2, E3>> {
    val element0: E0
        get() = _e0.sref()
    val element1: E1
        get() = _e1.sref()
    val element2: E2
        get() = _e2.sref()
    val element3: E3
        get() = _e3.sref()

    @Suppress("UNCHECKED_CAST")
    override fun compareTo(other: Tuple4<E0, E1, E2, E3>): Int {
        if (_e0 !is Comparable<*>) return 0
        val e0cmp = (_e0 as Comparable<E0>).compareTo(other._e0)
        if (e0cmp != 0) return e0cmp

        if (_e1 !is Comparable<*>) return 0
        val e1cmp = (_e1 as Comparable<E1>).compareTo(other._e1)
        if (e1cmp != 0) return e1cmp

        if (_e2 !is Comparable<*>) return 0
        val e2cmp = (_e2 as Comparable<E2>).compareTo(other._e2)
        if (e2cmp != 0) return e2cmp

        if (_e3 !is Comparable<*>) return 0
        return (_e3 as Comparable<E3>).compareTo(other._e3)
    }

    fun sref(@Suppress("UNUSED_PARAMETER") onUpdate: ((Tuple4<E0, E1, E2, E3>) -> Unit)? = null): Tuple4<E0, E1, E2, E3> {
        val e0 = _e0.sref()
        val e1 = _e1.sref()
        val e2 = _e2.sref()
        val e3 = _e3.sref()
        if (e0 !== _e0 || e1 !== _e1 || e2 !== _e2 || e3 !== _e3) {
            return Tuple4(e0, e1, e2, e3)
        }
        return this
    }
}

data class Tuple5<E0, E1, E2, E3, E4>(val _e0: E0, val _e1: E1, val _e2: E2, val _e3: E3, val _e4: E4): Comparable<Tuple5<E0, E1, E2, E3, E4>> {
    val element0: E0
        get() = _e0.sref()
    val element1: E1
        get() = _e1.sref()
    val element2: E2
        get() = _e2.sref()
    val element3: E3
        get() = _e3.sref()
    val element4: E4
        get() = _e4.sref()

    @Suppress("UNCHECKED_CAST")
    override fun compareTo(other: Tuple5<E0, E1, E2, E3, E4>): Int {
        if (_e0 !is Comparable<*>) return 0
        val e0cmp = (_e0 as Comparable<E0>).compareTo(other._e0)
        if (e0cmp != 0) return e0cmp

        if (_e1 !is Comparable<*>) return 0
        val e1cmp = (_e1 as Comparable<E1>).compareTo(other._e1)
        if (e1cmp != 0) return e1cmp

        if (_e2 !is Comparable<*>) return 0
        val e2cmp = (_e2 as Comparable<E2>).compareTo(other._e2)
        if (e2cmp != 0) return e2cmp

        if (_e3 !is Comparable<*>) return 0
        val e3cmp = (_e3 as Comparable<E3>).compareTo(other._e3)
        if (e3cmp != 0) return e3cmp

        if (_e4 !is Comparable<*>) return 0
        return (_e4 as Comparable<E4>).compareTo(other._e4)
    }

    fun sref(@Suppress("UNUSED_PARAMETER") onUpdate: ((Tuple5<E0, E1, E2, E3, E4>) -> Unit)? = null): Tuple5<E0, E1, E2, E3, E4> {
        val e0 = _e0.sref()
        val e1 = _e1.sref()
        val e2 = _e2.sref()
        val e3 = _e3.sref()
        val e4 = _e4.sref()
        if (e0 !== _e0 || e1 !== _e1 || e2 !== _e2 || e3 !== _e3 || e4 !== _e4) {
            return Tuple5(e0, e1, e2, e3, e4)
        }
        return this
    }
}
