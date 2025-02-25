// Copyright 2024–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import XCTest

final class CodableTests: XCTestCase {
}

// Just verify that this transpiles into valid code
enum CodableTestsEnum: Codable {
    case string(String?)
    case int(Int?)

    enum RawType: String, Codable {
        case string
        case int
    }

    enum CodingKeys: String, CodingKey {
        case type
        case value
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawType: RawType = try container.decode(RawType.self, forKey: .type)
        switch rawType {
        case .int:
            self = .int(try container.decodeIfPresent(Int.self, forKey: .value))
        case .string:
            self = .string(try container.decodeIfPresent(String.self, forKey: .value))
        }
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let rawType: RawType
        switch self {
        case let .string(value):
            rawType = .string
            try container.encodeIfPresent(value, forKey: .value)
        case let .int(value):
            rawType = .int
            try container.encodeIfPresent(value, forKey: .value)
        }
        try container.encode(rawType, forKey: .type)
    }
}
