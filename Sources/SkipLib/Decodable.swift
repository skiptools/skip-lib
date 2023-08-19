// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
public protocol Decodable {

    #if SKIP // Kotlin does not support constructors in protocols
    // SKIP DECLARE: fun init(from: Decoder): Decodable?
    // static func `init`(from decoder: Decoder) throws -> Decodable
    #else
    init(from decoder: Decoder) throws
    #endif
}

public protocol DecodableCompanion {
    associatedtype Owner
    // TODO: automatic de-quote the reserved `init` function name
    // SKIP REPLACE: fun init(from: Decoder): Owner
    func `init`(from decoder: Decoder) throws -> Owner
}

/// A type that can decode values from a native format into in-memory
/// representations.
public protocol Decoder {
    var codingPath: [CodingKey] { get }
    var userInfo: [CodingUserInfoKey : Any] { get }
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey
    func unkeyedContainer() throws -> UnkeyedDecodingContainer
    func singleValueContainer() throws -> SingleValueDecodingContainer
}


/// A type that provides a view into a decoder's storage and is used to hold
/// the encoded properties of a decodable type in a keyed manner.
///
/// Decoders should provide types conforming to `UnkeyedDecodingContainer` for
/// their format.
///
/// Note that this type differs from `Swift.KeyedDecodingContainerProtocol`
/// in that is does not declare `associatedtype Key : CodingKey`,
/// as it is not currently supported in Skip.
public protocol KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    var allKeys: [CodingKey] { get }
    func contains(_ key: CodingKey) -> Bool
    func decodeNil(forKey key: CodingKey) throws -> Bool
    func decode(_ type: Bool.Type, forKey key: CodingKey) throws -> Bool
    func decode(_ type: String.Type, forKey key: CodingKey) throws -> String
    func decode(_ type: Double.Type, forKey key: CodingKey) throws -> Double
    func decode(_ type: Float.Type, forKey key: CodingKey) throws -> Float
    func decode(_ type: Int8.Type, forKey key: CodingKey) throws -> Int8
    func decode(_ type: Int16.Type, forKey key: CodingKey) throws -> Int16
    func decode(_ type: Int32.Type, forKey key: CodingKey) throws -> Int32
    func decode(_ type: Int64.Type, forKey key: CodingKey) throws -> Int64
    #if !SKIP
    func decode(_ type: Int.Type, forKey key: CodingKey) throws -> Int
    func decode(_ type: UInt.Type, forKey key: CodingKey) throws -> UInt
    #endif
    func decode(_ type: UInt8.Type, forKey key: CodingKey) throws -> UInt8
    func decode(_ type: UInt16.Type, forKey key: CodingKey) throws -> UInt16
    func decode(_ type: UInt32.Type, forKey key: CodingKey) throws -> UInt32
    func decode(_ type: UInt64.Type, forKey key: CodingKey) throws -> UInt64
    func decode<T>(_ type: T.Type, forKey key: CodingKey) throws -> T where T : Decodable
    func decodeIfPresent(_ type: Bool.Type, forKey key: CodingKey) throws -> Bool?
    func decodeIfPresent(_ type: String.Type, forKey key: CodingKey) throws -> String?
    func decodeIfPresent(_ type: Double.Type, forKey key: CodingKey) throws -> Double?
    func decodeIfPresent(_ type: Float.Type, forKey key: CodingKey) throws -> Float?
    func decodeIfPresent(_ type: Int8.Type, forKey key: CodingKey) throws -> Int8?
    func decodeIfPresent(_ type: Int16.Type, forKey key: CodingKey) throws -> Int16?
    func decodeIfPresent(_ type: Int32.Type, forKey key: CodingKey) throws -> Int32?
    func decodeIfPresent(_ type: Int64.Type, forKey key: CodingKey) throws -> Int64?
    #if !SKIP
    func decodeIfPresent(_ type: Int.Type, forKey key: CodingKey) throws -> Int?
    func decodeIfPresent(_ type: UInt.Type, forKey key: CodingKey) throws -> UInt?
    #endif
    func decodeIfPresent(_ type: UInt8.Type, forKey key: CodingKey) throws -> UInt8?
    func decodeIfPresent(_ type: UInt16.Type, forKey key: CodingKey) throws -> UInt16?
    func decodeIfPresent(_ type: UInt32.Type, forKey key: CodingKey) throws -> UInt32?
    func decodeIfPresent(_ type: UInt64.Type, forKey key: CodingKey) throws -> UInt64?
    func decodeIfPresent<T>(_ type: T.Type, forKey key: CodingKey) throws -> T? where T : Decodable
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: CodingKey) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    func nestedUnkeyedContainer(forKey key: CodingKey) throws -> UnkeyedDecodingContainer
    func superDecoder() throws -> Decoder
    func superDecoder(forKey key: CodingKey) throws -> Decoder
}

extension KeyedDecodingContainerProtocol {
    public func decodeIfPresent(_ type: Bool.Type, forKey key: CodingKey) throws -> Bool? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: String.Type, forKey key: CodingKey) throws -> String? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: Double.Type, forKey key: CodingKey) throws -> Double? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: Float.Type, forKey key: CodingKey) throws -> Float? {
        fatalError("SKIP DECODING TODO")
    }

    //public func decodeIfPresent(_ type: Int.Type, forKey key: CodingKey) throws -> Int? {
    //    fatalError("SKIP DECODING TODO")
    //}

    public func decodeIfPresent(_ type: Int8.Type, forKey key: CodingKey) throws -> Int8? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: Int16.Type, forKey key: CodingKey) throws -> Int16? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: Int32.Type, forKey key: CodingKey) throws -> Int32? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: Int64.Type, forKey key: CodingKey) throws -> Int64? {
        fatalError("SKIP DECODING TODO")
    }

    //public func decodeIfPresent(_ type: UInt.Type, forKey key: CodingKey) throws -> UInt? {
    //    fatalError("SKIP DECODING TODO")
    //}

    public func decodeIfPresent(_ type: UInt8.Type, forKey key: CodingKey) throws -> UInt8? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: UInt16.Type, forKey key: CodingKey) throws -> UInt16? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: UInt32.Type, forKey key: CodingKey) throws -> UInt32? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent(_ type: UInt64.Type, forKey key: CodingKey) throws -> UInt64? {
        fatalError("SKIP DECODING TODO")
    }

    public func decodeIfPresent<T>(_ type: T.Type, forKey key: CodingKey) throws -> T? where T : Decodable {
        fatalError("SKIP DECODING TODO")
    }
}

/// A concrete container that provides a view into a decoder's storage, making
/// the encoded properties of a decodable type accessible by keys.
public struct KeyedDecodingContainer<Key: CodingKey> : KeyedDecodingContainerProtocol {

    internal var _box: _KeyedDecodingContainerBase

    public init(_ container: any KeyedDecodingContainerProtocol) {
        self._box = _KeyedDecodingContainerBox(container)
    }

    /// The path of coding keys taken to get to this point in decoding.
    public var codingPath: [CodingKey] {
        return _box.codingPath
    }

    public var allKeys: [CodingKey] {
        return _box.allKeys
    }

    public func contains(_ key: CodingKey) -> Bool {
        return _box.contains(key)
    }

    public func decodeNil(forKey key: CodingKey) throws -> Bool {
        return try _box.decodeNil(forKey: key)
    }

    public func decode(_ type: Bool.Type, forKey key: CodingKey) throws -> Bool {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: String.Type, forKey key: CodingKey) throws -> String {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: Double.Type, forKey key: CodingKey) throws -> Double {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: Float.Type, forKey key: CodingKey) throws -> Float {
        return try _box.decode(type, forKey: key)
    }

    #if !SKIP
    public func decode(_ type: Int.Type, forKey key: CodingKey) throws -> Int {
        return try _box.decode(type, forKey: key)
    }
    #endif

    public func decode(_ type: Int8.Type, forKey key: CodingKey) throws -> Int8 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: Int16.Type, forKey key: CodingKey) throws -> Int16 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: Int32.Type, forKey key: CodingKey) throws -> Int32 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: Int64.Type, forKey key: CodingKey) throws -> Int64 {
        return try _box.decode(type, forKey: key)
    }

    #if !SKIP
    public func decode(_ type: UInt.Type, forKey key: CodingKey) throws -> UInt {
        return try _box.decode(type, forKey: key)
    }
    #endif

    public func decode(_ type: UInt8.Type, forKey key: CodingKey) throws -> UInt8 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: UInt16.Type, forKey key: CodingKey) throws -> UInt16 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: UInt32.Type, forKey key: CodingKey) throws -> UInt32 {
        return try _box.decode(type, forKey: key)
    }

    public func decode(_ type: UInt64.Type, forKey key: CodingKey) throws -> UInt64 {
        return try _box.decode(type, forKey: key)
    }

    public func decode<T>(_ type: T.Type, forKey key: CodingKey) throws -> T where T : Decodable {
        return try _box.decode(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Bool.Type, forKey key: CodingKey) throws -> Bool? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: String.Type, forKey key: CodingKey) throws -> String? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Double.Type, forKey key: CodingKey) throws -> Double? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Float.Type, forKey key: CodingKey) throws -> Float? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    //public func decodeIfPresent(_ type: Int.Type, forKey key: CodingKey) throws -> Int? {
    //    return try _box.decodeIfPresent(type, forKey: key)
    //}

    public func decodeIfPresent(_ type: Int8.Type, forKey key: CodingKey) throws -> Int8? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Int16.Type, forKey key: CodingKey) throws -> Int16? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Int32.Type, forKey key: CodingKey) throws -> Int32? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: Int64.Type, forKey key: CodingKey) throws -> Int64? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    #if !SKIP
    public func decodeIfPresent(_ type: Int.Type, forKey key: CodingKey) throws -> Int? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: UInt.Type, forKey key: CodingKey) throws -> UInt? {
        return try _box.decodeIfPresent(type, forKey: key)
    }
    #endif

    public func decodeIfPresent(_ type: UInt8.Type, forKey key: CodingKey) throws -> UInt8? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: UInt16.Type, forKey key: CodingKey) throws -> UInt16? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: UInt32.Type, forKey key: CodingKey) throws -> UInt32? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent(_ type: UInt64.Type, forKey key: CodingKey) throws -> UInt64? {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func decodeIfPresent<T>(_ type: T.Type, forKey key: CodingKey) throws -> T? where T : Decodable {
        return try _box.decodeIfPresent(type, forKey: key)
    }

    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: CodingKey) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return try _box.nestedContainer(keyedBy: type, forKey: key)
    }

    public func nestedUnkeyedContainer(forKey key: CodingKey) throws -> UnkeyedDecodingContainer {
        return try _box.nestedUnkeyedContainer(forKey: key)
    }

    public func superDecoder() throws -> Decoder {
        return try _box.superDecoder()
    }

    public func superDecoder(forKey key: CodingKey) throws -> Decoder {
        return try _box.superDecoder(forKey: key)
    }
}


/// A type that provides a view into a decoder's storage and is used to hold
/// the encoded properties of a decodable type sequentially, without keys.
///
/// Decoders should provide types conforming to `UnkeyedDecodingContainer` for
/// their format.
public protocol UnkeyedDecodingContainer {

    /// The path of coding keys taken to get to this point in decoding.
    var codingPath: [CodingKey] { get }

    /// The number of elements contained within this container.
    ///
    /// If the number of elements is unknown, the value is `nil`.
    var count: Int? { get }

    /// A Boolean value indicating whether there are no more elements left to be
    /// decoded in the container.
    var isAtEnd: Bool { get }

    /// The current decoding index of the container (i.e. the index of the next
    /// element to be decoded.) Incremented after every successful decode call.
    var currentIndex: Int { get }

    /// Decodes a null value.
    mutating func decodeNil() throws -> Bool

    mutating func decode(_ type: Bool.Type) throws -> Bool
    mutating func decode(_ type: String.Type) throws -> String
    mutating func decode(_ type: Double.Type) throws -> Double
    mutating func decode(_ type: Float.Type) throws -> Float
    mutating func decode(_ type: Int8.Type) throws -> Int8
    mutating func decode(_ type: Int16.Type) throws -> Int16
    mutating func decode(_ type: Int32.Type) throws -> Int32
    mutating func decode(_ type: Int64.Type) throws -> Int64
    #if !SKIP
    mutating func decode(_ type: Int.Type) throws -> Int
    mutating func decode(_ type: UInt.Type) throws -> UInt
    #endif
    mutating func decode(_ type: UInt8.Type) throws -> UInt8
    mutating func decode(_ type: UInt16.Type) throws -> UInt16
    mutating func decode(_ type: UInt32.Type) throws -> UInt32
    mutating func decode(_ type: UInt64.Type) throws -> UInt64
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable
    mutating func decodeIfPresent(_ type: Bool.Type) throws -> Bool?
    mutating func decodeIfPresent(_ type: String.Type) throws -> String?
    mutating func decodeIfPresent(_ type: Double.Type) throws -> Double?
    mutating func decodeIfPresent(_ type: Float.Type) throws -> Float?
    mutating func decodeIfPresent(_ type: Int8.Type) throws -> Int8?
    mutating func decodeIfPresent(_ type: Int16.Type) throws -> Int16?
    mutating func decodeIfPresent(_ type: Int32.Type) throws -> Int32?
    mutating func decodeIfPresent(_ type: Int64.Type) throws -> Int64?
    #if !SKIP
    mutating func decodeIfPresent(_ type: Int.Type) throws -> Int?
    mutating func decodeIfPresent(_ type: UInt.Type) throws -> UInt?
    #endif
    mutating func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8?
    mutating func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16?
    mutating func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32?
    mutating func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64?
    mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T : Decodable
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer
    mutating func superDecoder() throws -> Decoder
}


extension UnkeyedDecodingContainer {
    public mutating func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        fatalError("SKIP TODO: decodeIfPresent Bool")
    }

    public mutating func decodeIfPresent(_ type: String.Type) throws -> String? {
        fatalError("SKIP TODO: decodeIfPresent String")
    }

    public mutating func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        fatalError("SKIP TODO: decodeIfPresent Double")
    }

    public mutating func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        fatalError("SKIP TODO: decodeIfPresent Float")
    }

    public mutating func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        fatalError("SKIP TODO: decodeIfPresent Int8")
    }

    public mutating func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        fatalError("SKIP TODO: decodeIfPresent Int16")
    }

    public mutating func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        fatalError("SKIP TODO: decodeIfPresent Int32")
    }

    public mutating func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        fatalError("SKIP TODO: decodeIfPresent Int64")
    }

    #if !SKIP
    public mutating func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        fatalError("SKIP TODO: decodeIfPresent Int")
    }

    public mutating func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        fatalError("SKIP TODO: decodeIfPresent UInt")
    }
    #endif

    public mutating func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        fatalError("SKIP TODO: decodeIfPresent")
    }

    public mutating func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        fatalError("SKIP TODO: decodeIfPresent")
    }

    public mutating func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        fatalError("SKIP TODO: decodeIfPresent")
    }

    public mutating func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        fatalError("SKIP TODO: decodeIfPresent")
    }

    public mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T : Decodable {
        fatalError("SKIP TODO: decodeIfPresent")
    }
}


/// A container that can support the storage and direct decoding of a single
/// nonkeyed value.
public protocol SingleValueDecodingContainer {

    /// The path of coding keys taken to get to this point in encoding.
    var codingPath: [CodingKey] { get }

    func decodeNil() -> Bool
    func decode(_ type: Bool.Type) throws -> Bool
    func decode(_ type: String.Type) throws -> String
    func decode(_ type: Double.Type) throws -> Double
    func decode(_ type: Float.Type) throws -> Float

    func decode(_ type: Int8.Type) throws -> Int8
    func decode(_ type: Int16.Type) throws -> Int16
    func decode(_ type: Int32.Type) throws -> Int32
    func decode(_ type: Int64.Type) throws -> Int64
    #if !SKIP
    func decode(_ type: Int.Type) throws -> Int
    func decode(_ type: UInt.Type) throws -> UInt
    #endif
    func decode(_ type: UInt8.Type) throws -> UInt8
    func decode(_ type: UInt16.Type) throws -> UInt16
    func decode(_ type: UInt32.Type) throws -> UInt32
    func decode(_ type: UInt64.Type) throws -> UInt64

    func decode<T>(_ type: T.Type) throws -> T where T : Decodable
}


/// An error that occurs during the decoding of a value.
public enum DecodingError : Error {

    /// The context in which the error occurred.
    public struct Context : Sendable {

        /// The path of coding keys taken to get to the point of the failing decode
        /// call.
        public let codingPath: [CodingKey]

        /// A description of what went wrong, for debugging purposes.
        public let debugDescription: String

        /// The underlying error which caused this error, if any.
        public let underlyingError: (Error)?

        public init(codingPath: [CodingKey], debugDescription: String, underlyingError: (Error)? = nil) {
            self.codingPath = codingPath
            self.debugDescription = debugDescription
            self.underlyingError = underlyingError
        }
    }

    /// An indication that a value of the given type could not be decoded because
    /// it did not match the type of what was found in the encoded payload.
    ///
    /// As associated values, this case contains the attempted type and context
    /// for debugging.
    case typeMismatch(Any.Type, DecodingError.Context)

    /// An indication that a non-optional value of the given type was expected,
    /// but a null value was found.
    ///
    /// As associated values, this case contains the attempted type and context
    /// for debugging.
    case valueNotFound(Any.Type, DecodingError.Context)

    /// An indication that a keyed decoding container was asked for an entry for
    /// the given key, but did not contain one.
    ///
    /// As associated values, this case contains the attempted key and context
    /// for debugging.
    case keyNotFound(CodingKey, DecodingError.Context)

    /// An indication that the data is corrupted or otherwise invalid.
    ///
    /// As an associated value, this case contains the context for debugging.
    case dataCorrupted(DecodingError.Context)

    /// Returns a new `.dataCorrupted` error using a constructed coding path and
    /// the given debug description.
    //public static func dataCorruptedError<C>(forKey key: C.Key, in container: C, debugDescription: String) -> DecodingError where C : KeyedDecodingContainerProtocol {
    //    fatalError("SKIP DECODING TODO")
    //}

    /// Returns a new `.dataCorrupted` error using a constructed coding path and
    /// the given debug description.
    public static func dataCorruptedError(in container: UnkeyedDecodingContainer, debugDescription: String) -> DecodingError {
        fatalError("SKIP DECODING TODO")
    }

    /// Returns a new `.dataCorrupted` error using a constructed coding path and
    /// the given debug description.
    public static func dataCorruptedError(in container: SingleValueDecodingContainer, debugDescription: String) -> DecodingError {
        fatalError("SKIP DECODING TODO")
    }
}

internal class _KeyedDecodingContainerBase {
  internal init(){}

  deinit {}

  internal var codingPath: [CodingKey] {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal var allKeys: [CodingKey] {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func contains<K: CodingKey>(_ key: K) -> Bool {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeNil<K: CodingKey>(forKey key: K) throws -> Bool {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Bool.Type,
    forKey key: K
  ) throws -> Bool {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: String.Type,
    forKey key: K
  ) throws -> String {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Double.Type,
    forKey key: K
  ) throws -> Double {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Float.Type,
    forKey key: K
  ) throws -> Float {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  #if !SKIP // Int = Int32 in Kotlin
  internal func decode<K: CodingKey>(
    _ type: Int.Type,
    forKey key: K
  ) throws -> Int {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }
  #endif

  internal func decode<K: CodingKey>(
    _ type: Int8.Type,
    forKey key: K
  ) throws -> Int8 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Int16.Type,
    forKey key: K
  ) throws -> Int16 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Int32.Type,
    forKey key: K
  ) throws -> Int32 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: Int64.Type,
    forKey key: K
  ) throws -> Int64 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  #if !SKIP // UInt = UInt32 in Kotlin
  internal func decode<K: CodingKey>(
    _ type: UInt.Type,
    forKey key: K
  ) throws -> UInt {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }
  #endif

  internal func decode<K: CodingKey>(
    _ type: UInt8.Type,
    forKey key: K
  ) throws -> UInt8 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: UInt16.Type,
    forKey key: K
  ) throws -> UInt16 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: UInt32.Type,
    forKey key: K
  ) throws -> UInt32 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<K: CodingKey>(
    _ type: UInt64.Type,
    forKey key: K
  ) throws -> UInt64 {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decode<T: Decodable, K: CodingKey>(
    _ type: T.Type,
    forKey key: K
  ) throws -> T {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Bool.Type,
    forKey key: K
  ) throws -> Bool? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: String.Type,
    forKey key: K
  ) throws -> String? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Double.Type,
    forKey key: K
  ) throws -> Double? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Float.Type,
    forKey key: K
  ) throws -> Float? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  #if !SKIP // Int = Int32 in Kotlin
  internal func decodeIfPresent<K: CodingKey>(
    _ type: Int.Type,
    forKey key: K
  ) throws -> Int? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }
  #endif

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Int8.Type,
    forKey key: K
  ) throws -> Int8? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Int16.Type,
    forKey key: K
  ) throws -> Int16? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Int32.Type,
    forKey key: K
  ) throws -> Int32? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: Int64.Type,
    forKey key: K
  ) throws -> Int64? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  #if !SKIP // UInt = UInt32 in Kotlin
  internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt.Type,
    forKey key: K
  ) throws -> UInt? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }
  #endif

  internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt8.Type,
    forKey key: K
  ) throws -> UInt8? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt16.Type,
    forKey key: K
  ) throws -> UInt16? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt32.Type,
    forKey key: K
  ) throws -> UInt32? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt64.Type,
    forKey key: K
  ) throws -> UInt64? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func decodeIfPresent<T: Decodable, K: CodingKey>(
    _ type: T.Type,
    forKey key: K
  ) throws -> T? {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }


  internal func nestedContainer<NestedKey: CodingKey>(
    keyedBy type: NestedKey.Type,
    forKey key: CodingKey
  ) throws -> KeyedDecodingContainer<NestedKey> {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func nestedUnkeyedContainer<K: CodingKey>(
    forKey key: K
  ) throws -> UnkeyedDecodingContainer {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func superDecoder() throws -> Decoder {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }

  internal func superDecoder<K: CodingKey>(forKey key: K) throws -> Decoder {
    fatalError("_KeyedDecodingContainerBase cannot be used directly.")
  }
}


// internal final class _KeyedDecodingContainerBox<Concrete: KeyedDecodingContainerProtocol>: _KeyedDecodingContainerBase {
internal final class _KeyedDecodingContainerBox: _KeyedDecodingContainerBase {
  // typealias Key = Concrete.Key

  internal var concrete: KeyedDecodingContainerProtocol

  internal init(_ container: KeyedDecodingContainerProtocol) {
    concrete = container
  }

  override var codingPath: [CodingKey] {
    return concrete.codingPath
  }

  override var allKeys: [CodingKey] {
    return concrete.allKeys
  }

  override internal func contains<K: CodingKey>(_ key: K) -> Bool {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return concrete.contains(key)
  }

  override internal func decodeNil<K: CodingKey>(forKey key: K) throws -> Bool {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeNil(forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Bool.Type,
    forKey key: K
  ) throws -> Bool {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Bool.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: String.Type,
    forKey key: K
  ) throws -> String {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(String.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Double.Type,
    forKey key: K
  ) throws -> Double {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Double.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Float.Type,
    forKey key: K
  ) throws -> Float {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Float.self, forKey: key)
  }

  #if !SKIP // Int = Int32 in Kotlin
  override internal func decode<K: CodingKey>(
    _ type: Int.Type,
    forKey key: K
  ) throws -> Int {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Int.self, forKey: key)
  }
  #endif

  override internal func decode<K: CodingKey>(
    _ type: Int8.Type,
    forKey key: K
  ) throws -> Int8 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Int8.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Int16.Type,
    forKey key: K
  ) throws -> Int16 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Int16.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Int32.Type,
    forKey key: K
  ) throws -> Int32 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Int32.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: Int64.Type,
    forKey key: K
  ) throws -> Int64 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(Int64.self, forKey: key)
  }

  #if !SKIP // Int = Int32 in Kotlin
  override internal func decode<K: CodingKey>(
    _ type: UInt.Type,
    forKey key: K
  ) throws -> UInt {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(UInt.self, forKey: key)
  }
  #endif

  override internal func decode<K: CodingKey>(
    _ type: UInt8.Type,
    forKey key: K
  ) throws -> UInt8 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(UInt8.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: UInt16.Type,
    forKey key: K
  ) throws -> UInt16 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(UInt16.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: UInt32.Type,
    forKey key: K
  ) throws -> UInt32 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(UInt32.self, forKey: key)
  }

  override internal func decode<K: CodingKey>(
    _ type: UInt64.Type,
    forKey key: K
  ) throws -> UInt64 {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(UInt64.self, forKey: key)
  }

  override internal func decode<T: Decodable, K: CodingKey>(
    _ type: T.Type,
    forKey key: K
  ) throws -> T {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decode(type, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Bool.Type,
    forKey key: K
  ) throws -> Bool? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Bool.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: String.Type,
    forKey key: K
  ) throws -> String? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(String.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Double.Type,
    forKey key: K
  ) throws -> Double? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Double.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Float.Type,
    forKey key: K
  ) throws -> Float? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Float.self, forKey: key)
  }

  #if !SKIP // Int = Int32 in Kotlin
  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Int.Type,
    forKey key: K
  ) throws -> Int? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Int.self, forKey: key)
  }
  #endif

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Int8.Type,
    forKey key: K
  ) throws -> Int8? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Int8.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Int16.Type,
    forKey key: K
  ) throws -> Int16? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Int16.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Int32.Type,
    forKey key: K
  ) throws -> Int32? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Int32.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: Int64.Type,
    forKey key: K
  ) throws -> Int64? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(Int64.self, forKey: key)
  }

  #if !SKIP // UInt = UInt32 in Kotlin
  override internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt.Type,
    forKey key: K
  ) throws -> UInt? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(UInt.self, forKey: key)
  }
  #endif

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt8.Type,
    forKey key: K
  ) throws -> UInt8? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(UInt8.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt16.Type,
    forKey key: K
  ) throws -> UInt16? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(UInt16.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt32.Type,
    forKey key: K
  ) throws -> UInt32? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(UInt32.self, forKey: key)
  }

  override internal func decodeIfPresent<K: CodingKey>(
    _ type: UInt64.Type,
    forKey key: K
  ) throws -> UInt64? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(UInt64.self, forKey: key)
  }

  override internal func decodeIfPresent<T: Decodable, K: CodingKey>(
    _ type: T.Type,
    forKey key: K
  ) throws -> T? {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.decodeIfPresent(type, forKey: key)
  }

//  override internal func nestedContainer<NestedKey, K: CodingKey>(
//    keyedBy type: NestedKey.Type,
//    forKey key: K
//  ) throws -> KeyedDecodingContainer<NestedKey> {
//    //_internalInvariant(K.self == Key.self)
//    //let key = unsafeBitCast(key, to: Key.self)
//    return try concrete.nestedContainer(keyedBy: NestedKey.self, forKey: key)
//  }

  override internal func nestedUnkeyedContainer<K: CodingKey>(
    forKey key: K
  ) throws -> UnkeyedDecodingContainer {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.nestedUnkeyedContainer(forKey: key)
  }

  override internal func superDecoder() throws -> Decoder {
    return try concrete.superDecoder()
  }

  override internal func superDecoder<K: CodingKey>(forKey key: K) throws -> Decoder {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return try concrete.superDecoder(forKey: key)
  }
}
