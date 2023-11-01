// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

fun Boolean.random(using: InOut<RandomNumberGenerator>? = null): Boolean {
    return (using?.value ?: systemRandom).next() % 2UL == 0UL
}
