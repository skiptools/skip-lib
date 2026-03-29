// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
// SKIP SYMBOLFILE

#if SKIP

public protocol CaseIterable {
    static var allCases: [Self] { get }
}

#endif
