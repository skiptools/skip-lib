// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Kotlin representation of `Swift.OptionSet`.
interface OptionSet<T, R>: RawRepresentable<R>, SetAlgebra<T, T> where T: OptionSet<T, R> {
    // The transpiler adds implentations of these requirements to OptionSet types
    val rawvaluelong: ULong
    fun makeoptionset(rawvaluelong: ULong): T
    fun assignoptionset(target: T)

    // MARK: - SetAlgebra

    override fun contains(element: T): Boolean {
        return (rawvaluelong and element.rawvaluelong) == element.rawvaluelong
    }

    override fun union(other: T): T {
        return makeoptionset(rawvaluelong or other.rawvaluelong)
    }

    override fun intersection(other: T): T {
        return makeoptionset(rawvaluelong and other.rawvaluelong)
    }

    override fun symmetricDifference(other: T): T {
        return makeoptionset(rawvaluelong xor other.rawvaluelong)
    }

    override fun insert(element: T): Tuple2<Boolean, T> {
        if (contains(element)) {
            return Tuple2(false, element)
        }
        val target = makeoptionset(rawvaluelong or element.rawvaluelong)
        assignoptionset(target)
        return Tuple2(true, element)
    }

    override fun remove(element: T): T? {
        if (contains(element)) {
            val target = makeoptionset(rawvaluelong and element.rawvaluelong.inv())
            assignoptionset(target)
            return element
        } else {
            return null
        }
    }

    override fun update(with: T): T? {
        val target = makeoptionset(rawvaluelong or with.rawvaluelong)
        val ret = if (contains(with)) with else null
        assignoptionset(target)
        return ret
    }

    override fun formUnion(other: T) {
        assignoptionset(union(other))
    }

    override fun formIntersection(other: T) {
        assignoptionset(intersection(other))
    }

    override fun formSymmetricDifference(other: T) {
        assignoptionset(symmetricDifference(other))
    }

    override fun subtracting(other: T): T {
        return makeoptionset(rawvaluelong and other.rawvaluelong.inv())
    }

    override fun isSubset(of: T): Boolean {
        return (of.rawvaluelong and rawvaluelong) == rawvaluelong
    }

    override fun isDisjoint(with: T): Boolean {
        return (rawvaluelong and with.rawvaluelong) == 0UL
    }

    override fun isSuperset(of: T): Boolean {
        return (rawvaluelong and of.rawvaluelong) == of.rawvaluelong
    }

    override val isEmpty: Boolean
        get() = rawvaluelong == 0UL

    override fun subtract(other: T) {
        assignoptionset(subtracting(other))
    }

    override fun isStrictSubset(of: T): Boolean {
        return isSubset(of) && rawvaluelong != of.rawvaluelong
    }

    override fun isStrictSuperset(of: T): Boolean {
        return isSuperset(of) && rawvaluelong != of.rawvaluelong
    }
}
