// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

public protocol CodingKey : CustomDebugStringConvertible, CustomStringConvertible, Sendable {
    var rawValue: String { get }
    var stringValue: String { get }
    var intValue: Int? { get }
}

extension CodingKey {
    public var stringValue: String {
        return rawValue
    }

    public var intValue: Int? {
        return Int(rawValue)
    }

    public var description: String {
        return rawValue
    }

    public var debugDescription: String {
        return rawValue
    }
}

public protocol CodingKeyRepresentable {
    var codingKey: CodingKey { get }
}

public struct CodingUserInfoKey : RawRepresentable, Equatable, Hashable, Sendable {
    public let rawValue: String
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

public enum EncodingError : Error {
    public struct Context : Sendable {
        public let codingPath: [CodingKey]
        public let debugDescription: String
        public let underlyingError: (any Error)?

        public init(codingPath: [CodingKey], debugDescription: String, underlyingError: (any Error)? = nil) {
            self.codingPath = codingPath
            self.debugDescription = debugDescription
            self.underlyingError = underlyingError
        }
    }

    case invalidValue(Any, EncodingError.Context)
}

public enum DecodingError : Error {
    public struct Context : Sendable {
        public let codingPath: [CodingKey]
        public let debugDescription: String
        public let underlyingError: (any Error)?

        public init(codingPath: [CodingKey], debugDescription: String, underlyingError: (any Error)? = nil) {
            self.codingPath = codingPath
            self.debugDescription = debugDescription
            self.underlyingError = underlyingError
        }
    }

    case typeMismatch(Any.Type, DecodingError.Context)
    case valueNotFound(Any.Type, DecodingError.Context)
    case keyNotFound(CodingKey, DecodingError.Context)
    case dataCorrupted(DecodingError.Context)

    public static func dataCorruptedError<C>(forKey key: CodingKey, in container: C, debugDescription: String) -> DecodingError where C : KeyedDecodingContainerProtocol {
        DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [key], debugDescription: debugDescription))
    }

    public static func dataCorruptedError(in container: any UnkeyedDecodingContainer, debugDescription: String) -> DecodingError {
        DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: debugDescription))
    }

    public static func dataCorruptedError(in container: any SingleValueDecodingContainer, debugDescription: String) -> DecodingError {
        DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: debugDescription))
    }
}

#endif
