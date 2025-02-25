// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if SKIP

public struct ObjectIdentifier: Hashable {
    let object: Any

    public static func ==(lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Boolean {
        return lhs.object === rhs.object
    }
}

#endif
