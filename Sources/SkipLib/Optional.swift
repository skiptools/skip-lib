// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
// SKIP SYMBOLFILE

#if SKIP

// Skip does not generally treat optional values as instances of any true Optional type. We do, however, attempt to detect
// cases in which non-optional calls are made on optional values. In those cases we check whether the call is a member of
// this Optional type

public struct Optional<Wrapped> {
    public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U? {
        fatalError()
    }

    public func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U? {
        fatalError()
    }
}

#endif
