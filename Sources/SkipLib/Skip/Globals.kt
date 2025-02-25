// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

internal val systemRandom = SystemRandomNumberGenerator()

typealias Never = Nothing
typealias AnyClass = kotlin.reflect.KClass<*>

fun type(of: Any): kotlin.reflect.KClass<*> = of::class

fun fatalError(message: String = "fatalError"): Nothing = error(message)
fun assertionFailure(message: String = "assertionFailure"): Nothing = error(message)
// We can use Kotlin's assert(value: Boolean) function as-is
fun assert(value: Boolean, message: String): Unit = kotlin.assert(value, { message })
fun preconditionFailure(message: String = "preconditionFailure"): Nothing = error(message)
fun precondition(condition: Boolean, message: String = "precondition"): Unit = require(condition, { message })

fun <T> swap(a: InOut<T>, b: InOut<T>) {
    val t = a.value
    a.value = b.value
    b.value = t
}

fun <T : Comparable<T>> min(a: T, b: T): T {
	return if (a <= b) a else b
}

fun <T : Comparable<T>> max(a: T, b: T): T {
	return if (a >= b) a else b
}

fun print(vararg args: Any?, separator: String = " ", terminator: String = "\n") {
	args.forEachIndexed { index, arg ->
		if (index > 0) kotlin.io.print(separator)
		kotlin.io.print(arg)
	}
	kotlin.io.print(terminator)
}

fun debugPrint(vararg args: Any?, separator: String = " ", terminator: String = "\n") = print(args, separator, terminator)

/// Throws from transpiled optional constructors.
///
/// Kotlin constructors cannot return null, so throw this exception instead. The transpiler
/// adds code to catch this exception and substitute a null value.
class NullReturnException: Exception() {
}
