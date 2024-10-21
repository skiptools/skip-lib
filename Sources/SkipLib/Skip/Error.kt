// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
    constructor(message: String?): this(message, null)
    constructor(cause: Throwable?): this(null, cause)
}
