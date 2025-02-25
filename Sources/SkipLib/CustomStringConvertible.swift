// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
// SKIP SYMBOLFILE

#if SKIP

public protocol CustomStringConvertible {
    var description: String { get }
}

public protocol CustomDebugStringConvertible {
    var debugDescription: String { get }
}

#endif
