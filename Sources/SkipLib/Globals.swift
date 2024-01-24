// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// SKIP SYMBOLFILE

#if SKIP

public func fatalError(message: String = "fatalError") -> Never {
    Swift.fatalError()
}

public func assert(_ condition: Bool, _ message: String? = nil) {
}

public func precondition(_ condition: Bool, _ message: String? = nil) {
}

public func assertionFailure(_ message: String? = nil) {
}

public func preconditionFailure(_ message: String? = nil) -> Never {
    fatalError()
}

public func type<T>(of: T) -> T.Type {
    fatalError()
}

public func swap<T>(_ a: inout T, _ b: inout T) {
}

public func min<T>(_ x: T, _ y: T) -> T {
    fatalError()
}

public func max<T>(_ x: T, _ y: T) -> T {
    fatalError()
}

#endif
