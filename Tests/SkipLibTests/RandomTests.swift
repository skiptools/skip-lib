// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Testing

#if !SKIP
@testable import struct SkipLib.PseudoRandomNumberGenerator
#endif

@Suite struct RandomTests {
    /// Verify that the system RNG is at least a little bit random.
    @Test func systemRandomNumberGenerator() throws {
        var rng = SystemRandomNumberGenerator()
        #expect(rng.next() != rng.next())
        #expect(rng.next() != rng.next())
        #expect(rng.next() != rng.next())
        #expect(rng.next() != rng.next())
        #expect(rng.next() != rng.next())
    }

    /// Verifies that a sequence of seeded values returns the same numbers in Swift and Java.
    @Test func pseudoRandomNumberGenerator() throws {
        var rng = PseudoRandomNumberGenerator.seeded(seed: 1153443)
        #expect(UInt64(3342841532113466981) == rng.next())
        #expect(UInt64(16508832217077714543) == rng.next())
        #expect(UInt64(13284189861412038678) == rng.next())
        #expect(UInt64(4631059369955418223) == rng.next())
        #expect(UInt64(5587727113876742984) == rng.next())
    }
}
