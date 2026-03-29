// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
#if SKIP

public struct ObjectIdentifier: Hashable {
    let object: Any

    public static func ==(lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Boolean {
        return lhs.object === rhs.object
    }
}

#endif
