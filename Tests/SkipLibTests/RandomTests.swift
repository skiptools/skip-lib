// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

#if !SKIP
@testable import struct SkipLib.PseudoRandomNumberGenerator
#endif

final class RandomTests: XCTestCase {
    /// Verify that the system RNG is at least a little bit random.
    func testSystemRandomNumberGenerator() throws {
        var rng = SystemRandomNumberGenerator()
        XCTAssertNotEqual(rng.next(), rng.next())
        XCTAssertNotEqual(rng.next(), rng.next())
        XCTAssertNotEqual(rng.next(), rng.next())
        XCTAssertNotEqual(rng.next(), rng.next())
        XCTAssertNotEqual(rng.next(), rng.next())
    }

    /// Verifies that a sequence of seeded values returns the same numbers in Swift and Java.
    func testPseudoRandomNumberGenerator() throws {
        var rng = PseudoRandomNumberGenerator.seeded(seed: 1153443)
        XCTAssertEqual(UInt64(3342841532113466981), rng.next())
        XCTAssertEqual(UInt64(16508832217077714543), rng.next())
        XCTAssertEqual(UInt64(13284189861412038678), rng.next())
        XCTAssertEqual(UInt64(4631059369955418223), rng.next())
        XCTAssertEqual(UInt64(5587727113876742984), rng.next())
    }
}
