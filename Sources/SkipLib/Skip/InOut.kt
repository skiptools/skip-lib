// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

/// Used by the transpiler to implement `inout` Swift parameters.
class InOut<T>(val get: () -> T, val set: (T) -> Unit) {
    var value: T
        get() = this.get()
        set(newValue) = this.set(newValue)
}
