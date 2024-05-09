// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
package skip.lib

import kotlin.reflect.KClass

interface Codable: Decodable, Encodable {
}

interface Encodable {
    fun encode(to: Encoder)
}

interface Encoder {
    val codingPath: Array<CodingKey>
    val userInfo: Dictionary<CodingUserInfoKey, Any>
    fun <Key> container(keyedBy: KClass<Key>): KeyedEncodingContainer<Key> where Key: CodingKey
    fun unkeyedContainer(): UnkeyedEncodingContainer
    fun singleValueContainer(): SingleValueEncodingContainer
}

/// Helper base type for Kotlin top level encoders.
abstract class TopLevelEncoder<Output> {
    abstract fun encoder(): Encoder
    abstract fun output(from: Encoder): Output

    fun <T> encode(value: T): Output where T: Any {
        val encoder = encoder()
        if (value is Sequence<*>) {
            val container = encoder.unkeyedContainer()
            for (element in value.iterable) {
                codableUnkeyedEncode(element, container)
            }
        } else {
            val container = encoder.singleValueContainer()
            codableSingleValueEncode(value, container)
        }
        return output(encoder)
    }

    inline fun <reified K, V> encode(value: Dictionary<K, V>): Output where K: Any, V: Any {
        val encoder = encoder()
        if (K::class == Int::class || K::class == String::class) {
            encodeAsDictionary(value, encoder)
        } else {
            encodeAsArray(value, encoder)
        }
        return output(encoder)
    }

    fun encodeAsDictionary(value: Dictionary<*, *>, encoder: Encoder) {
        val container = encoder.container(keyedBy = DictionaryCodingKey::class)
        for ((dkey, dvalue) in value.storage) {
            codableDictionaryKeyedEncode(dvalue, dkey, container)
        }
    }

    fun <K, V> encodeAsArray(value: Dictionary<K, V>, encoder: Encoder) where K: Any, V: Any {
        val container = encoder.unkeyedContainer()
        for ((dkey, dvalue) in value.storage) {
            codableUnkeyedEncode(dkey, container)
            codableUnkeyedEncode(dvalue, container)
        }
    }
}

interface KeyedEncodingContainerProtocol<Key: CodingKey> {
    val codingPath: Array<CodingKey>
    fun encodeNil(forKey: CodingKey)
    fun encode(value: Boolean, forKey: CodingKey)
    fun encode(value: String, forKey: CodingKey)
    fun encode(value: Double, forKey: CodingKey)
    fun encode(value: Float, forKey: CodingKey)
    fun encode(value: Byte, forKey: CodingKey)
    fun encode(value: Short, forKey: CodingKey)
    fun encode(value: Int, forKey: CodingKey)
    fun encode(value: Long, forKey: CodingKey)
    fun encode(value: UByte, forKey: CodingKey)
    fun encode(value: UShort, forKey: CodingKey)
    fun encode(value: UInt, forKey: CodingKey)
    fun encode(value: ULong, forKey: CodingKey)
    fun <T> encode(value: T?, forKey: CodingKey) where T: Any

    fun <T> encodeConditional(object_: T, forKey: CodingKey) where T: Any {
        encode(object_, forKey)
    }

    fun encodeIfPresent(value: Boolean?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: String?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Double?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Float?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Byte?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Short?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Int?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Long?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UByte?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UShort?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UInt?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: ULong?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun <T> encodeIfPresent(value: T?, forKey: CodingKey) where T: Any {
        if (value != null) encode(value, forKey)
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: CodingKey): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(forKey: CodingKey): UnkeyedEncodingContainer
    fun superEncoder(): Encoder
    fun superEncoder(forKey: CodingKey): Encoder
}

class KeyedEncodingContainer<Key>(container: KeyedEncodingContainerProtocol<CodingKey>) : KeyedEncodingContainerProtocol<CodingKey> where Key: CodingKey {
    private val box: KeyedEncodingContainerProtocol<CodingKey> = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override fun encodeNil(forKey: CodingKey) {
        box.encodeNil(forKey)
    }

    override fun encode(value: Boolean, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: String, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Double, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Float, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Byte, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Short, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Int, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: Long, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: UByte, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: UShort, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: UInt, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun encode(value: ULong, forKey: CodingKey) {
        box.encode(value, forKey)
    }

    override fun <T> encode(value: T?, forKey: CodingKey) where T: Any {
        if (value is Sequence<*>) {
            val container = nestedUnkeyedContainer(forKey)
            container.encode(contentsOf = value)
        } else {
            box.encode(value, forKey)
        }
    }

    override fun <T> encodeConditional(object_: T, forKey: CodingKey) where T: Any {
        encode(object_, forKey) // Delegate to our method to handle Sequences
    }

    override fun encodeIfPresent(value: Boolean?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: String?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Double?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Float?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Byte?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Short?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Int?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Long?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UByte?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UShort?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UInt?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: ULong?, forKey: CodingKey) {
        box.encodeIfPresent(value, forKey)
    }

    override fun <T> encodeIfPresent(value: T?, forKey: CodingKey) where T: Any {
        if (value != null) encode(value, forKey) // Delegate to our function to handle Sequences
    }

    override fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: CodingKey): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return box.nestedContainer(keyedBy, forKey)
    }

    override fun nestedUnkeyedContainer(forKey: CodingKey): UnkeyedEncodingContainer {
        return box.nestedUnkeyedContainer(forKey)
    }

    override fun superEncoder(): Encoder {
        return box.superEncoder()
    }

    override fun superEncoder(forKey: CodingKey): Encoder {
        return box.superEncoder(forKey)
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified K, V> encode(value: Dictionary<K, V>, forKey: CodingKey) where K: Any, V: Any {
        if (K::class == Int::class || K::class == String::class) {
            encodeAsDictionary(value, forKey)
        } else {
            encodeAsArray(value, forKey)
        }
    }

    inline fun <reified K, V> encodeIfPresent(value: Dictionary<K, V>?, forKey: CodingKey) {
        if (value != null) encode(value, forKey)
    }

    fun encodeAsDictionary(value: Dictionary<*, *>, forKey: CodingKey) {
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class, forKey)
        for ((dkey, dvalue) in value.storage) {
            codableDictionaryKeyedEncode(dvalue, dkey, container)
        }
    }

    fun <K, V> encodeAsArray(value: Dictionary<K, V>, forKey: CodingKey) where K: Any, V: Any {
        val container = nestedUnkeyedContainer(forKey)
        for ((dkey, dvalue) in value.storage) {
            codableUnkeyedEncode(dkey, container)
            codableUnkeyedEncode(dvalue, container)
        }
    }
}

interface UnkeyedEncodingContainerProtocol {
    val codingPath: Array<CodingKey>
    val count: Int
    fun encodeNil()
    fun encode(value: Boolean)
    fun encode(value: String)
    fun encode(value: Double)
    fun encode(value: Float)
    fun encode(value: Byte)
    fun encode(value: Short)
    fun encode(value: Int)
    fun encode(value: Long)
    fun encode(value: UByte)
    fun encode(value: UShort)
    fun encode(value: UInt)
    fun encode(value: ULong)
    fun <T> encode(value: T) where T: Any

    fun <T> encodeConditional(object_: T) where T: Any {
        encode(object_)
    }

    fun encode(contentsOf: Sequence<*>) {
        for (element in contentsOf.iterable) {
            codableUnkeyedEncode(element, UnkeyedEncodingContainer(this))
        }
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(): UnkeyedEncodingContainer
    fun superEncoder(): Encoder
}

class UnkeyedEncodingContainer(container: UnkeyedEncodingContainerProtocol) : UnkeyedEncodingContainerProtocol {
    private val box: UnkeyedEncodingContainerProtocol = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override val count: Int
        get() = box.count

    override fun encodeNil() {
        box.encodeNil()
    }

    override fun encode(value: Boolean) {
        box.encode(value)
    }

    override fun encode(value: String) {
        box.encode(value)
    }

    override fun encode(value: Double) {
        box.encode(value)
    }

    override fun encode(value: Float) {
        box.encode(value)
    }

    override fun encode(value: Byte) {
        box.encode(value)
    }

    override fun encode(value: Short) {
        box.encode(value)
    }

    override fun encode(value: Int) {
        box.encode(value)
    }

    override fun encode(value: Long) {
        box.encode(value)
    }

    override fun encode(value: UByte) {
        box.encode(value)
    }

    override fun encode(value: UShort) {
        box.encode(value)
    }

    override fun encode(value: UInt) {
        box.encode(value)
    }

    override fun encode(value: ULong) {
        box.encode(value)
    }

    override fun <T : Any> encode(value: T) {
        if (value is Sequence<*>) {
            val container = nestedUnkeyedContainer()
            container.encode(contentsOf = value)
        } else {
            box.encode(value)
        }
    }

    override fun <NestedKey : CodingKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedEncodingContainer<NestedKey> {
        return box.nestedContainer(keyedBy)
    }

    override fun nestedUnkeyedContainer(): UnkeyedEncodingContainer {
        return box.nestedUnkeyedContainer()
    }

    override fun superEncoder(): Encoder {
        return box.superEncoder()
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified K, V> encode(value: Dictionary<K, V>) where K: Any, V: Any {
        if (K::class == Int::class || K::class == String::class) {
            encodeAsDictionary(value)
        } else {
            encodeAsArray(value)
        }
    }

    fun encodeAsDictionary(value: Dictionary<*, *>) {
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class)
        for ((dkey, dvalue) in value.storage) {
            codableDictionaryKeyedEncode(dvalue, dkey, container)
        }
    }

    fun <K, V> encodeAsArray(value: Dictionary<K, V>) where K: Any, V: Any {
        val container = nestedUnkeyedContainer()
        for ((dkey, dvalue) in value.storage) {
            codableUnkeyedEncode(dkey, container)
            codableUnkeyedEncode(dvalue, container)
        }
    }
}

interface SingleValueEncodingContainerProtocol {
    val codingPath: Array<CodingKey>
    fun encodeNil()
    fun encode(value: Boolean)
    fun encode(value: String)
    fun encode(value: Double)
    fun encode(value: Float)
    fun encode(value: Byte)
    fun encode(value: Short)
    fun encode(value: Int)
    fun encode(value: Long)
    fun encode(value: UByte)
    fun encode(value: UShort)
    fun encode(value: UInt)
    fun encode(value: ULong)
    fun <T> encode(value: T) where T: Any
    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(): UnkeyedEncodingContainer
}

class SingleValueEncodingContainer(container: SingleValueEncodingContainerProtocol) : SingleValueEncodingContainerProtocol {
    private val box: SingleValueEncodingContainerProtocol = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override fun encodeNil() {
        box.encodeNil()
    }

    override fun encode(value: Boolean) {
        box.encode(value)
    }

    override fun encode(value: String) {
        box.encode(value)
    }

    override fun encode(value: Double) {
        box.encode(value)
    }

    override fun encode(value: Float) {
        box.encode(value)
    }

    override fun encode(value: Byte) {
        box.encode(value)
    }

    override fun encode(value: Short) {
        box.encode(value)
    }

    override fun encode(value: Int) {
        box.encode(value)
    }

    override fun encode(value: Long) {
        box.encode(value)
    }

    override fun encode(value: UByte) {
        box.encode(value)
    }

    override fun encode(value: UShort) {
        box.encode(value)
    }

    override fun encode(value: UInt) {
        box.encode(value)
    }

    override fun encode(value: ULong) {
        box.encode(value)
    }

    override fun <T : Any> encode(value: T) {
        if (value is Sequence<*>) {
            val container = nestedUnkeyedContainer()
            container.encode(contentsOf = value)
        } else {
            box.encode(value)
        }
    }

    override fun <NestedKey : CodingKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedEncodingContainer<NestedKey> {
        return box.nestedContainer(keyedBy)
    }

    override fun nestedUnkeyedContainer(): UnkeyedEncodingContainer {
        return box.nestedUnkeyedContainer()
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified K, V> encode(value: Dictionary<K, V>) where K: Any, V: Any {
        if (K::class == Int::class || K::class == String::class) {
            encodeAsDictionary(value)
        } else {
            encodeAsArray(value)
        }
    }

    fun encodeAsDictionary(value: Dictionary<*, *>) {
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class)
        for ((dkey, dvalue) in value.storage) {
            codableDictionaryKeyedEncode(dvalue, dkey, container)
        }
    }

    fun <K, V> encodeAsArray(value: Dictionary<K, V>) where K: Any, V: Any {
        val container = nestedUnkeyedContainer()
        for ((dkey, dvalue) in value.storage) {
            codableUnkeyedEncode(dkey, container)
            codableUnkeyedEncode(dvalue, container)
        }
    }
}

fun <T> codableDictionaryKeyedEncode(value: T?, forKey: Any?, container: KeyedEncodingContainerProtocol<CodingKey>) where T: Any {
    val key = DictionaryCodingKey(forKey?.toString() ?: "")
    when (value) {
        is Boolean -> container.encode(value, key)
        is String -> container.encode(value, key)
        is Byte -> container.encode(value, key)
        is Short -> container.encode(value, key)
        is Int -> container.encode(value, key)
        is Long -> container.encode(value, key)
        is UByte -> container.encode(value, key)
        is UShort -> container.encode(value, key)
        is UInt -> container.encode(value, key)
        is ULong -> container.encode(value, key)
        is Float -> container.encode(value, key)
        is Double -> container.encode(value, key)
        is Sequence<*> -> {
            val valueContainer = container.nestedUnkeyedContainer(key)
            valueContainer.encode(contentsOf = value)
        }
        null -> container.encodeNil(key)
        else -> container.encode(value, key)
    }
}

fun <T> codableUnkeyedEncode(value: T?, container: UnkeyedEncodingContainer) where T: Any {
    when (value) {
        is String -> container.encode(value)
        is Boolean -> container.encode(value)
        is Byte -> container.encode(value)
        is Short -> container.encode(value)
        is Int -> container.encode(value)
        is Long -> container.encode(value)
        is UByte -> container.encode(value)
        is UShort -> container.encode(value)
        is UInt -> container.encode(value)
        is ULong -> container.encode(value)
        is Float -> container.encode(value)
        is Double -> container.encode(value)
        is Sequence<*> -> {
            val nestedContainer = container.nestedUnkeyedContainer()
            nestedContainer.encode(contentsOf = value)
        }
        null -> container.encodeNil()
        else -> container.encode(value)
    }
}

fun <T> codableSingleValueEncode(value: T?, container: SingleValueEncodingContainer) where T: Any {
    when (value) {
        is String -> container.encode(value)
        is Boolean -> container.encode(value)
        is Byte -> container.encode(value)
        is Short -> container.encode(value)
        is Int -> container.encode(value)
        is Long -> container.encode(value)
        is UByte -> container.encode(value)
        is UShort -> container.encode(value)
        is UInt -> container.encode(value)
        is ULong -> container.encode(value)
        is Float -> container.encode(value)
        is Double -> container.encode(value)
        is Sequence<*> -> {
            val nestedContainer = container.nestedUnkeyedContainer()
            nestedContainer.encode(contentsOf = value)
        }
        null -> container.encodeNil()
        else -> container.encode(value)
    }
}

interface Decodable {
}

interface DecodableCompanion<Owner> {
    fun init(from: Decoder): Owner
}

interface Decoder {
    val codingPath: Array<CodingKey>
    val userInfo: Dictionary<CodingUserInfoKey, Any>
    fun <Key> container(keyedBy: KClass<Key>): KeyedDecodingContainer<Key> where Key: CodingKey
    fun unkeyedContainer(): UnkeyedDecodingContainer
    fun singleValueContainer(): SingleValueDecodingContainer
}

/// Helper base type for Kotlin top level decoders.
abstract class TopLevelDecoder<Input> {
    abstract fun decoder(from: Input): Decoder

    inline fun <reified T> decode(type: KClass<T>, from: Input): T where T: Decodable {
        val decoder = decoder(from)
        val valueDecoder = codableSingleValueDecoder(type)
        val container = decoder.singleValueContainer()
        return valueDecoder(container)
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<E>, from: Input): Array<E> where E: Any {
        val decoder = decoder(from)
        return decodeSequence(decoder.unkeyedContainer(), type = E::class, factory = { Array(it, nocopy = true)  }) as Array<E>
    }

    inline fun <reified E> decode(type: KClass<Set<*>>, elementType: KClass<E>, from: Input): Set<E> where E: Any {
        val decoder = decoder(from)
        return decodeSequence(decoder.unkeyedContainer(), type = E::class, factory = { Set(it, nocopy = true)  }) as Set<E>
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>, from: Input): Array<Array<E>> where E: Any {
        val decoder = decoder(from)
        return decodeAsArrayOfArrays(decoder.unkeyedContainer(), elementType, nestedElementType)
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, from: Input): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(decoder(from).container(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(decoder(from).container(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArray(decoder(from).unkeyedContainer(), keyType, valueType)
        }
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, from: Input): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(decoder(from).container(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(decoder(from).container(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArrayOfArrays(decoder(from).unkeyedContainer(), keyType, nestedElementType)
        }
    }
}

interface KeyedDecodingContainerProtocol<Key: CodingKey> {
    val codingPath: Array<CodingKey>
    val allKeys: Array<CodingKey>
    fun contains(key: CodingKey): Boolean
    fun decodeNil(forKey: CodingKey): Boolean
    fun decode(type: KClass<Boolean>, forKey: CodingKey): Boolean
    fun decode(type: KClass<String>, forKey: CodingKey): String
    fun decode(type: KClass<Double>, forKey: CodingKey): Double
    fun decode(type: KClass<Float>, forKey: CodingKey): Float
    fun decode(type: KClass<Byte>, forKey: CodingKey): Byte
    fun decode(type: KClass<Short>, forKey: CodingKey): Short
    fun decode(type: KClass<Int>, forKey: CodingKey): Int
    fun decode(type: KClass<Long>, forKey: CodingKey): Long
    fun decode(type: KClass<UByte>, forKey: CodingKey): UByte
    fun decode(type: KClass<UShort>, forKey: CodingKey): UShort
    fun decode(type: KClass<UInt>, forKey: CodingKey): UInt
    fun decode(type: KClass<ULong>, forKey: CodingKey): ULong
    fun <T> decode(type: KClass<T>, forKey: CodingKey): T where T: Any

    fun decodeIfPresent(type: KClass<Boolean>, forKey: CodingKey): Boolean? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<String>, forKey: CodingKey): String? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Double>, forKey: CodingKey): Double? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Float>, forKey: CodingKey): Float? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Byte>, forKey: CodingKey): Byte? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Short>, forKey: CodingKey): Short? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Int>, forKey: CodingKey): Int? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Long>, forKey: CodingKey): Long? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UByte>, forKey: CodingKey): UByte? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UShort>, forKey: CodingKey): UShort? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UInt>, forKey: CodingKey): UInt? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<ULong>, forKey: CodingKey): ULong? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun <T> decodeIfPresent(type: KClass<T>, forKey: CodingKey): T? where T: Any {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: CodingKey): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(forKey: CodingKey): UnkeyedDecodingContainer
    fun superDecoder(): Decoder
    fun superDecoder(forKey: CodingKey): Decoder
}

class KeyedDecodingContainer<Key>(container: KeyedDecodingContainerProtocol<CodingKey>): KeyedDecodingContainerProtocol<CodingKey> where Key: CodingKey {
    private val box = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override val allKeys: Array<CodingKey>
        get() = box.allKeys

    override fun contains(key: CodingKey): Boolean {
        return box.contains(key)
    }

    override fun decodeNil(forKey: CodingKey): Boolean {
        return box.decodeNil(forKey)
    }

    override fun decode(type: KClass<Boolean>, forKey: CodingKey): Boolean {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<String>, forKey: CodingKey): String {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Double>, forKey: CodingKey): Double {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Float>, forKey: CodingKey): Float {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Byte>, forKey: CodingKey): Byte {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Short>, forKey: CodingKey): Short {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Int>, forKey: CodingKey): Int {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Long>, forKey: CodingKey): Long {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UByte>, forKey: CodingKey): UByte {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UShort>, forKey: CodingKey): UShort {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UInt>, forKey: CodingKey): UInt {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<ULong>, forKey: CodingKey): ULong {
        return box.decode(type, forKey)
    }

    override fun <T> decode(type: KClass<T>, forKey: CodingKey): T where T : Any {
        return box.decode(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Boolean>, forKey: CodingKey): Boolean? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<String>, forKey: CodingKey): String? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Double>, forKey: CodingKey): Double? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Float>, forKey: CodingKey): Float? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Byte>, forKey: CodingKey): Byte? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Short>, forKey: CodingKey): Short? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Int>, forKey: CodingKey): Int? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Long>, forKey: CodingKey): Long? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UByte>, forKey: CodingKey): UByte? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UShort>, forKey: CodingKey): UShort? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UInt>, forKey: CodingKey): UInt? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<ULong>, forKey: CodingKey): ULong? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun <T> decodeIfPresent(type: KClass<T>, forKey: CodingKey): T? where T: Any {
        return box.decodeIfPresent(type, forKey)
    }

    override fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: CodingKey): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return box.nestedContainer(keyedBy, forKey)
    }

    override fun nestedUnkeyedContainer(forKey: CodingKey): UnkeyedDecodingContainer {
        return box.nestedUnkeyedContainer(forKey)
    }

    override fun superDecoder(): Decoder {
        return box.superDecoder()
    }

    override fun superDecoder(forKey: CodingKey): Decoder {
        return box.superDecoder(forKey)
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<E>, forKey: CodingKey): Array<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(forKey), type = E::class, factory = { Array(it, nocopy = true)  }) as Array<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<E>, forKey: CodingKey): Array<E>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, forKey) else null
    }

    inline fun <reified E> decode(type: KClass<Set<*>>, elementType: KClass<E>, forKey: CodingKey): Set<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(forKey), type = E::class, factory = { Set(it, nocopy = true)  }) as Set<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Set<*>>, elementType: KClass<E>, forKey: CodingKey): Set<E>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, forKey) else null
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: CodingKey): Array<Array<E>> where E: Any {
        return decodeAsArrayOfArrays(nestedUnkeyedContainer(forKey), elementType, nestedElementType)
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: CodingKey): Array<Array<E>>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, nestedElementType, forKey) else null
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, forKey: CodingKey): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class, forKey), keyType, valueType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class, forKey), keyType, valueType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArray(nestedUnkeyedContainer(forKey), keyType, valueType)
        }
    }

    inline fun <reified K, reified V> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, forKey: CodingKey): Dictionary<K, V>? where K: Any, V: Any {
        return if (contains(forKey)) decode(type, keyType, valueType, forKey) else null
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: CodingKey): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class, forKey), keyType, nestedElementType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class, forKey), keyType, nestedElementType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArrayOfArrays(nestedUnkeyedContainer(forKey), keyType, nestedElementType)
        }
    }

    inline fun <reified K, reified E> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: CodingKey): Dictionary<K, Array<E>>? where K: Any, E: Any {
        return if (contains(forKey)) decode(type, keyType, valueType, nestedElementType, forKey) else null
    }
}

class DictionaryCodingKey(override val rawValue: String) : CodingKey {
}

interface UnkeyedDecodingContainerProtocol {
    val codingPath: Array<CodingKey>
    val count: Int?
    val isAtEnd: Boolean
    val currentIndex: Int
    fun decodeNil(): Boolean
    fun decode(type: KClass<Boolean>): Boolean
    fun decode(type: KClass<String>): String
    fun decode(type: KClass<Double>): Double
    fun decode(type: KClass<Float>): Float
    fun decode(type: KClass<Byte>): Byte
    fun decode(type: KClass<Short>): Short
    fun decode(type: KClass<Int>): Int
    fun decode(type: KClass<Long>): Long
    fun decode(type: KClass<UByte>): UByte
    fun decode(type: KClass<UShort>): UShort
    fun decode(type: KClass<UInt>): UInt
    fun decode(type: KClass<ULong>): ULong
    fun <T> decode(type: KClass<T>): T where T : Any

    fun decodeIfPresent(type: KClass<Boolean>): Boolean? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<String>): String? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Double>): Double? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Float>): Float? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Byte>): Byte? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Short>): Short? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Int>): Int? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<Long>): Long? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<UByte>): UByte? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<UShort>): UShort? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<UInt>): UInt? {
        return if (isAtEnd) null else decode(type)
    }

    fun decodeIfPresent(type: KClass<ULong>): ULong? {
        return if (isAtEnd) null else decode(type)
    }

    fun <T> decodeIfPresent(type: KClass<T>): T? where T: Any {
        return if (isAtEnd) null else decode(type)
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(): UnkeyedDecodingContainer
    fun superDecoder(): Decoder
}

class UnkeyedDecodingContainer(container: UnkeyedDecodingContainerProtocol): UnkeyedDecodingContainerProtocol {
    private val box = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override val count: Int?
        get() = box.count

    override val isAtEnd: Boolean
        get() = box.isAtEnd

    override val currentIndex: Int
        get() = box.currentIndex

    override fun decodeNil(): Boolean {
        return box.decodeNil()
    }

    override fun decode(type: KClass<Boolean>): Boolean {
        return box.decode(type)
    }

    override fun decode(type: KClass<String>): String {
        return box.decode(type)
    }

    override fun decode(type: KClass<Double>): Double {
        return box.decode(type)
    }

    override fun decode(type: KClass<Float>): Float {
        return box.decode(type)
    }

    override fun decode(type: KClass<Byte>): Byte {
        return box.decode(type)
    }

    override fun decode(type: KClass<Short>): Short {
        return box.decode(type)
    }

    override fun decode(type: KClass<Int>): Int {
        return box.decode(type)
    }

    override fun decode(type: KClass<Long>): Long {
        return box.decode(type)
    }

    override fun decode(type: KClass<UByte>): UByte {
        return box.decode(type)
    }

    override fun decode(type: KClass<UShort>): UShort {
        return box.decode(type)
    }

    override fun decode(type: KClass<UInt>): UInt {
        return box.decode(type)
    }

    override fun decode(type: KClass<ULong>): ULong {
        return box.decode(type)
    }

    override fun <T : Any> decode(type: KClass<T>): T {
        return box.decode(type)
    }

    override fun decodeIfPresent(type: KClass<Boolean>): Boolean? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<String>): String? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Double>): Double? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Float>): Float? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Byte>): Byte? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Short>): Short? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Int>): Int? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<Long>): Long? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<UByte>): UByte? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<UShort>): UShort? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<UInt>): UInt? {
        return box.decodeIfPresent(type)
    }

    override fun decodeIfPresent(type: KClass<ULong>): ULong? {
        return box.decodeIfPresent(type)
    }

    override fun <T> decodeIfPresent(type: KClass<T>): T? where T: Any {
        return box.decodeIfPresent(type)
    }

    override fun <NestedKey : CodingKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedDecodingContainer<NestedKey> {
        return box.nestedContainer(keyedBy)
    }

    override fun nestedUnkeyedContainer(): UnkeyedDecodingContainer {
        return box.nestedUnkeyedContainer()
    }

    override fun superDecoder(): Decoder {
        return box.superDecoder()
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<E>): Array<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(), type = E::class, factory = { Array(it, nocopy = true)  }) as Array<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<E>): Array<E>? where E: Any {
        return if (isAtEnd) null else decode(type, elementType)
    }

    inline fun <reified E> decode(type: KClass<Set<*>>, elementType: KClass<E>): Set<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(), type = E::class, factory = { Set(it, nocopy = true)  }) as Set<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Set<*>>, elementType: KClass<E>): Set<E>? where E: Any {
        return if (isAtEnd) null else decode(type, elementType)
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>): Array<Array<E>> where E: Any {
        return decodeAsArrayOfArrays(nestedUnkeyedContainer(), elementType, nestedElementType)
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>): Array<Array<E>>? where E: Any {
        return if (isAtEnd) null else decode(type, elementType, nestedElementType)
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArray(nestedUnkeyedContainer(), keyType, valueType)
        }
    }

    inline fun <reified K, reified V> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>): Dictionary<K, V>? where K: Any, V: Any {
        return if (isAtEnd) null else decode(type, keyType, valueType)
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArrayOfArrays(nestedUnkeyedContainer(), keyType, nestedElementType)
        }
    }

    inline fun <reified K, reified E> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>): Dictionary<K, Array<E>>? where K: Any, E: Any {
        return if (isAtEnd) null else decode(type, keyType, valueType, nestedElementType)
    }
}

interface SingleValueDecodingContainerProtocol {
    val codingPath: Array<CodingKey>
    fun decodeNil(): Boolean
    fun decode(type: KClass<Boolean>): Boolean
    fun decode(type: KClass<String>): String
    fun decode(type: KClass<Double>): Double
    fun decode(type: KClass<Float>): Float
    fun decode(type: KClass<Byte>): Byte
    fun decode(type: KClass<Short>): Short
    fun decode(type: KClass<Int>): Int
    fun decode(type: KClass<Long>): Long
    fun decode(type: KClass<UByte>): UByte
    fun decode(type: KClass<UShort>): UShort
    fun decode(type: KClass<UInt>): UInt
    fun decode(type: KClass<ULong>): ULong
    fun <T> decode(type: KClass<T>): T where T: Any

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(): UnkeyedDecodingContainer
}

class SingleValueDecodingContainer(container: SingleValueDecodingContainerProtocol): SingleValueDecodingContainerProtocol {
    private val box = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override fun decodeNil(): Boolean {
        return box.decodeNil()
    }

    override fun decode(type: KClass<Boolean>): Boolean {
        return box.decode(type)
    }

    override fun decode(type: KClass<String>): String {
        return box.decode(type)
    }

    override fun decode(type: KClass<Double>): Double {
        return box.decode(type)
    }

    override fun decode(type: KClass<Float>): Float {
        return box.decode(type)
    }

    override fun decode(type: KClass<Byte>): Byte {
        return box.decode(type)
    }

    override fun decode(type: KClass<Short>): Short {
        return box.decode(type)
    }

    override fun decode(type: KClass<Int>): Int {
        return box.decode(type)
    }

    override fun decode(type: KClass<Long>): Long {
        return box.decode(type)
    }

    override fun decode(type: KClass<UByte>): UByte {
        return box.decode(type)
    }

    override fun decode(type: KClass<UShort>): UShort {
        return box.decode(type)
    }

    override fun decode(type: KClass<UInt>): UInt {
        return box.decode(type)
    }

    override fun decode(type: KClass<ULong>): ULong {
        return box.decode(type)
    }

    override fun <T : Any> decode(type: KClass<T>): T {
        return box.decode(type)
    }

    override fun <NestedKey : CodingKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedDecodingContainer<NestedKey> {
        return box.nestedContainer(keyedBy)
    }

    override fun nestedUnkeyedContainer(): UnkeyedDecodingContainer {
        return box.nestedUnkeyedContainer()
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<E>): Array<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(), type = E::class, factory = { Array(it, nocopy = true)  }) as Array<E>
    }

    inline fun <reified E> decode(type: KClass<kotlin.collections.Set<*>>, elementType: KClass<E>): kotlin.collections.Set<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(), type = E::class, factory = { Set(it, nocopy = true)  }) as kotlin.collections.Set<E>
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>): Array<Array<E>> where E: Any {
        return decodeAsArrayOfArrays(nestedUnkeyedContainer(), elementType, nestedElementType)
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, valueType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArray(nestedUnkeyedContainer(), keyType, valueType)
        }
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(nestedContainer(keyedBy = DictionaryCodingKey::class), keyType, nestedElementType, key = { (it.intValue ?: 0) as K })
            else -> return decodeDictionaryAsArrayOfArrays(nestedUnkeyedContainer(), keyType, nestedElementType)
        }
    }
}

inline fun <reified E> decodeSequence(container: UnkeyedDecodingContainer, type: KClass<E>, factory: (MutableList<E>) -> Sequence<E>): Sequence<E> where E: Any {
    val decoder = codableUnkeyedDecoder(E::class)
    val list: MutableList<E> = mutableListOf()
    while (!container.isAtEnd) {
        val element = decoder(container)
        list.add(element)
    }
    return factory(list)
}

inline fun <reified T> codableDictionaryKeyedDecoder(forType: KClass<T>): (KeyedDecodingContainer<DictionaryCodingKey>, CodingKey) -> T where T: Any {
    val decoder: (KeyedDecodingContainer<DictionaryCodingKey>, CodingKey) -> T
    when (T::class) {
        Boolean::class -> decoder = { container, dkey -> container.decode(Boolean::class, dkey) as T }
        String::class -> decoder = { container, dkey -> container.decode(String::class, dkey) as T }
        Byte::class -> decoder = { container, dkey -> container.decode(Byte::class, dkey) as T }
        Short::class -> decoder = { container, dkey -> container.decode(Short::class, dkey) as T }
        Int::class -> decoder = { container, dkey -> container.decode(Int::class, dkey) as T }
        Long::class -> decoder = { container, dkey -> container.decode(Long::class, dkey) as T }
        Float::class -> decoder = { container, dkey -> container.decode(Float::class, dkey) as T }
        Double::class -> decoder = { container, dkey -> container.decode(Double::class, dkey) as T }
        UByte::class -> decoder = { container, dkey -> container.decode(UByte::class, dkey) as T }
        UShort::class -> decoder = { container, dkey -> container.decode(UShort::class, dkey) as T }
        UInt::class -> decoder = { container, dkey -> container.decode(UInt::class, dkey) as T }
        ULong::class -> decoder = { container, dkey -> container.decode(ULong::class, dkey) as T }
        else -> decoder = { container, dkey -> container.decode(T::class, dkey) as T }
    }
    return decoder
}

inline fun <reified T> codableUnkeyedDecoder(forType: KClass<T>): (UnkeyedDecodingContainer) -> T where T: Any {
    val decoder: (UnkeyedDecodingContainer) -> T
    when (T::class) {
        Boolean::class -> decoder = { it.decode(Boolean::class) as T }
        String::class -> decoder = { it.decode(String::class) as T }
        Byte::class -> decoder = { it.decode(Byte::class) as T }
        Short::class -> decoder = { it.decode(Short::class) as T }
        Int::class -> decoder = { it.decode(Int::class) as T }
        Long::class -> decoder = { it.decode(Long::class) as T }
        Float::class -> decoder = { it.decode(Float::class) as T }
        Double::class -> decoder = { it.decode(Double::class) as T }
        UByte::class -> decoder = { it.decode(UByte::class) as T }
        UShort::class -> decoder = { it.decode(UShort::class) as T }
        UInt::class -> decoder = { it.decode(UInt::class) as T }
        ULong::class -> decoder = { it.decode(ULong::class) as T }
        else -> decoder = { it.decode(T::class) as T }
    }
    return decoder
}

inline fun <reified T> codableSingleValueDecoder(forType: KClass<T>): (SingleValueDecodingContainer) -> T where T: Any {
    val decoder: (SingleValueDecodingContainer) -> T
    when (T::class) {
        Boolean::class -> decoder = { it.decode(Boolean::class) as T }
        String::class -> decoder = { it.decode(String::class) as T }
        Byte::class -> decoder = { it.decode(Byte::class) as T }
        Short::class -> decoder = { it.decode(Short::class) as T }
        Int::class -> decoder = { it.decode(Int::class) as T }
        Long::class -> decoder = { it.decode(Long::class) as T }
        Float::class -> decoder = { it.decode(Float::class) as T }
        Double::class -> decoder = { it.decode(Double::class) as T }
        UByte::class -> decoder = { it.decode(UByte::class) as T }
        UShort::class -> decoder = { it.decode(UShort::class) as T }
        UInt::class -> decoder = { it.decode(UInt::class) as T }
        ULong::class -> decoder = { it.decode(ULong::class) as T }
        else -> decoder = { it.decode(T::class) as T }
    }
    return decoder
}

inline fun <reified E> decodeAsArrayOfArrays(container: UnkeyedDecodingContainer, elementType: KClass<Array<*>>, nestedElementType: KClass<E>): Array<Array<E>> where E: Any {
    val list: MutableList<Array<E>> = mutableListOf()
    while (!container.isAtEnd) {
        val element = decodeSequence(container.nestedUnkeyedContainer(), E::class, factory = { Array(it, nocopy = true) })
        list.add(element as Array<E>)
    }
    return Array(list, nocopy = true)
}

inline fun <K, reified V> decodeAsDictionary(container: KeyedDecodingContainer<DictionaryCodingKey>, keyType: KClass<K>, valueType: KClass<V>, key: (CodingKey) -> K): Dictionary<K, V> where K: Any, V: Any {
    val decoder = codableDictionaryKeyedDecoder(V::class)
    val map = LinkedHashMap<K, V>()
    for (codingKey in container.allKeys) {
        map[key(codingKey)] = decoder(container, codingKey)
    }
    return Dictionary(map, nocopy = true)
}

inline fun <K, reified E> decodeAsDictionaryOfArrays(container: KeyedDecodingContainer<DictionaryCodingKey>, keyType: KClass<K>, nestedElementType: KClass<E>, key: (CodingKey) -> K): Dictionary<K, Array<E>> where K: Any, E: Any {
    val map = LinkedHashMap<K, Array<E>>()
    for (codingKey in container.allKeys) {
        val nestedContainer = container.nestedUnkeyedContainer(codingKey)
        map[key(codingKey)] = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
    }
    return Dictionary(map, nocopy = true)
}

inline fun <reified K, reified V> decodeDictionaryAsArray(container: UnkeyedDecodingContainer, keyType: KClass<K>, valueType: KClass<V>): Dictionary<K, V> where K: Any, V: Any {
    val keyDecoder = codableUnkeyedDecoder(K::class)
    val valueDecoder = codableUnkeyedDecoder(V::class)
    val map = LinkedHashMap<K, V>()
    while (!container.isAtEnd) {
        val key = keyDecoder(container)
        val value = valueDecoder(container)
        map[key] = value
    }
    return Dictionary(map, nocopy = true)
}

inline fun <reified K, reified E> decodeDictionaryAsArrayOfArrays(container: UnkeyedDecodingContainer, keyType: KClass<K>, nestedElementType: KClass<E>): Dictionary<K, Array<E>> where K: Any, E: Any {
    val keyDecoder = codableUnkeyedDecoder(K::class)
    val map = LinkedHashMap<K, Array<E>>()
    while (!container.isAtEnd) {
        val key = keyDecoder(container)
        val nestedContainer = container.nestedUnkeyedContainer()
        val value = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
        map[key] = value
    }
    return Dictionary(map, nocopy = true)
}