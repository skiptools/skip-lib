// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

/// Used by the transpiler to implement `inout` Swift parameters.
class InOut<T>(val get: () -> T, val set: (T) -> Unit) {
    var value: T
        get() = this.get()
        set(newValue) = this.set(newValue)
}
