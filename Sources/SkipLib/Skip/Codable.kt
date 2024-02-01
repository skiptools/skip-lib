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
    fun encodeNil(forKey: Key)
    fun encode(value: Boolean, forKey: Key)
    fun encode(value: String, forKey: Key)
    fun encode(value: Double, forKey: Key)
    fun encode(value: Float, forKey: Key)
    fun encode(value: Byte, forKey: Key)
    fun encode(value: Short, forKey: Key)
    fun encode(value: Int, forKey: Key)
    fun encode(value: Long, forKey: Key)
    fun encode(value: UByte, forKey: Key)
    fun encode(value: UShort, forKey: Key)
    fun encode(value: UInt, forKey: Key)
    fun encode(value: ULong, forKey: Key)
    fun <T> encode(value: T, forKey: Key) where T: Any

    fun <T> encodeConditional(object_: T, forKey: Key) where T: Any {
        encode(object_, forKey)
    }

    fun encodeIfPresent(value: Boolean?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: String?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Double?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Float?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Byte?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Short?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Int?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: Long?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UByte?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UShort?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: UInt?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeIfPresent(value: ULong?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun <T> encodeIfPresent(value: T?, forKey: Key) where T: Any {
        if (value != null) encode(value, forKey)
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: Key): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(forKey: Key): UnkeyedEncodingContainer
    fun superEncoder(): Encoder
    fun superEncoder(forKey: Key): Encoder
}

class KeyedEncodingContainer<Key>(container: KeyedEncodingContainerProtocol<Key>) : KeyedEncodingContainerProtocol<Key> where Key: CodingKey {
    private val box: KeyedEncodingContainerProtocol<Key> = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override fun encodeNil(forKey: Key) {
        box.encodeNil(forKey)
    }

    override fun encode(value: Boolean, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: String, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Double, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Float, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Byte, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Short, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Int, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: Long, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: UByte, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: UShort, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: UInt, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun encode(value: ULong, forKey: Key) {
        box.encode(value, forKey)
    }

    override fun <T> encode(value: T, forKey: Key) where T: Any {
        if (value is Sequence<*>) {
            val container = nestedUnkeyedContainer(forKey)
            container.encode(contentsOf = value)
        } else {
            box.encode(value, forKey)
        }
    }

    override fun <T> encodeConditional(object_: T, forKey: Key) where T: Any {
        encode(object_, forKey) // Delegate to our method to handle Sequences
    }

    override fun encodeIfPresent(value: Boolean?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: String?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Double?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Float?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Byte?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Short?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Int?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: Long?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UByte?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UShort?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: UInt?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun encodeIfPresent(value: ULong?, forKey: Key) {
        box.encodeIfPresent(value, forKey)
    }

    override fun <T> encodeIfPresent(value: T?, forKey: Key) where T: Any {
        if (value != null) encode(value, forKey) // Delegate to our function to handle Sequences
    }

    override fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: Key): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return box.nestedContainer(keyedBy, forKey)
    }

    override fun nestedUnkeyedContainer(forKey: Key): UnkeyedEncodingContainer {
        return box.nestedUnkeyedContainer(forKey)
    }

    override fun superEncoder(): Encoder {
        return box.superEncoder()
    }

    override fun superEncoder(forKey: Key): Encoder {
        return box.superEncoder(forKey)
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified K, V> encode(value: Dictionary<K, V>, forKey: Key) where K: Any, V: Any {
        if (K::class == Int::class || K::class == String::class) {
            encodeAsDictionary(value, forKey)
        } else {
            encodeAsArray(value, forKey)
        }
    }

    inline fun <reified K, V> encodeIfPresent(value: Dictionary<K, V>?, forKey: Key) {
        if (value != null) encode(value, forKey)
    }

    fun encodeAsDictionary(value: Dictionary<*, *>, forKey: Key) {
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class, forKey)
        for ((dkey, dvalue) in value.storage) {
            codableDictionaryKeyedEncode(dvalue, dkey, container)
        }
    }

    fun <K, V> encodeAsArray(value: Dictionary<K, V>, forKey: Key) where K: Any, V: Any {
        val container = nestedUnkeyedContainer(forKey)
        for ((dkey, dvalue) in value.storage) {
            codableUnkeyedEncode(dkey, container)
            codableUnkeyedEncode(dvalue, container)
        }
    }
}

interface UnkeyedEncodingContainer {
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
            codableUnkeyedEncode(element, this)
        }
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(): UnkeyedEncodingContainer
    fun superEncoder(): Encoder
}

interface SingleValueEncodingContainer {
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
}

fun <T> codableDictionaryKeyedEncode(value: T?, forKey: Any?, container: KeyedEncodingContainerProtocol<DictionaryCodingKey>) where T: Any {
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
        val container = decoder.unkeyedContainer()
        val list: MutableList<Array<E>> = mutableListOf()
        while (!container.isAtEnd) {
            val element = decodeSequence(container.nestedUnkeyedContainer(), E::class, factory = { Array(it, nocopy = true) })
            list.add(element as Array<E>)
        }
        return Array(list, nocopy = true)
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, from: Input): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(keyType, valueType, from, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(keyType, valueType, from, key = { (it.intValue ?: 0) as K })
            else -> return decodeAsArray(keyType, valueType, from)
        }
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, from: Input): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(keyType, nestedElementType, from, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(keyType, nestedElementType, from, key = { (it.intValue ?: 0) as K })
            else -> return decodeAsArrayOfArrays(keyType, nestedElementType, from)
        }
    }

    inline fun <K, reified V> decodeAsDictionary(keyType: KClass<K>, valueType: KClass<V>, from: Input, key: (CodingKey) -> K): Dictionary<K, V> where K: Any, V: Any {
        val decoder = decoder(from)
        val valueDecoder = codableDictionaryKeyedDecoder(V::class)
        val container = decoder.container(keyedBy = DictionaryCodingKey::class)
        val map = LinkedHashMap<K, V>()
        for (codingKey in container.allKeys) {
            map[key(codingKey)] = valueDecoder(container, codingKey)
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <K, reified E> decodeAsDictionaryOfArrays(keyType: KClass<K>, nestedElementType: KClass<E>, from: Input, key: (CodingKey) -> K): Dictionary<K, Array<E>> where K: Any, E: Any {
        val decoder = decoder(from)
        val container = decoder.container(keyedBy = DictionaryCodingKey::class)
        val map = LinkedHashMap<K, Array<E>>()
        for (codingKey in container.allKeys) {
            val nestedContainer = container.nestedUnkeyedContainer(codingKey)
            map[key(codingKey)] = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <reified K, reified V> decodeAsArray(keyType: KClass<K>, valueType: KClass<V>, from: Input): Dictionary<K, V> where K: Any, V: Any {
        val decoder = decoder(from)
        val keyDecoder = codableUnkeyedDecoder(K::class)
        val valueDecoder = codableUnkeyedDecoder(V::class)
        val container = decoder.unkeyedContainer()
        val map = LinkedHashMap<K, V>()
        while (!container.isAtEnd) {
            val key = keyDecoder(container)
            val value = valueDecoder(container)
            map[key] = value
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <reified K, reified E> decodeAsArrayOfArrays(keyType: KClass<K>, nestedElementType: KClass<E>, from: Input): Dictionary<K, Array<E>> where K: Any, E: Any {
        val decoder = decoder(from)
        val keyDecoder = codableUnkeyedDecoder(K::class)
        val container = decoder.unkeyedContainer()
        val map = LinkedHashMap<K, Array<E>>()
        while (!container.isAtEnd) {
            val key = keyDecoder(container)
            val nestedContainer = container.nestedUnkeyedContainer()
            val value = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
            map[key] = value
        }
        return Dictionary(map, nocopy = true)
    }
}

interface KeyedDecodingContainerProtocol<Key: CodingKey> {
    val codingPath: Array<CodingKey>
    val allKeys: Array<Key>
    fun contains(key: Key): Boolean
    fun decodeNil(forKey: Key): Boolean
    fun decode(type: KClass<Boolean>, forKey: Key): Boolean
    fun decode(type: KClass<String>, forKey: Key): String
    fun decode(type: KClass<Double>, forKey: Key): Double
    fun decode(type: KClass<Float>, forKey: Key): Float
    fun decode(type: KClass<Byte>, forKey: Key): Byte
    fun decode(type: KClass<Short>, forKey: Key): Short
    fun decode(type: KClass<Int>, forKey: Key): Int
    fun decode(type: KClass<Long>, forKey: Key): Long
    fun decode(type: KClass<UByte>, forKey: Key): UByte
    fun decode(type: KClass<UShort>, forKey: Key): UShort
    fun decode(type: KClass<UInt>, forKey: Key): UInt
    fun decode(type: KClass<ULong>, forKey: Key): ULong
    fun <T> decode(type: KClass<T>, forKey: Key): T where T: Any

    fun decodeIfPresent(type: KClass<Boolean>, forKey: Key): Boolean? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<String>, forKey: Key): String? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Double>, forKey: Key): Double? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Float>, forKey: Key): Float? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Byte>, forKey: Key): Byte? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Short>, forKey: Key): Short? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Int>, forKey: Key): Int? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<Long>, forKey: Key): Long? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UByte>, forKey: Key): UByte? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UShort>, forKey: Key): UShort? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<UInt>, forKey: Key): UInt? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun decodeIfPresent(type: KClass<ULong>, forKey: Key): ULong? {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun <T> decodeIfPresent(type: KClass<T>, forKey: Key): T? where T: Any {
        return if (contains(forKey)) decode(type, forKey) else null
    }

    fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: Key): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey
    fun nestedUnkeyedContainer(forKey: Key): UnkeyedDecodingContainer
    fun superDecoder(): Decoder
    fun superDecoder(forKey: Key): Decoder
}

class KeyedDecodingContainer<Key>(container: KeyedDecodingContainerProtocol<Key>): KeyedDecodingContainerProtocol<Key> where Key: CodingKey {
    private val box = container

    override val codingPath: Array<CodingKey>
        get() = box.codingPath

    override val allKeys: Array<Key>
        get() = box.allKeys

    override fun contains(key: Key): Boolean {
        return box.contains(key)
    }

    override fun decodeNil(forKey: Key): Boolean {
        return box.decodeNil(forKey)
    }

    override fun decode(type: KClass<Boolean>, forKey: Key): Boolean {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<String>, forKey: Key): String {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Double>, forKey: Key): Double {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Float>, forKey: Key): Float {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Byte>, forKey: Key): Byte {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Short>, forKey: Key): Short {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Int>, forKey: Key): Int {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<Long>, forKey: Key): Long {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UByte>, forKey: Key): UByte {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UShort>, forKey: Key): UShort {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<UInt>, forKey: Key): UInt {
        return box.decode(type, forKey)
    }

    override fun decode(type: KClass<ULong>, forKey: Key): ULong {
        return box.decode(type, forKey)
    }

    override fun <T> decode(type: KClass<T>, forKey: Key): T where T : Any {
        return box.decode(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Boolean>, forKey: Key): Boolean? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<String>, forKey: Key): String? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Double>, forKey: Key): Double? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Float>, forKey: Key): Float? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Byte>, forKey: Key): Byte? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Short>, forKey: Key): Short? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Int>, forKey: Key): Int? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<Long>, forKey: Key): Long? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UByte>, forKey: Key): UByte? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UShort>, forKey: Key): UShort? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<UInt>, forKey: Key): UInt? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun decodeIfPresent(type: KClass<ULong>, forKey: Key): ULong? {
        return box.decodeIfPresent(type, forKey)
    }

    override fun <T> decodeIfPresent(type: KClass<T>, forKey: Key): T? where T: Any {
        return box.decodeIfPresent(type, forKey)
    }

    override fun <NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: Key): KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return box.nestedContainer(keyedBy, forKey)
    }

    override fun nestedUnkeyedContainer(forKey: Key): UnkeyedDecodingContainer {
        return box.nestedUnkeyedContainer(forKey)
    }

    override fun superDecoder(): Decoder {
        return box.superDecoder()
    }

    override fun superDecoder(forKey: Key): Decoder {
        return box.superDecoder(forKey)
    }

    // In Swift, Arrays and Dictionaries are Codable. In Kotlin, we cover them here to overcome generic type erasure

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<E>, forKey: Key): Array<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(forKey), type = E::class, factory = { Array(it, nocopy = true)  }) as Array<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<E>, forKey: Key): Array<E>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, forKey) else null
    }

    inline fun <reified E> decode(type: KClass<Set<*>>, elementType: KClass<E>, forKey: Key): Set<E> where E: Any {
        return decodeSequence(nestedUnkeyedContainer(forKey), type = E::class, factory = { Set(it, nocopy = true)  }) as Set<E>
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Set<*>>, elementType: KClass<E>, forKey: Key): Set<E>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, forKey) else null
    }

    inline fun <reified E> decode(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: Key): Array<Array<E>> where E: Any {
        val container = nestedUnkeyedContainer(forKey)
        val list: MutableList<Array<E>> = mutableListOf()
        while (!container.isAtEnd) {
            val element = decodeSequence(container.nestedUnkeyedContainer(), E::class, factory = { Array(it, nocopy = true) })
            list.add(element as Array<E>)
        }
        return Array(list, nocopy = true)
    }

    inline fun <reified E> decodeIfPresent(type: KClass<Array<*>>, elementType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: Key): Array<Array<E>>? where E: Any {
        return if (contains(forKey)) decode(type, elementType, nestedElementType, forKey) else null
    }

    inline fun <reified K, reified V> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, forKey: Key): Dictionary<K, V> where K: Any, V: Any {
        when (K::class) {
            String::class -> return decodeAsDictionary(keyType, valueType, forKey, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionary(keyType, valueType, forKey, key = { (it.intValue ?: 0) as K })
            else -> return decodeAsArray(keyType, valueType, forKey)
        }
    }

    inline fun <reified K, reified V> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<V>, forKey: Key): Dictionary<K, V>? where K: Any, V: Any {
        return if (contains(forKey)) decode(type, keyType, valueType, forKey) else null
    }

    inline fun <reified K, reified E> decode(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: Key): Dictionary<K, Array<E>> where K: Any, E: Any {
        when (K::class) {
            String::class -> return decodeAsDictionaryOfArrays(keyType, nestedElementType, forKey, key = { it.stringValue as K })
            Int::class -> return decodeAsDictionaryOfArrays(keyType, nestedElementType, forKey, key = { (it.intValue ?: 0) as K })
            else -> return decodeAsArrayOfArrays(keyType, nestedElementType, forKey)
        }
    }

    inline fun <reified K, reified E> decodeIfPresent(type: KClass<Dictionary<*, *>>, keyType: KClass<K>, valueType: KClass<Array<*>>, nestedElementType: KClass<E>, forKey: Key): Dictionary<K, Array<E>>? where K: Any, E: Any {
        return if (contains(forKey)) decode(type, keyType, valueType, nestedElementType, forKey) else null
    }

    inline fun <K, reified V> decodeAsDictionary(keyType: KClass<K>, valueType: KClass<V>, forKey: Key, key: (CodingKey) -> K): Dictionary<K, V> where K: Any, V: Any {
        val decoder = codableDictionaryKeyedDecoder(V::class)
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class, forKey)
        val map = LinkedHashMap<K, V>()
        for (codingKey in container.allKeys) {
            map[key(codingKey)] = decoder(container, codingKey)
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <K, reified E> decodeAsDictionaryOfArrays(keyType: KClass<K>, nestedElementType: KClass<E>, forKey: Key, key: (CodingKey) -> K): Dictionary<K, Array<E>> where K: Any, E: Any {
        val container = nestedContainer(keyedBy = DictionaryCodingKey::class, forKey)
        val map = LinkedHashMap<K, Array<E>>()
        for (codingKey in container.allKeys) {
            val nestedContainer = container.nestedUnkeyedContainer(codingKey)
            map[key(codingKey)] = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <reified K, reified V> decodeAsArray(keyType: KClass<K>, valueType: KClass<V>, forKey: Key): Dictionary<K, V> where K: Any, V: Any {
        val keyDecoder = codableUnkeyedDecoder(K::class)
        val valueDecoder = codableUnkeyedDecoder(V::class)
        val container = nestedUnkeyedContainer(forKey)
        val map = LinkedHashMap<K, V>()
        while (!container.isAtEnd) {
            val key = keyDecoder(container)
            val value = valueDecoder(container)
            map[key] = value
        }
        return Dictionary(map, nocopy = true)
    }

    inline fun <reified K, reified E> decodeAsArrayOfArrays(keyType: KClass<K>, nestedElementType: KClass<E>, forKey: Key): Dictionary<K, Array<E>> where K: Any, E: Any {
        val keyDecoder = codableUnkeyedDecoder(K::class)
        val container = nestedUnkeyedContainer(forKey)
        val map = LinkedHashMap<K, Array<E>>()
        while (!container.isAtEnd) {
            val key = keyDecoder(container)
            val nestedContainer = container.nestedUnkeyedContainer()
            val value = decodeSequence(nestedContainer, E::class, factory = { Array(it, nocopy = true) }) as Array<E>
            map[key] = value
        }
        return Dictionary(map, nocopy = true)
    }
}

class DictionaryCodingKey(override val rawValue: String) : CodingKey {
}

interface UnkeyedDecodingContainer {
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

interface SingleValueDecodingContainer {
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

inline fun <reified T> codableDictionaryKeyedDecoder(forType: KClass<T>): (KeyedDecodingContainer<DictionaryCodingKey>, DictionaryCodingKey) -> T where T: Any {
    val decoder: (KeyedDecodingContainer<DictionaryCodingKey>, DictionaryCodingKey) -> T
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
