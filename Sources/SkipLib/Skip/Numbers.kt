// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

val Byte.Companion.max: Byte get() = Byte.MAX_VALUE
val Byte.Companion.min: Byte get() = Byte.MIN_VALUE
val UByte.Companion.max: Byte get() = Byte.MAX_VALUE
val UByte.Companion.min: UByte get() = UByte.MIN_VALUE

val Short.Companion.max: Short get() = Short.MAX_VALUE
val Short.Companion.min: Short get() = Short.MIN_VALUE
val UShort.Companion.max: UShort get() = UShort.MAX_VALUE
val UShort.Companion.min: UShort get() = UShort.MIN_VALUE

val Int.Companion.max: Int get() = Int.MAX_VALUE
val Int.Companion.min: Int get() = Int.MIN_VALUE
val UInt.Companion.max: UInt get() = UInt.MAX_VALUE
val UInt.Companion.min: UInt get() = UInt.MIN_VALUE

val Long.Companion.max: Long get() = Long.MAX_VALUE
val Long.Companion.min: Long get() = Long.MIN_VALUE
val ULong.Companion.max: ULong get() = ULong.MAX_VALUE
val ULong.Companion.min: ULong get() = ULong.MIN_VALUE

val Double.Companion.nan: Double get() = Double.NaN
val Double.isNaN: Boolean get() = isNaN()
val Double.isFinite: Boolean get() = isFinite()
val Double.isInfinite: Boolean get() = isInfinite()
val Double.Companion.infinity: Double get() = Double.POSITIVE_INFINITY
val Double.Companion.pi: Double get() = kotlin.math.PI

val Float.Companion.nan: Float get() = Float.NaN
val Float.isNaN: Boolean get() = isNaN()
val Float.isFinite: Boolean get() = isFinite()
val Float.isInfinite: Boolean get() = isInfinite()
val Float.Companion.infinity: Float get() = Float.POSITIVE_INFINITY
val Float.Companion.pi: Float get() = 3.1415925f

fun Byte(number: Number): Byte = number.toByte()
fun Byte(number: UByte): Byte = number.toByte()
fun Byte(number: UShort): Byte = number.toByte()
fun Byte(number: UInt): Byte = number.toByte()
fun Byte(number: ULong): Byte = number.toByte()
fun Byte(string: String): Byte? = try { string.toByte() } catch (e: NumberFormatException) { null }

fun Short(number: Number): Short = number.toShort()
fun Short(number: UByte): Short = number.toShort()
fun Short(number: UShort): Short = number.toShort()
fun Short(number: UInt): Short = number.toShort()
fun Short(number: ULong): Short = number.toShort()
fun Short(string: String): Short? = try { string.toShort() } catch (e: NumberFormatException) { null }

fun Int(number: Number): Int = number.toInt()
fun Int(number: UByte): Int = number.toInt()
fun Int(number: UShort): Int = number.toInt()
fun Int(number: UInt): Int = number.toInt()
fun Int(number: ULong): Int = number.toInt()
fun Int(string: String): Int? = try { string.toInt() } catch (e: NumberFormatException) { null }

fun Long(number: Number): Long = number.toLong()
fun Long(number: UByte): Long = number.toLong()
fun Long(number: UShort): Long = number.toLong()
fun Long(number: UInt): Long = number.toLong()
fun Long(number: ULong): Long = number.toLong()
fun Long(string: String): Long? = try { string.toLong() } catch (e: NumberFormatException) { null }

fun UByte(number: Number): UByte = number.toLong().toUByte()
fun UByte(number: UByte): UByte = number
fun UByte(number: UShort): UByte = number.toUByte()
fun UByte(number: UInt): UByte = number.toUByte()
fun UByte(number: ULong): UByte = number.toUByte()
fun UByte(string: String): UByte? = try { string.toUByte() } catch (e: NumberFormatException) { null }

fun UShort(number: Number): UShort = number.toLong().toUShort()
fun UShort(number: UByte): UShort = number.toUShort()
fun UShort(number: UShort): UShort = number
fun UShort(number: UInt): UShort = number.toUShort()
fun UShort(number: ULong): UShort = number.toUShort()
fun UShort(string: String): UShort? = try { string.toUShort() } catch (e: NumberFormatException) { null }

fun UInt(number: Number): UInt = number.toLong().toUInt()
fun UInt(number: UByte): UInt = number.toUInt()
fun UInt(number: UShort): UInt = number.toUInt()
fun UInt(number: UInt): UInt = number
fun UInt(number: ULong): UInt = number.toUInt()
fun UInt(string: String): UInt? = try { string.toUInt() } catch (e: NumberFormatException) { null }

fun ULong(number: Number): ULong = number.toLong().toULong()
fun ULong(number: UByte): ULong = number.toULong()
fun ULong(number: UShort): ULong = number.toULong()
fun ULong(number: UInt): ULong = number.toULong()
fun ULong(number: ULong): ULong = number
fun ULong(string: String): ULong? = try { string.toULong() } catch (e: NumberFormatException) { null }

fun Float(number: Number): Float = number.toFloat()
fun Float(number: UByte): Float = number.toFloat()
fun Float(number: UShort): Float = number.toFloat()
fun Float(number: UInt): Float = number.toFloat()
fun Float(number: ULong): Float = number.toFloat()
fun Float(string: String): Float? = try { string.toFloat() } catch (e: NumberFormatException) { null }

fun Double(number: Number): Double = number.toDouble()
fun Double(number: UByte): Double = number.toDouble()
fun Double(number: UShort): Double = number.toDouble()
fun Double(number: UInt): Double = number.toDouble()
fun Double(number: ULong): Double = number.toDouble()
fun Double(string: String): Double? = try { string.toDouble() } catch (e: NumberFormatException) { null }

val M_E: Double get() = kotlin.math.E
val M_LOG2E: Double get() = kotlin.math.ln(kotlin.math.E) / kotlin.math.ln(2.0)
val M_LOG10E: Double get() = kotlin.math.ln(kotlin.math.E) / kotlin.math.ln(10.0)
val M_LN2: Double get() = kotlin.math.ln(2.0)
val M_LN10: Double get() = kotlin.math.ln(10.0)
val M_PI: Double get() = kotlin.math.PI
