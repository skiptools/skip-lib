// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

@available(*, unavailable)
public struct UnsafeMutableBufferPointer<Element> { }

@available(*, unavailable)
public struct UnsafeBufferPointer<Element> { }

@available(*, unavailable)
public struct UnsafePointer<Pointee> { }

@available(*, unavailable)
public struct UnsafeMutablePointer<Pointee> { }

@available(*, unavailable)
public struct UnsafeMutableRawBufferPointer { }

@available(*, unavailable)
public struct UnsafeRawBufferPointer { }

@available(*, unavailable)
public struct UnsafeRawPointer { }

@available(*, unavailable)
public struct UnsafeMutableRawPointer { }

@available(*, unavailable)
public func withUnsafeMutableBytes<T, Result>(of value: inout T, _ body: (Any /* UnsafeMutableRawBufferPointer */) throws -> Result) rethrows -> Result { fatalError() }

@available(*, unavailable)
public func withUnsafeBytes<T, Result>(of value: inout T, _ body: (Any /* UnsafeRawBufferPointer */) throws -> Result) rethrows -> Result { fatalError() }

@available(*, unavailable)
public func withUnsafeBytes<T, Result>(of value: T, _ body: (Any /* UnsafeRawBufferPointer */) throws -> Result) rethrows -> Result { fatalError() }

@available(*, unavailable)
public func withUnsafeTemporaryAllocation<R>(byteCount: Int, alignment: Int, _ body: (Any /* UnsafeMutableRawBufferPointer */) throws -> R) rethrows -> R { fatalError() }

@available(*, unavailable)
public func withUnsafeTemporaryAllocation<R>(of type: Any /* T.Type */, capacity: Int, _ body: (Any /* UnsafeMutableBufferPointer<T> */) throws -> R) rethrows -> R { fatalError() }
