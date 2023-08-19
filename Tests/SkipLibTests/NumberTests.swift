// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class NumberTests: XCTestCase {
    func testNumberMinMax() {
        #if !SKIP
        XCTAssertGreaterThan(Int8.max, Int8.min)
        XCTAssertGreaterThan(Int16.max, Int16.min)
        XCTAssertGreaterThan(Int32.max, Int32.min)
        XCTAssertGreaterThan(Int64.max, Int64.min)

        XCTAssertGreaterThan(UInt8.max, UInt8.min)
        XCTAssertGreaterThan(UInt16.max, UInt16.min)
        XCTAssertGreaterThan(UInt32.max, UInt32.min)
        XCTAssertGreaterThan(UInt64.max, UInt64.min)

        XCTAssertEqual(Int8.max, Int8(127))
        XCTAssertEqual(Int8.min, Int8(-128))

        XCTAssertEqual(UInt8.max, UInt8(255))
        XCTAssertEqual(UInt8.min, UInt8(0))

        XCTAssertEqual(Int64.max, Int64(9223372036854775807))

        #if !SKIP
        XCTAssertEqual(Int64.min, Int64(-9223372036854775808))
        #endif
        #if SKIP
        // Kotlin seems to disallow referencing Long.MIN_VALUE for some reason
        // XCTAssertEqual(Int64.min, Int64(-9223372036854775808)) // The value is out of range
        // But Long.MIN_VALUE+1 seems to be OK…
        XCTAssertEqual(Int64.min + 1, Int64(-9223372036854775807))
        #endif

        // XCTAssertEqual(UInt.max, UInt(18446744073709551615))
        XCTAssertEqual(UInt.min, UInt(0))
        #endif
    }

    func testNumberInitializers() {
        XCTAssertEqual(Int(100), 100)
        XCTAssertEqual(Int32(100), 100)

        XCTAssertEqual(Int8(100), 100)
        XCTAssertEqual(Int16(100), 100)
        XCTAssertEqual(Int64(100), 100)

        #if !SKIP
        XCTAssertEqual(UInt(100), 100) // java.lang.AssertionError: expected: java.lang.Integer<100> but was: kotlin.UInt<100>
        XCTAssertEqual(UInt8(100), 100)
        XCTAssertEqual(UInt16(100), 100)
        XCTAssertEqual(UInt32(100), 100)
        XCTAssertEqual(UInt64(100), 100)

        // java.lang.ClassCastException: class java.lang.Integer cannot be cast to class java.lang.Byte (java.lang.Integer and java.lang.Byte are in module java.base of loader 'bootstrap')
        XCTAssertEqual(100 as Int, 100)
        XCTAssertEqual(100 as Int8, 100)
        XCTAssertEqual(100 as Int16, 100)
        XCTAssertEqual(100 as Int32, 100)
        XCTAssertEqual(100 as Int64, 100)
        #endif
    }

    func testNumberConversions() {
        XCTAssertEqual(Int(13), 13)
        XCTAssertEqual(Int8(13), Int8(13))
        XCTAssertEqual(Int(Int32(13)), 13)
        XCTAssertEqual(Int(Int64(13)), 13)

        XCTAssertEqual(Int(UInt(13)), 13)
        XCTAssertEqual(Int(UInt8(13)), 13)
        XCTAssertEqual(Int(UInt32(13)), 13)
        XCTAssertEqual(Int(UInt64(13)), 13)

        XCTAssertEqual(Double(13), 13.0)
        XCTAssertEqual(Double(Float(13)), 13.0)
        XCTAssertEqual(Double(13), 13.0, accuracy: 0.0)
        XCTAssertEqual(Double(Float(13)), 13.0, accuracy: 0.0)

        XCTAssertEqual(Int(Double(Float(1.3)) * 10.0), 12)
    }

    func testIntegers() {
        let a: Int32 = 10
        let b: Int32 = 3

        // Test addition
        XCTAssertEqual(a + b, 13)

        // Test subtraction
        XCTAssertEqual(a - b, 7)

        // Test multiplication
        XCTAssertEqual(a * b, 30)

        // Test division
        XCTAssertEqual(a / b, 3)

        // Test modulo
        XCTAssertEqual(a % b, 1)

        // Test negation
        XCTAssertEqual(-a, -10)

        // Test equality
        XCTAssertNotEqual(a, b)
    }

    func testFloatingPoint() {
        let a: Double = 1.23
        let b: Double = 4.56

        // Test addition
        XCTAssertEqual(a + b, 5.79, accuracy: 0.001)

        // Test subtraction
        XCTAssertEqual(b - a, 3.33, accuracy: 0.001)

        // Test multiplication
        XCTAssertEqual(a * b, 5.6088, accuracy: 0.001)

        // Test division
        XCTAssertEqual(b / a, 3.7073, accuracy: 0.001)

        // Test negation
        XCTAssertEqual(-a, -1.23, accuracy: 0.001)

        // Test equality
        XCTAssertNotEqual(a, b)
    }

    func testUnsignedIntegers() {
        let a: UInt8 = UInt8(200)
        let b: UInt8 = UInt8(50)

        #if !SKIP
        // automatic coercion to unsigned types doesn't work

        // Test addition
        XCTAssertEqual(a + b, 250) // java.lang.AssertionError: expected: java.lang.Integer<250> but was: kotlin.UInt<250>

        // Test subtraction
        XCTAssertEqual(a - b, 150)

        // Test multiplication
        //XCTAssertEqual(a * b, 10000)

        // Test division
        XCTAssertEqual(a / b, 4)

        // Test modulo
        XCTAssertEqual(a % b, 0)

        // Test overflow behavior
        XCTAssertFalse(a.addingReportingOverflow(b).overflow)
        XCTAssertTrue(a.addingReportingOverflow(UInt8.max).overflow)

        // Test equality
        XCTAssertNotEqual(a, b)
        #endif
    }

    func testFixedWidthIntegers() {
        let a: Int16 = -300
        let b: Int16 = 600

        // Test addition
        XCTAssertEqual(a + b, 300)

        // Test subtraction
        XCTAssertEqual(b - a, 900)

        // Test multiplication
        //XCTAssertEqual(a * b, -180000)

        // Test division
        XCTAssertEqual(b / a, -2)

        // Test overflow behavior
        #if !SKIP
        XCTAssertFalse(a.addingReportingOverflow(b).overflow)
        XCTAssertFalse(a.addingReportingOverflow(Int16.max).overflow)
        XCTAssertTrue(b.addingReportingOverflow(Int16.max).overflow)
        #endif

        // Test equality
        XCTAssertNotEqual(a, b)
    }

    func testMinMax() {
        XCTAssertEqual(1, min(1, 2))
        XCTAssertEqual(2, max(1, 2))

        XCTAssertTrue(isWholeNumber(min(1, 2)))
        XCTAssertFalse(isWholeNumber(min(1.1, 2.2)))
        XCTAssertFalse(isWholeNumber(min(Double(1), 2.2)))
        #if !SKIP
        XCTAssertFalse(isWholeNumber(min(1, 2.2))) // inferred type is IntegerLiteralType[Int,Long,Byte,Short] but Comparable<Double> was expected
        #endif
    }

    func testEquatable() {
        // Check that numbers can be used as Equatable
        XCTAssertTrue(isEquatable(1))
        XCTAssertTrue(isEquatable(1.0))
        XCTAssertTrue(isEqual(1, 1))
        XCTAssertFalse(isEqual(1, 2))
        XCTAssertTrue(isEqual(1.0, 1.0))
        XCTAssertFalse(isEqual(1.0, 2.0))
    }

    func testHashable() {
        // Check that numbers can be used as Hashable
        XCTAssertTrue(isHashable(1))
        XCTAssertTrue(isHashable(1.0))
        XCTAssertTrue(hashValueEqual(1, 1))
        XCTAssertFalse(hashValueEqual(1, 2))
        XCTAssertTrue(hashValueEqual(1.0, 1.0))
        XCTAssertFalse(hashValueEqual(1.0, 2.0))
    }

    private func isWholeNumber(_ i: Int) -> Bool {
        true
    }
    private func isWholeNumber(_ d: Double) -> Bool {
        false
    }

    private func isEquatable(_ e: any Equatable) -> Bool {
        return true
    }
    private func isEqual<T: Equatable>(_ lhs: T, _ rhs: T) -> Bool {
        return lhs == rhs
    }

    private func isHashable(_ h: any Hashable) -> Bool {
        return true
    }
    private func hashValueEqual<T: Hashable>(_ lhs: T, _ rhs: T) -> Bool where T: Any {
        return lhs.hashValue == rhs.hashValue
    }
}
