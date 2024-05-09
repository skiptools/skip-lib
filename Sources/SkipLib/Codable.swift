// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

public protocol Codable : Decodable, Encodable {
}

public protocol Encodable {
    func encode(to encoder: Encoder) throws
}

public protocol Encoder {
    var codingPath: [CodingKey] { get }
    var userInfo: [CodingUserInfoKey : Any] { get }
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey
    func unkeyedContainer() -> UnkeyedEncodingContainer
    func singleValueContainer() -> SingleValueEncodingContainer
}

public protocol KeyedEncodingContainerProtocol {
    associatedtype Key: CodingKey
    var codingPath: [CodingKey] { get }
    mutating func encodeNil(forKey key: Key) throws
    mutating func encode(_ value: Bool, forKey key: Key) throws
    mutating func encode(_ value: String, forKey key: Key) throws
    mutating func encode(_ value: Double, forKey key: Key) throws
    mutating func encode(_ value: Float, forKey key: Key) throws
    mutating func encode(_ value: Int, forKey key: Key) throws
    mutating func encode(_ value: Int8, forKey key: Key) throws
    mutating func encode(_ value: Int16, forKey key: Key) throws
    mutating func encode(_ value: Int32, forKey key: Key) throws
    mutating func encode(_ value: Int64, forKey key: Key) throws
    mutating func encode(_ value: UInt, forKey key: Key) throws
    mutating func encode(_ value: UInt8, forKey key: Key) throws
    mutating func encode(_ value: UInt16, forKey key: Key) throws
    mutating func encode(_ value: UInt32, forKey key: Key) throws
    mutating func encode(_ value: UInt64, forKey key: Key) throws
    mutating func encode<T>(_ value: T?, forKey key: Key) throws where T: Any
    mutating func encodeConditional<T>(_ object: T, forKey key: Key) throws where T: Any
    mutating func encodeIfPresent(_ value: Bool?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Double?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Float?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Int8?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Int16?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Int32?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: Int64?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: UInt?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws
    mutating func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws
    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T: Any
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder
    mutating func superEncoder(forKey key: Key) -> Encoder
}

public struct KeyedEncodingContainer<Key: CodingKey> : KeyedEncodingContainerProtocol {
}

public protocol UnkeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    var count: Int { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Bool) throws
    mutating func encode(_ value: String) throws
    mutating func encode(_ value: Double) throws
    mutating func encode(_ value: Float) throws
    mutating func encode(_ value: Int) throws
    mutating func encode(_ value: Int8) throws
    mutating func encode(_ value: Int16) throws
    mutating func encode(_ value: Int32) throws
    mutating func encode(_ value: Int64) throws
    mutating func encode(_ value: UInt) throws
    mutating func encode(_ value: UInt8) throws
    mutating func encode(_ value: UInt16) throws
    mutating func encode(_ value: UInt32) throws
    mutating func encode(_ value: UInt64) throws
    mutating func encode<T>(_ value: T) throws where T: Any
    mutating func encodeConditional<T>(_ object: T) throws where T: Any
    mutating func encode(contentsOf sequence: Any) throws
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder
}

public struct UnkeyedEncodingContainer : UnkeyedEncodingContainerProtocol {
}

public protocol SingleValueEncodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Bool) throws
    mutating func encode(_ value: String) throws
    mutating func encode(_ value: Double) throws
    mutating func encode(_ value: Float) throws
    mutating func encode(_ value: Int) throws
    mutating func encode(_ value: Int8) throws
    mutating func encode(_ value: Int16) throws
    mutating func encode(_ value: Int32) throws
    mutating func encode(_ value: Int64) throws
    mutating func encode(_ value: UInt) throws
    mutating func encode(_ value: UInt8) throws
    mutating func encode(_ value: UInt16) throws
    mutating func encode(_ value: UInt32) throws
    mutating func encode(_ value: UInt64) throws
    mutating func encode<T>(_ value: T) throws where T: Any
    mutating func encodeConditional<T>(_ object: T) throws where T: Any
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
}

public struct SingleValueEncodingContainer : SingleValueEncodingContainerProtocol {
}

public protocol Decodable {
}

public protocol Decoder {
    var codingPath: [CodingKey] { get }
    var userInfo: [CodingUserInfoKey : Any] { get }
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey
    func unkeyedContainer() throws -> UnkeyedDecodingContainer
    func singleValueContainer() throws -> SingleValueDecodingContainer
}

public protocol KeyedDecodingContainerProtocol {
    associatedtype Key: CodingKey
    var codingPath: [CodingKey] { get }
    var allKeys: [Key] { get }
    func contains(_ key: Key) -> Bool
    func decodeNil(forKey key: Key) throws -> Bool
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool
    func decode(_ type: String.Type, forKey key: Key) throws -> String
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T
    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool?
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String?
    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float?
    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double?
    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int?
    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8?
    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16?
    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32?
    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64?
    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt?
    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8?
    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16?
    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32?
    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64?
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T?
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer
    func superDecoder() throws -> Decoder
    func superDecoder(forKey key: Key) throws -> Decoder
}

public struct KeyedDecodingContainer<Key: CodingKey> : KeyedDecodingContainerProtocol {
}

public protocol UnkeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    var count: Int? { get }
    var isAtEnd: Bool { get }
    var currentIndex: Int { get }
    mutating func decodeNil() throws -> Bool
    mutating func decode(_ type: Bool.Type) throws -> Bool
    mutating func decode(_ type: String.Type) throws -> String
    mutating func decode(_ type: Float.Type) throws -> Float
    mutating func decode(_ type: Double.Type) throws -> Double
    mutating func decode(_ type: Int.Type) throws -> Int
    mutating func decode(_ type: Int8.Type) throws -> Int8
    mutating func decode(_ type: Int16.Type) throws -> Int16
    mutating func decode(_ type: Int32.Type) throws -> Int32
    mutating func decode(_ type: Int64.Type) throws -> Int64
    mutating func decode(_ type: UInt.Type) throws -> UInt
    mutating func decode(_ type: UInt8.Type) throws -> UInt8
    mutating func decode(_ type: UInt16.Type) throws -> UInt16
    mutating func decode(_ type: UInt32.Type) throws -> UInt32
    mutating func decode(_ type: UInt64.Type) throws -> UInt64
    mutating func decode<T>(_ type: T.Type) throws -> T
    mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T?
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer
    mutating func superDecoder() throws -> Decoder
}

public struct UnkeyedDecodingContainer : UnkeyedDecodingContainerProtocol {
}

public protocol SingleValueDecodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    func decodeNil() -> Bool
    func decode(_ type: Bool.Type) throws -> Bool
    func decode(_ type: String.Type) throws -> String
    func decode(_ type: Float.Type) throws -> Float
    func decode(_ type: Double.Type) throws -> Double
    func decode(_ type: Int.Type) throws -> Int
    func decode(_ type: Int8.Type) throws -> Int8
    func decode(_ type: Int16.Type) throws -> Int16
    func decode(_ type: Int32.Type) throws -> Int32
    func decode(_ type: Int64.Type) throws -> Int64
    func decode(_ type: UInt.Type) throws -> UInt
    func decode(_ type: UInt8.Type) throws -> UInt8
    func decode(_ type: UInt16.Type) throws -> UInt16
    func decode(_ type: UInt32.Type) throws -> UInt32
    func decode(_ type: UInt64.Type) throws -> UInt64
    func decode<T>(_ type: T.Type) throws -> T
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer
}

public struct SingleValueDecodingContainer : SingleValueDecodingContainerProtocol {
}

#endif
