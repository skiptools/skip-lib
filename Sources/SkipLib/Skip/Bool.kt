// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
package skip.lib

fun Boolean.random(using: InOut<RandomNumberGenerator>? = null): Boolean {
    return (using?.value ?: systemRandom).next() % 2UL == 0UL
}
