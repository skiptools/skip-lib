// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
// SKIP SYMBOLFILE

#if SKIP

public protocol CustomStringConvertible {
    var description: String { get }
}

public protocol CustomDebugStringConvertible {
    var debugDescription: String { get }
}

#endif
