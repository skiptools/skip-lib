// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
// SKIP SYMBOLFILE

#if SKIP

extension Bool: CustomStringConvertible {
    public static func random() -> Bool { fatalError() }
    public static func random(using gen: inout RandomNumberGenerator) -> Bool { fatalError() }
    public var description: String { return "" }

    @available(*, unavailable)
    public func toggle() {
    }
}

#endif
