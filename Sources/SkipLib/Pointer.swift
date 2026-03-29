// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
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
