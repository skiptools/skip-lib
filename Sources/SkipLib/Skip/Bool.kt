// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
package skip.lib

fun Boolean.random(using: InOut<RandomNumberGenerator>? = null): Boolean {
    return (using?.value ?: systemRandom).next() % 2UL == 0UL
}
