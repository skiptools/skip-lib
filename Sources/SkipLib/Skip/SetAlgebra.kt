// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Kotlin representation of `Swift.SetAlgebra`.
interface SetAlgebra<T, Element> where T: SetAlgebra<T, Element> {
    fun contains(element: Element): Boolean
    fun union(other: T): T
    fun intersection(other: T): T
    fun symmetricDifference(other: T): T
    fun insert(element: Element): Tuple2<Boolean, Element>
    fun remove(element: Element): Element?
    fun update(with: Element): Element?
    fun formUnion(other: T)
    fun formIntersection(other: T)
    fun formSymmetricDifference(other: T)
    fun subtracting(other: T): T
    fun isSubset(of: T): Boolean
    fun isDisjoint(with: T): Boolean
    fun isSuperset(of: T): Boolean
    val isEmpty: Boolean
    fun subtract(other: T)
    fun isStrictSubset(of: T): Boolean
    fun isStrictSuperset(of: T): Boolean
}
