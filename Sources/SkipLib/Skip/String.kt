// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

import java.util.Random

/// Allow Swift code to reference Substring type.
class Substring(val stringValue: String, val startIndex: Int) {
    override fun toString(): String = stringValue
}

// We attempt to adapt Kotlin's native String type to Swift.String. This has limitations, but it is
// more efficient, provides better interoperability with other Kotlin code, and produces cleaner
// code than creating a custom wrapper

// Mimic Swift.String constructors
fun String(string: String): String = string
fun String(character: Char): String = character.toString()
fun String(substring: Substring): String = substring.stringValue
fun String(describing: Any?): String = describing?.toString() ?: "null"

fun String(sequence: Sequence<Char>): String {
    return StringBuilder().apply {
        sequence.forEach { append(it) }
    }.toString()
}

fun String(repeating: String, count: Int): String {
    return StringBuilder().apply {
        repeat(count) {
            append(repeating)
        }
    }.toString()
}

// Swift.String API
fun String.lowercased(): String = lowercase()
fun String.uppercased(): String = uppercase()
fun Substring.lowercased(): Substring = Substring(stringValue.lowercased(), startIndex)
fun Substring.uppercased(): Substring = Substring(stringValue.uppercase(), startIndex)

fun String.hasPrefix(prefix: String): Boolean = startsWith(prefix)
fun String.hasPrefix(prefix: Substring): Boolean = startsWith(prefix.stringValue)
fun Substring.hasPrefix(prefix: String): Boolean = stringValue.hasPrefix(prefix)
fun Substring.hasPrefix(prefix: Substring): Boolean = stringValue.hasPrefix(prefix)

fun String.hasSuffix(suffix: String): Boolean = endsWith(suffix)
fun String.hasSuffix(suffix: Substring): Boolean = endsWith(suffix.stringValue)
fun Substring.hasSuffix(suffix: String): Boolean = stringValue.hasSuffix(suffix)
fun Substring.hasSuffix(suffix: Substring): Boolean = stringValue.hasSuffix(suffix)

// String.contains(String) used as-is
fun String.contains(string: Substring): Boolean = contains(string.stringValue)
fun Substring.contains(string: String): Boolean = stringValue.contains(string)
fun Substring.contains(string: Substring): Boolean = stringValue.contains(string)

// String.plus(Any?) used as-is
operator fun Substring.plus(string: Any): Substring = Substring(string.toString(), startIndex)

// MARK: - Sequence

fun String.makeIterator(): IteratorProtocol<Char> {
    val iter = iterator()
    return object: IteratorProtocol<Char> {
        override fun next(): Char? {
            return if (iter.hasNext()) iter.next() else null
        }
    }
}
fun Substring.makeIterator(): IteratorProtocol<Char> = stringValue.makeIterator()

val String.underestimatedCount: Int
    get() = 0
val Substring.underestimatedCount: Int
    get() = stringValue.underestimatedCount

fun <T> String.withContiguousStorageIfAvailable(body: (Any) -> T): T? = null
fun <T> Substring.withContiguousStorageIfAvailable(body: (Any) -> T): T? = null

fun String.shuffled(using: InOut<RandomNumberGenerator>? = null): Array<Char> {
    val list = ArrayList<Char>()
    list.addAll(this.asIterable())
    list.shuffle(using)
    return Array(list, nocopy = true)
}
fun Substring.shuffled(using: InOut<RandomNumberGenerator>? = null): Array<Char> = stringValue.shuffled(using)

fun String.count(where: (Char) -> Boolean): Int {
    var count = 0
    for (c in this) {
        if (where(c)) {
            count++
        }
    }
    return count
}
fun Substring.count(where: (Char) -> Boolean): Int = stringValue.count(where)

fun <RE> String.map(transform: (Char) -> RE): Array<RE> {
    val list = ArrayList<RE>()
    for (c in this) {
        list.add(transform(c))
    }
    return Array(list, nocopy = true)
}
fun <RE> Substring.map(transform: (Char) -> RE): Array<RE> = stringValue.map(transform)

fun String.filter(isIncluded: (Char) -> Boolean): String {
    val string = this
    return StringBuilder().apply {
        string.forEach { if (isIncluded(it)) append(it) }
    }.toString()
}
fun Substring.filter(isIncluded: (Char) -> Boolean): String = stringValue.filter(isIncluded)

// String.forEach used as-is
fun Substring.forEach(body: (Char) -> Unit) = stringValue.forEach(body)

fun String.first(where: (Char) -> Boolean): Char? = firstOrNull(where)
fun Substring.first(where: (Char) -> Boolean): Char? = stringValue.first(where)

fun String.suffix(maxLength: Int): String {
    val numberToDrop = max(0, length - maxLength)
    return dropFirst(numberToDrop)
}
fun Substring.suffix(maxLength: Int): String = stringValue.suffix(maxLength)

fun String.dropFirst(k: Int = 1): String = drop(k)
fun Substring.dropFirst(k: Int = 1): String = stringValue.drop(k)

// String.dropLast(k) used as-is
fun String.dropLast(): String = dropLast(1)
fun Substring.dropLast(k: Int = 1): String = stringValue.dropLast(k)

fun String.drop(while_: (Char) -> Boolean): String = dropWhile(while_)
fun Substring.drop(while_: (Char) -> Boolean): String = stringValue.drop(while_)

fun String.prefix(maxLength: Int): String = take(maxLength)
fun Substring.prefix(maxLength: Int): String = stringValue.prefix(maxLength)
fun String.prefix(while_: (Char) -> Boolean): String = takeWhile(while_)
fun Substring.prefix(while_: (Char) -> Boolean): String = stringValue.prefix(while_)

fun String.enumerated(): Sequence<Tuple2<Int, Char>> {
    val stringIterator = { iterator() }
    val enumeratedIterable = object: Iterable<Tuple2<Int, Char>> {
        override fun iterator(): Iterator<Tuple2<Int, Char>> {
            var offset = 0
            val iter = stringIterator()
            return object: Iterator<Tuple2<Int, Char>> {
                override fun hasNext(): Boolean = iter.hasNext()
                override fun next(): Tuple2<Int, Char> = Tuple2(offset++, iter.next())
            }
        }
    }
    return object: Sequence<Tuple2<Int, Char>> {
        override val iterable: Iterable<Tuple2<Int, Char>>
            get() = enumeratedIterable
    }
}
fun Substring.enumerated(): Sequence<Tuple2<Int, Char>> = stringValue.enumerated()
fun String.min(by: (Char, Char) -> Boolean): Char? {
    return minWithOrNull(object: Comparator<Char> {
        override fun compare(c0: Char, c1: Char): Int {
            return c0.compareTo(c1)
        }
    })
}
fun Substring.min(by: (Char, Char) -> Boolean): Char? = stringValue.min(by)

fun String.min(): Char? = min { c0, c1 -> c0 < c1 }
fun Substring.min(): Char? = stringValue.min()

fun String.starts(with: String): Boolean {
    return startsWith(with)
}
fun Substring.starts(with: String): Boolean {
    return stringValue.startsWith(with)
}
fun String.starts(with: String, by: (Char, Char) -> Boolean): Boolean {
    if (with.length > length) {
        return false
    }
    for (i in 0 until with.length) {
        if (!by(with[i], this[i])) {
            return false
        }
    }
    return true
}
fun Substring.starts(with: String, by: (Char, Char) -> Boolean): Boolean {
    return stringValue.starts(with, by)
}

fun String.elementsEqual(other: String, by: (Char, Char) -> Boolean = { it1, it2 -> it1 == it2 }): Boolean {
    if (length != other.length) {
        return false
    }
    for ((c0, c1) in zip(other)) {
        if (!by(c0, c1)) {
            return false
        }
    }
    return true
}
fun String.elementsEqual(other: Substring, by: (Char, Char) -> Boolean = { it1, it2 -> it1 == it2 }): Boolean = elementsEqual(other.stringValue, by)
fun Substring.elementsEqual(other: String, by: (Char, Char) -> Boolean = { it1, it2 -> it1 == it2 }): Boolean = stringValue.elementsEqual(other, by)
fun Substring.elementsEqual(other: Substring, by: (Char, Char) -> Boolean = { it1, it2 -> it1 == it2 }): Boolean = stringValue.elementsEqual(other.stringValue, by)

fun String.contains(where: (Char) -> Boolean): Boolean {
    for (c in this) {
        if (where(c)) return true
    }
    return false
}
fun Substring.contains(where: (Char) -> Boolean): Boolean = stringValue.contains(where)

// WARNING: Although 'initialResult' is not a labeled parameter in Swift, the transpiler inserts it
// into our Kotlin call sites to differentiate between calls to the two reduce() functions. Do not change
fun <R> String.reduce(initialResult: R, nextPartialResult: (R, Char) -> R): R {
    return fold(initialResult, nextPartialResult)
}
fun <R> Substring.reduce(initialResult: R, nextPartialResult: (R, Char) -> R): R = stringValue.reduce(initialResult, nextPartialResult)

fun <R> String.reduce(unusedp: Nothing? = null, into: R, updateAccumulatingResult: (InOut<R>, Char) -> Unit): R {
    return fold(into) { result, element ->
        var accResult = result
        val inoutAccResult = InOut<R>({ accResult }, { accResult = it })
        updateAccumulatingResult(inoutAccResult, element)
        accResult
    }
}
fun <R> Substring.reduce(unusedp: Nothing? = null, into: R, updateAccumulatingResult: (InOut<R>, Char) -> Unit): R = stringValue.reduce(unusedp, into, updateAccumulatingResult)

// String.reversed() used as-is
fun Substring.reversed(): Substring = Substring(stringValue.reversed(), startIndex)

fun <RE> String.flatMap(transform: (Char) -> Sequence<RE>): Array<RE> {
    val array = Array<RE>()
    for (c in this) {
        array.append(contentsOf = transform(c))
    }
    return array
}
fun <RE> Substring.flatMap(transform: (Char) -> Sequence<RE>): Array<RE> = stringValue.flatMap(transform)

fun <RE> String.compactMap(transform: (Char) -> RE?): Array<RE> {
    return Array(mapNotNull(transform), nocopy = true)
}
fun <RE> Substring.compactMap(transform: (Char) -> RE?): Array<RE> = stringValue.compactMap(transform)

fun String.split(separator: Char, maxSplits: Int = Int.max, omittingEmptySubsequences: Boolean = true): Array<String> {
    val limit = if (maxSplits == Int.max) 0 else maxSplits
    var splits = split(separator, limit = limit)
    if (omittingEmptySubsequences) {
        splits = splits.filter { !it.isEmpty }
    }
    return Array(splits, nocopy = true)
}
fun Substring.split(separator: Char, maxSplits: Int = Int.max, omittingEmptySubsequences: Boolean = true): Array<String> = stringValue.split(separator = separator, maxSplits = maxSplits, omittingEmptySubsequences = omittingEmptySubsequences)

fun String.joined(): String = this
fun Substring.joined(): String = stringValue

fun String.joined(separator: String): String = buildString {
    val itr = iterator()
    while (itr.hasNext()) {
        append(itr.next())
        if (itr.hasNext()) {
            append(separator)
        }
    }
}
fun Substring.joined(separator: String): String = stringValue.joined(separator = separator)

fun String.sorted(): Array<Char> {
    return Array(sorted(), nocopy = true)
}
fun Substring.sorted() = stringValue.sorted()

// String.contains(char: Char) used as-is
fun Substring.contains(char: Char): Boolean = stringValue.contains(char)

// MARK: - Collection

val String.startIndex: Int
    get() = 0
val String.endIndex: Int
    get() = count()
// Substring.startIndex used as-is
val Substring.endIndex: Int
    get() = startIndex + stringValue.count()

// String.get(position: Int) used as-is
operator fun Substring.get(position: Int): Char = stringValue.get(position - startIndex)

val String.isEmpty: Boolean
    get() = isEmpty()
val Substring.isEmpty: Boolean
    get() = stringValue.isEmpty

val String.count: Int
    get() = count()
val Substring.count: Int
    get() = stringValue.count

fun String.index(i: Int, offsetBy: Int): Int = i + offsetBy
fun String.distance(from: Int, to: Int): Int = to - from
fun String.index(after: Int): Int = after + 1
fun String.index(before: Int, unusedp: Any? = null): Int = before - 1
fun Substring.index(i: Int, offsetBy: Int): Int = i + offsetBy
fun Substring.distance(from: Int, to: Int): Int = to - from
fun Substring.index(after: Int): Int = after + 1
fun Substring.index(before: Int, unusedp: Any? = null): Int = before - 1

fun String.formIndex(after: InOut<Int>) {
    after.value = after.value + 1
}
fun Substring.formIndex(after: InOut<Int>): Unit = stringValue.formIndex(after)
fun String.formIndex(i: InOut<Int>, offsetBy: Int) {
    i.value = i.value + offsetBy
}
fun Substring.formIndex(i: InOut<Int>, offsetBy: Int): Unit = stringValue.formIndex(i, offsetBy)

fun String.randomElement(using: InOut<RandomNumberGenerator>? = null): Char? {
    return if (isEmpty) null else elementAt(Int.random(0 until count(), using))
}
fun Substring.randomElement(using: InOut<RandomNumberGenerator>? = null): Char? = stringValue.randomElement(using)

val String.first: Char?
    get() = firstOrNull()
val Substring.first: Char?
    get() = stringValue.first

fun String.prefix(upTo: Int, unusedp: Any? = null): String {
    return substring(0 until upTo)
}
fun Substring.prefix(upTo: Int, unusedp: Any? = null): String {
    return stringValue.substring(0 until upTo - startIndex)
}

fun String.prefix(through: Int, unusedp0: Any? = null, unusedp1: Any? = null): String {
    return prefix(upTo = through + 1)
}
fun Substring.prefix(through: Int, unusedp0: Any? = null, unusedp1: Any? = null): String {
    return prefix(upTo = through + 1)
}

fun String.suffix(from: Int, unusedp: Any? = null): String {
    return substring(from until length)
}
fun Substring.from(from: Int, unusedp: Any? = null): String {
    return stringValue.substring(from - startIndex until stringValue.length)
}

fun String.firstIndex(of: Char): Int? {
    val index = indexOf(of)
    return if (index == -1) null else index
}
fun Substring.firstIndex(of: Char): Int? {
    val index = stringValue.indexOf(of)
    return if (index == -1) null else index + startIndex
}
// Skip can't differentiate between Char and String args
fun String.firstIndex(of: String): Int? {
    return firstIndex(of[0])
}
fun Substring.firstIndex(of: String): Int? {
    return firstIndex(of[0])
}

fun String.firstIndex(where: (Char) -> Boolean): Int? {
    val index = indexOfFirst(where)
    return if (index == -1) null else index
}
fun Substring.firstIndex(where: (Char) -> Boolean): Int? {
    val index = stringValue.indexOfFirst(where)
    return if (index == -1) null else index + startIndex
}

operator fun String.get(range: IntRange): Substring {
    // We translate open ranges to use Int.min and Int.max in Kotlin
    val lowerBound = if (range.start == Int.min) 0 else range.start
    val upperBound = if (range.endInclusive == Int.max) count() else range.endInclusive + 1
    val stringValue = slice(lowerBound until upperBound)
    return Substring(stringValue, lowerBound)
}
operator fun Substring.get(range: IntRange): Substring {
    // We translate open ranges to use Int.min and Int.max in Kotlin
    val lowerBound = if (range.start == Int.min) 0 else range.start
    val upperBound = if (range.endInclusive == Int.max) stringValue.count() + startIndex else range.endInclusive + 1
    val stringValue = stringValue.slice((lowerBound - startIndex) until (upperBound - startIndex))
    return Substring(stringValue, lowerBound - startIndex)
}

// MARK: - BidirectionalCollection

fun String.last(where: (Char) -> Boolean): Char? = lastOrNull(where)
fun Substring.last(where: (Char) -> Boolean): Char? = stringValue.last(where)

val String.last: Char?
    get() = lastOrNull()
val Substring.last: Char?
    get() = stringValue.last

fun String.lastIndex(of: Char): Int? {
    val index = lastIndexOf(of)
    return if (index == -1) null else index
}
fun String.lastIndex(where: (Char) -> Boolean): Int? {
    val index = indexOfLast(where)
    return if (index == -1) null else index
}

fun String.matches(of: Regex): Array<Regex.Match> {
    return of.matches(this)
}

fun String.replacing(regex: Regex, with: String): String {
    return regex.replace(this, with)
}

operator fun String.Companion.invoke(format: String, vararg args: Any): String {
    return format.kotlinFormatString.format(*args)
}

operator fun String.Companion.invoke(format: String, arguments: Array<Any>): String {
    return format.kotlinFormatString.format(*arguments.toList().toTypedArray())
}

// Mapping of valid Objective-C format specifiers into Java format specifiers.
// In Java, the "%f" specifier is used to format both regular and long double-precision floating-point numbers.
// Convert: "%@" into "%s", "%llf" into "%f", "%ld" into "%d", and "%2$@ %1$lld %3$lf" into "%2$s %1$d %3$f"
private val objc2JavaPatterns = mapOf(
    "@" to "s",
    "d" to "d",
    "f" to "f",
    "llf" to "f",
    "lf" to "f",
    "lld" to "d",
    "ld" to "d",
    "u" to "d",
)

// This will create the regular expression: "(?<!%)%(\\d+\\$)?(\\d*\\.?\\d+)?(@|d|f|llf|lf|lld|ld|u)"
// (?<!%) is a negative lookbehind assertion, ensuring that % is not preceded by another % (which is how literal "%" characters are escaped)
private val objcPatternSpecifiers = kotlin.text.Regex("(?<!%)%(\\d+\\$)?(\\d*\\.?\\d+)?(${objc2JavaPatterns.keys.sorted().joinToString("|")})")

/// Convert from Swift String.init(format:) pattern into a Kotlin-compatible format string: https://kotlinlang.org/docs/strings.html#string-formatting
val String.kotlinFormatString: String
    get() = kotlinFormatInfo().first

/// Convert from Swift String.init(format:) pattern into a Kotlin-compatible format string: https://kotlinlang.org/docs/strings.html#string-formatting.
///
/// Return tuple includes the indexes of the interpolation substitutions, if any.
fun String.kotlinFormatInfo(interpolationIndex: Int = 0, removePositions: Boolean = false): Pair<String, List<Int>?> {
    var nextInterpolationIndex = interpolationIndex + 1
    var interpolationIndexes: MutableList<Int>? = null
    val format = objcPatternSpecifiers.replace(this) { matchResult ->
        val matchedString = matchResult.value
        val positionalArg = matchResult.groupValues[1] // may be empty
        if (interpolationIndexes == null) {
            interpolationIndexes = ArrayList<Int>(3)
        }
        if (positionalArg.length > 1) {
            interpolationIndexes!!.add(positionalArg.dropLast(1).toInt())
        } else {
            interpolationIndexes!!.add(nextInterpolationIndex++)
        }
        var paddingPrecisionArg = matchResult.groupValues[2] // may be empty
        val objCSpecifier = matchResult.groupValues[3]
        val javaSpecifier = objc2JavaPatterns[objCSpecifier] ?: objCSpecifier
        // https://github.com/skiptools/skip-lib/issues/2 : a format like "%0.3f" is tolerated in Swift but raises a java.util.MissingFormatWidthException because the "0" is being treated as a flag
        if (paddingPrecisionArg.startsWith("0.")) {
            paddingPrecisionArg = paddingPrecisionArg.drop(1)
        }
        if (removePositions) {
            "%${paddingPrecisionArg}${javaSpecifier}"
        } else {
            "%${positionalArg}${paddingPrecisionArg}${javaSpecifier}"
        }
    }
    return Pair(format, interpolationIndexes)
}

fun zip(sequence1: String, sequence2: String): Array<Tuple2<Char, Char>> {
    val zipped = sequence1.zip(sequence2)
    val list = ArrayList<Tuple2<Char, Char>>(zipped.size)
    for ((c1, c2) in zipped) {
        list.add(Tuple2(c1, c2))
    }
    return Array(list, nocopy = true)
}

// MARK: - Character

fun Char(char: Char): Char = char
fun Char(string: String): Char = if (string == "\r\n") string[1] else string[0]

// Also see SkipFoundation.CharacterSet.whitespaces/whitespacesAndNewlines
val Char.isWhitespace: Boolean
    get() = when (this) {
        ' ', '\t', '\u2029', '\u3000' -> true
        else -> false
    }
val Char.isNewline: Boolean
    get() = when (this) {
        '\n', '\r', '\u000B', '\u000C', '\u0085', '\u2028', '\u2029' -> true
        else -> false
    }

fun Char.uppercased(): String = toString().uppercased()
fun Char.lowercased(): String = toString().lowercased()

val Char.asciiValue: UByte?
    get() = if (isASCII) code.toUByte() else null

val Char.isASCII: Boolean
    get() = code in 0..127
