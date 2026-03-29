// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

/// Kotlin representation of `Swift.Error`.
interface Error {
    val localizedDescription: String
        get() = description
}

/// Used by the transpiler to give Errors to Swift code expecting them.
fun Throwable.aserror(): Error {
    if (this is Error) {
        return this
    } else {
        return ErrorException(this)
    }
}

/// Wrap a Kotlin exception to implement `Swift.Error`.
class ErrorException: Exception, Error {
    constructor(): super()
    constructor(message: String?, cause: Throwable?): super(message, cause)
    constructor(message: String?): super(message)
    constructor(cause: Throwable?): super(cause)
}
