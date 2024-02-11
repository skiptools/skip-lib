// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

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
