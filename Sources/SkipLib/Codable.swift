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
    var codingPath: [CodingKey] { get }
    mutating func encodeNil(forKey key: CodingKey) throws
    mutating func encode(_ value: Any, forKey key: CodingKey) throws
    mutating func encodeConditional(_ object: Any, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Any?, forKey key: CodingKey) throws
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: CodingKey) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer(forKey key: CodingKey) -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder
    mutating func superEncoder(forKey key: CodingKey) -> Encoder
}

public struct KeyedEncodingContainer<Key: CodingKey> : KeyedEncodingContainerProtocol {
}

public protocol UnkeyedEncodingContainer {
    var codingPath: [CodingKey] { get }
    var count: Int { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Any) throws
    mutating func encodeConditional(_ object: Any) throws
    mutating func encode(contentsOf sequence: Any) throws
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder
}

public protocol SingleValueEncodingContainer {
    var codingPath: [CodingKey] { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Any) throws
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
    var codingPath: [CodingKey] { get }
    var allKeys: [CodingKey] { get }
    func contains(_ key: CodingKey) -> Bool
    func decodeNil(forKey key: CodingKey) throws -> Bool
    func decode<T>(_ type: T.Type, forKey key: CodingKey) throws -> T
    func decodeIfPresent<T>(_ type: T.Type, forKey key: CodingKey) throws -> T?
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: CodingKey) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    func nestedUnkeyedContainer(forKey key: CodingKey) throws -> UnkeyedDecodingContainer
    func superDecoder() throws -> Decoder
    func superDecoder(forKey key: CodingKey) throws -> Decoder
}

public struct KeyedDecodingContainer<Key: CodingKey> : KeyedDecodingContainerProtocol {
}

public protocol UnkeyedDecodingContainer {
    var codingPath: [CodingKey] { get }
    var count: Int? { get }
    var isAtEnd: Bool { get }
    var currentIndex: Int { get }
    mutating func decodeNil() throws -> Bool
    mutating func decode<T>(_ type: T.Type) throws -> T
    mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T?
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer
    mutating func superDecoder() throws -> Decoder
}

public protocol SingleValueDecodingContainer {
    var codingPath: [CodingKey] { get }
    func decodeNil() -> Bool
    func decode<T>(_ type: T.Type) throws -> T
}

#endif
