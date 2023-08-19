// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

public protocol Encodable {
    func encode(to encoder: Encoder) throws
}

#if !SKIP // Kotlin has no composite protocols
public typealias Codable = Decodable & Encodable
#else
public protocol Codable : Decodable, Encodable {
}
#endif

public protocol CodingKey : CustomDebugStringConvertible, CustomStringConvertible, Sendable {
    #if SKIP // Kotlin does not support constructors in protocols
    // SKIP DECLARE: fun init(stringValue: String): CodingKey?
    // static func `init`(stringValue: String) -> CodingKey?
    // SKIP DECLARE: fun init(intValue: Int): CodingKey?
    // static func `init`(intValue: Int) -> CodingKey?
    #else
    init?(stringValue: String)
    init?(intValue: Int)
    #endif

    var rawValue: String { get }
    var stringValue: String { get }
    var intValue: Int? { get }
}

extension CodingKey {
    public var stringValue: String {
        rawValue
    }
}

extension CodingKey {
    /// Skip only supports String codable keys; Int always returns nil.
    public var intValue: Int? {
        nil
    }

    /// A textual representation of this key.
    public var description: String {
        rawValue
    }

    /// A textual representation of this key, suitable for debugging.
    // SKIP DECLARE: override val debugDescription: String
    public var debugDescription: String {
        // TODO: mimic the format of Swift.CodingKey.debugDescription?
        rawValue
    }
}

public protocol Encoder {
    var codingPath: [CodingKey] { get }
    var userInfo: [CodingUserInfoKey : Any] { get }
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey
    func unkeyedContainer() -> UnkeyedEncodingContainer
    func singleValueContainer() -> SingleValueEncodingContainer
}

/// A type that provides a view into an encoder's storage and is used to hold
/// the encoded properties of an encodable type in a keyed manner.
///
/// Encoders should provide types conforming to
/// `KeyedEncodingContainerProtocol` for their format.
///
/// Note that this type differs from `Swift.KeyedEncodingContainerProtocol`
/// in that is does not declare `associatedtype Key : CodingKey`,
/// as it is not currently supported in Skip.
public protocol KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] { get }
    mutating func encodeNil(forKey key: CodingKey) throws
    mutating func encode(_ value: Bool, forKey key: CodingKey) throws
    mutating func encode(_ value: String, forKey key: CodingKey) throws
    mutating func encode(_ value: Double, forKey key: CodingKey) throws
    mutating func encode(_ value: Float, forKey key: CodingKey) throws
    mutating func encode(_ value: Int8, forKey key: CodingKey) throws
    mutating func encode(_ value: Int16, forKey key: CodingKey) throws
    mutating func encode(_ value: Int32, forKey key: CodingKey) throws
    mutating func encode(_ value: Int64, forKey key: CodingKey) throws
    mutating func encode(_ value: UInt8, forKey key: CodingKey) throws
    mutating func encode(_ value: UInt16, forKey key: CodingKey) throws
    mutating func encode(_ value: UInt32, forKey key: CodingKey) throws
    mutating func encode(_ value: UInt64, forKey key: CodingKey) throws
#if !SKIP // Int = Int32 in Kotlin
    mutating func encode(_ value: Int, forKey key: CodingKey) throws
    mutating func encode(_ value: UInt, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Int?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: UInt?, forKey key: CodingKey) throws
#endif
    mutating func encode<T>(_ value: T, forKey key: CodingKey) throws where T : Encodable
    mutating func encodeConditional<T>(_ object: T, forKey key: CodingKey) throws where T : Encodable
    mutating func encodeIfPresent(_ value: Bool?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: String?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Double?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Float?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Int8?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Int16?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Int32?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: Int64?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: UInt8?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: UInt16?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: UInt32?, forKey key: CodingKey) throws
    mutating func encodeIfPresent(_ value: UInt64?, forKey key: CodingKey) throws
    mutating func encodeIfPresent<T>(_ value: T?, forKey key: CodingKey) throws where T : Encodable
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: CodingKey) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    mutating func nestedUnkeyedContainer(forKey key: CodingKey) -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder
    mutating func superEncoder(forKey key: CodingKey) -> Encoder
}

extension KeyedEncodingContainerProtocol {
    public mutating func encodeConditional<T>(_ object: T, forKey key: CodingKey) throws where T : Encodable {
        try encode(object, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Bool?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: String?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Double?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Float?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

#if !SKIP // Int = Int32 in Kotlin
    public mutating func encodeIfPresent(_ value: Int?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }
    public mutating func encodeIfPresent(_ value: UInt?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }
#endif

    public mutating func encodeIfPresent(_ value: Int8?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int16?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int32?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int64?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt8?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt16?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt32?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt64?, forKey key: CodingKey) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    public mutating func encodeIfPresent<T>(_ value: T?, forKey key: CodingKey) throws where T : Encodable {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }
}

public struct KeyedEncodingContainer<Key: CodingKey> : KeyedEncodingContainerProtocol {
    internal var _box: _KeyedEncodingContainerBase

    public init(_ container: KeyedEncodingContainerProtocol) {
        self._box = _KeyedEncodingContainerBox(container)
    }

    public var codingPath: [any CodingKey] {
      return _box.codingPath
    }

    public mutating func encodeNil(forKey key: CodingKey) throws {
        try _box.encodeNil(forKey: key)
    }

    public mutating func encode(_ value: Bool, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: String, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Double, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Float, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

#if !SKIP // Int = Int32 in Kotlin
    public mutating func encode(_ value: Int, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }
#endif

    public mutating func encode(_ value: Int8, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int16, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int32, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int64, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt8, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt16, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt32, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt64, forKey key: CodingKey) throws {
        try _box.encode(value, forKey: key)
    }

    public mutating func encode<T>(_ value: T, forKey key: CodingKey) throws where T : Encodable {
        try _box.encode(value, forKey: key)
    }

    public mutating func encodeConditional<T>(_ object: T, forKey key: CodingKey) throws where T : Encodable {
        fatalError("TODO: KeyedEncodingContainer.encodeIfPresent T \(key)")
    }

    public mutating func encodeIfPresent(_ value: Bool?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: String?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Double?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Float?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int8?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int16?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int32?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: Int64?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt8?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt16?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt32?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent(_ value: UInt64?, forKey key: CodingKey) throws {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func encodeIfPresent<T>(_ value: T?, forKey key: CodingKey) throws where T : Encodable {
        try _box.encodeIfPresent(value, forKey: key)
    }

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: CodingKey) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        return _box.nestedContainer(keyedBy: keyType, forKey: key)
    }

    public mutating func nestedUnkeyedContainer(forKey key: CodingKey) -> UnkeyedEncodingContainer {
        return _box.nestedUnkeyedContainer(forKey: key)

    }
    public mutating func superEncoder() -> Encoder {
        return _box.superEncoder()
    }

    public mutating func superEncoder(forKey key: CodingKey) -> Encoder {
        return _box.superEncoder(forKey: key)
    }
}

extension KeyedEncodingContainerProtocol {
    mutating func encode<T, U>(_ value: Dictionary<T, U>, forKey key: CodingKey) throws {
        //fatalError("SKIP TODO: KeyedEncodingContainerProtocol.encode dictionary")
        // var container = nestedContainer(keyedBy: CodingKey.self, forKey: key)
        //try container.encode(contentsOf: value)
    }

    mutating func encode<T>(_ value: any Sequence<T>, forKey key: CodingKey) throws {
        var container = nestedUnkeyedContainer(forKey: key)
        try container.encode(contentsOf: value)
    }
}

public protocol UnkeyedEncodingContainer {
    var codingPath: [CodingKey] { get }
    var count: Int { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Bool) throws
    mutating func encode(_ value: String) throws
    mutating func encode(_ value: Double) throws
    mutating func encode(_ value: Float) throws
    #if !SKIP // Int = Int32 in Kotlin
    mutating func encode(_ value: Int) throws
    mutating func encode(_ value: UInt) throws
    #endif
    mutating func encode(_ value: Int8) throws
    mutating func encode(_ value: Int16) throws
    mutating func encode(_ value: Int32) throws
    mutating func encode(_ value: Int64) throws
    mutating func encode(_ value: UInt8) throws
    mutating func encode(_ value: UInt16) throws
    mutating func encode(_ value: UInt32) throws
    mutating func encode(_ value: UInt64) throws
    mutating func encode<T>(_ value: T) throws where T : Encodable

    #if !SKIP // “Skip does not support the referenced type as a generic constraint”
    mutating func encodeConditional<T>(_ object: T) throws where T : Encodable
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Bool
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == String
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Double
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Float
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int8
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int16
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int32
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int64
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt8
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt16
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt32
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt64
    mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element : Encodable
    #endif

    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> 
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
    mutating func superEncoder() -> Encoder

    mutating func encode<T>(contentsOf sequence: any Sequence<T>) throws
}

extension UnkeyedEncodingContainer {
    /// Encodes a reference to the given object only if it is encoded
    /// unconditionally elsewhere in the payload (previously, or in the future).
    ///
    /// For encoders which don't support this feature, the default implementation
    /// encodes the given object unconditionally.
    ///
    /// For formats which don't support this feature, the default implementation
    /// encodes the given object unconditionally.
    ///
    /// - parameter object: The object to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public mutating func encodeConditional<T>(_ object: T) throws where T : Encodable {
        fatalError("SKIP TODO: encodeConditional")
        #if SKIP
        return // 'Nothing' return type needs to be specified explicitly
        #endif
    }

    // TODO: Skip does not support the referenced type as a generic constraint
    // so we just have a single `encode<T>(contentsOf sequence: any Sequence<T>)` below
    #if !SKIP
    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Bool {
        fatalError("SKIP TODO: encode contentsOf: sequence")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == String {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Double {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Float {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int8 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int16 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int32 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int64 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt8 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt16 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt32 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt64 {
        fatalError("SKIP TODO: encodeConditional")
    }

    public mutating func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element : Encodable {
        fatalError("SKIP TODO: encodeConditional")
    }
    #else
    public mutating func encode<T>(contentsOf sequence: any Sequence<T>) throws {
        for element in sequence {
            switch (element) {
            case let str as String:
                try self.encode(str)
            case let boolValue as Bool:
                try self.encode(boolValue)
            #if !SKIP
            case let num as Int:
                try self.encode(num)
            case let num as UInt:
                try self.encode(num)
            #endif
            case let num as Int8:
                try self.encode(num)
            case let num as Int16:
                try self.encode(num)
            case let num as Int32:
                try self.encode(num)
            case let num as Int64:
                try self.encode(num)
            case let num as UInt8:
                try self.encode(num)
            case let num as UInt16:
                try self.encode(num)
            case let num as UInt32:
                try self.encode(num)
            case let num as UInt64:
                try self.encode(num)
            case let num as Float:
                try self.encode(num)
            case let num as Double:
                try self.encode(num)
            case let enc as Encodable:
                try self.encode(enc)
            default:
                // TODO: testCaseStatementsIgnoreIfSkip
                // SKIP NOWARN
                if let seq = element as? any Dictionary<Any, Any> {
                    fatalError("KeyedEncodingContainerProtocol: unhandled dictionary \(element)")
                } else if let seq = element as? any Sequence<Any> {
                    var container2 = self.nestedUnkeyedContainer()
                    try container2.encode(contentsOf: seq)
                } else {
                    fatalError("KeyedEncodingContainerProtocol: unhandled encode for \(element)")
                }
            }
        }

    }
    #endif
}

public protocol SingleValueEncodingContainer {
    var codingPath: [CodingKey] { get }
    mutating func encodeNil() throws
    mutating func encode(_ value: Bool) throws
    mutating func encode(_ value: String) throws
    mutating func encode(_ value: Double) throws
    mutating func encode(_ value: Float) throws
#if !SKIP // Int = Int32 in Kotlin
    mutating func encode(_ value: Int) throws
    mutating func encode(_ value: UInt) throws
#endif
    mutating func encode(_ value: Int8) throws
    mutating func encode(_ value: Int16) throws
    mutating func encode(_ value: Int32) throws
    mutating func encode(_ value: Int64) throws
    mutating func encode(_ value: UInt8) throws
    mutating func encode(_ value: UInt16) throws
    mutating func encode(_ value: UInt32) throws
    mutating func encode(_ value: UInt64) throws
    mutating func encode<T>(_ value: T) throws where T : Encodable
}

public struct CodingUserInfoKey : RawRepresentable, Equatable, Hashable, Sendable {
    public var hashValue: Int {
        fatalError("TODO: hashValue")
    }

    #if !SKIP
    public typealias RawValue = String
    #endif
    public let rawValue: String
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}
public enum EncodingError : Error {
    public struct Context : Sendable {
        public let codingPath: [CodingKey]
        public let debugDescription: String
        public let underlyingError: (Error)?
        //public init(codingPath: [CodingKey], debugDescription: String, underlyingError: (Error)? = nil) {
            //fatalError("TODO")
        //}
    }
    case invalidValue(Any, EncodingError.Context)
}

@available(macOS 12.3, iOS 15.4, watchOS 8.5, tvOS 15.4, *)
public protocol CodingKeyRepresentable {

    @available(macOS 12.3, iOS 15.4, watchOS 8.5, tvOS 15.4, *)
    var codingKey: CodingKey { get }

    #if !SKIP
    @available(macOS 12.3, iOS 15.4, watchOS 8.5, tvOS 15.4, *)
    init?<T>(codingKey: T) where T : CodingKey
    #endif
}

//===----------------------------------------------------------------------===//
// Keyed Encoding Container Implementations
//===----------------------------------------------------------------------===//

internal class _KeyedEncodingContainerBase {
  internal init(){}

  deinit {}

  // These must all be given a concrete implementation in _*Box.
  internal var codingPath: [CodingKey] {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeNil<K: CodingKey>(forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Bool, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: String, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Double, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Float, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

#if !SKIP // Int = Int32 in Kotlin
  internal func encode<K: CodingKey>(_ value: Int, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }
#endif

  internal func encode<K: CodingKey>(_ value: Int8, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Int16, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Int32, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: Int64, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

#if !SKIP // Int = Int32 in Kotlin
  internal func encode<K: CodingKey>(_ value: UInt, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }
#endif

  internal func encode<K: CodingKey>(_ value: UInt8, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: UInt16, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: UInt32, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<K: CodingKey>(_ value: UInt64, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encode<T: Encodable, K: CodingKey>(_ value: T, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeConditional<T: Encodable, K: CodingKey>(
    _ object: T,
    forKey key: K
  ) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Bool?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: String?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Double?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Float?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

#if !SKIP // Int = Int32 in Kotlin
  internal func encodeIfPresent<K: CodingKey>(_ value: Int?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }
#endif

  internal func encodeIfPresent<K: CodingKey>(_ value: Int8?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Int16?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Int32?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: Int64?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

#if !SKIP // Int = Int32 in Kotlin
  internal func encodeIfPresent<K: CodingKey>(_ value: UInt?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }
#endif

  internal func encodeIfPresent<K: CodingKey>(_ value: UInt8?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: UInt16?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: UInt32?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<K: CodingKey>(_ value: UInt64?, forKey key: K) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func encodeIfPresent<T: Encodable, K: CodingKey>(
    _ value: T?,
    forKey key: K
  ) throws {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func nestedContainer<NestedKey: CodingKey>(
    keyedBy keyType: NestedKey.Type,
    forKey key: CodingKey
  ) -> KeyedEncodingContainer<NestedKey> {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func nestedUnkeyedContainer<K: CodingKey>(
    forKey key: K
  ) -> UnkeyedEncodingContainer {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func superEncoder() -> Encoder {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }

  internal func superEncoder<K: CodingKey>(forKey key: K) -> Encoder {
    fatalError("_KeyedEncodingContainerBase cannot be used directly.")
  }
}


// internal final class _KeyedEncodingContainerBox<Concrete: KeyedEncodingContainerProtocol>: _KeyedEncodingContainerBase {
internal final class _KeyedEncodingContainerBox: _KeyedEncodingContainerBase {
  // typealias Key = Concrete.Key

  internal var concrete: KeyedEncodingContainerProtocol

  internal init(_ container: KeyedEncodingContainerProtocol) {
    concrete = container
  }

  override internal var codingPath: [CodingKey] {
    return concrete.codingPath
  }

  override internal func encodeNil<K: CodingKey>(forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeNil(forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Bool, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: String, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Double, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Float, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

#if !SKIP // Int = Int32 in Kotlin
  override internal func encode<K: CodingKey>(_ value: Int, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }
#endif

  override internal func encode<K: CodingKey>(_ value: Int8, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Int16, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Int32, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: Int64, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

#if !SKIP // Int = Int32 in Kotlin
  override internal func encode<K: CodingKey>(_ value: UInt, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }
#endif

  override internal func encode<K: CodingKey>(_ value: UInt8, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: UInt16, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: UInt32, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<K: CodingKey>(_ value: UInt64, forKey key: K) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encode<T: Encodable, K: CodingKey>(
    _ value: T,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encode(value, forKey: key)
  }

  override internal func encodeConditional<T: Encodable, K: CodingKey>(
    _ object: T,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeConditional(object, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Bool?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: String?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Double?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Float?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

#if !SKIP // Int = Int32 in Kotlin
  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Int?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }
#endif

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Int8?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Int16?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Int32?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: Int64?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

#if !SKIP // Int = Int32 in Kotlin
  override internal func encodeIfPresent<K: CodingKey>(
    _ value: UInt?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }
#endif

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: UInt8?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: UInt16?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: UInt32?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<K: CodingKey>(
    _ value: UInt64?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

  override internal func encodeIfPresent<T: Encodable, K: CodingKey>(
    _ value: T?,
    forKey key: K
  ) throws {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    try concrete.encodeIfPresent(value, forKey: key)
  }

//  // SKIP DECLARE: override inline fun <reified NestedKey> nestedContainer(keyedBy: KClass<NestedKey>, forKey: CodingKey): KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
//  override internal func nestedContainer<NestedKey: CodingKey>(
//    keyedBy keyType: NestedKey.Type,
//    forKey key: CodingKey
//  ) -> KeyedEncodingContainer<NestedKey> {
//    //_internalInvariant(K.self == Key.self)
//    //let key = unsafeBitCast(key, to: Key.self)
//    return concrete.nestedContainer(keyedBy: NestedKey.self, forKey: key)
//  }

  override internal func nestedUnkeyedContainer<K: CodingKey>(
    forKey key: K
  ) -> UnkeyedEncodingContainer {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return concrete.nestedUnkeyedContainer(forKey: key)
  }

  override internal func superEncoder() -> Encoder {
    return concrete.superEncoder()
  }

  override internal func superEncoder<K: CodingKey>(forKey key: K) -> Encoder {
    //_internalInvariant(K.self == Key.self)
    //let key = unsafeBitCast(key, to: Key.self)
    return concrete.superEncoder(forKey: key)
  }
}
