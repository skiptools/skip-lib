// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

/// Used by the transpiler to implement `inout` Swift parameters.
class InOut<T>(val get: () -> T, val set: (T) -> Unit) {
    var value: T
        get() = this.get()
        set(newValue) = this.set(newValue)
}
