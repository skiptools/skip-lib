// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

public struct ObjectIdentifier: Hashable {
    let object: Any

    public static func ==(lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Boolean {
        return lhs.object === rhs.object
    }
}

#endif
