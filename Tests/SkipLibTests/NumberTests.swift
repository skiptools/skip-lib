// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing
import XCTest

@Suite struct NumberTests {
    @Test func numberMinMax() {
        #if !SKIP
        #expect(Int8.max > Int8.min)
        #expect(Int16.max > Int16.min)
        #expect(Int32.max > Int32.min)
        #expect(Int64.max > Int64.min)

        #expect(UInt8.max > UInt8.min)
        #expect(UInt16.max > UInt16.min)
        #expect(UInt32.max > UInt32.min)
        #expect(UInt64.max > UInt64.min)

        #expect(Int8.max == Int8(127))
        #expect(Int8.min == Int8(-128))

        #expect(UInt8.max == UInt8(255))
        #expect(UInt8.min == UInt8(0))

        #expect(Int64.max == Int64(9223372036854775807))

        #if !SKIP
        #expect(Int64.min == Int64(-9223372036854775808))
        #endif
        #if SKIP
        // Kotlin seems to disallow referencing Long.MIN_VALUE for some reason
        // XCTAssertEqual(Int64.min, Int64(-9223372036854775808)) // The value is out of range
        // But Long.MIN_VALUE+1 seems to be OK…
        #expect(Int64.min + 1 == Int64(-9223372036854775807))
        #endif

        // XCTAssertEqual(UInt.max, UInt(18446744073709551615))
        #expect(UInt.min == UInt(0))
        #endif
    }

    @Test func numberInitializers() {
        #expect(Int(100) == 100)
        #expect(Int32(100) == 100)

        #expect(Int8(100) == 100)
        #expect(Int16(100) == 100)
        #expect(Int64(100) == 100)

        #if !SKIP
        #expect(UInt(100) == 100) // java.lang.AssertionError: expected: java.lang.Integer<100> but was: kotlin.UInt<100>
        #expect(UInt8(100) == 100)
        #expect(UInt16(100) == 100)
        #expect(UInt32(100) == 100)
        #expect(UInt64(100) == 100)

        // java.lang.ClassCastException: class java.lang.Integer cannot be cast to class java.lang.Byte (java.lang.Integer and java.lang.Byte are in module java.base of loader 'bootstrap')
        #expect(100 as Int == 100)
        #expect(100 as Int8 == 100)
        #expect(100 as Int16 == 100)
        #expect(100 as Int32 == 100)
        #expect(100 as Int64 == 100)
        #endif
    }

    @Test func numberConversions() {
        #expect(Int(13) == 13)
        #expect(Int8(13) == Int8(13))
        #expect(Int(Int32(13)) == 13)
        #expect(Int(Int64(13)) == 13)

        #expect(Int(UInt(13)) == 13)
        #expect(Int(UInt8(13)) == 13)
        #expect(Int(UInt32(13)) == 13)
        #expect(Int(UInt64(13)) == 13)

        #expect(Double(13) == 13.0)
        #expect(Double(Float(13)) == 13.0)
        XCTAssertEqual(Double(13), 13.0, accuracy: 0.0)
        XCTAssertEqual(Double(Float(13)), 13.0, accuracy: 0.0)

        #expect(Int(Double(Float(1.3)) * 10.0) == 12)
    }

    @Test func integers() {
        let a: Int32 = 10
        let b: Int32 = 3

        // Test addition
        #expect(a + b == 13)

        // Test subtraction
        #expect(a - b == 7)

        // Test multiplication
        #expect(a * b == 30)

        // Test division
        #expect(a / b == 3)

        // Test modulo
        #expect(a % b == 1)

        // Test negation
        #expect(-a == -10)

        // Test equality
        #expect(a != b)
    }

    @Test func floatingPoint() {
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
        #expect(a != b)
    }

    @Test func unsignedIntegers() {
        let a: UInt8 = UInt8(200)
        let b: UInt8 = UInt8(50)

        #if !SKIP
        // automatic coercion to unsigned types doesn't work

        // Test addition
        #expect(a + b == 250) // java.lang.AssertionError: expected: java.lang.Integer<250> but was: kotlin.UInt<250>

        // Test subtraction
        #expect(a - b == 150)

        // Test multiplication
        //XCTAssertEqual(a * b, 10000)

        // Test division
        #expect(a / b == 4)

        // Test modulo
        #expect(a % b == 0)

        // Test overflow behavior
        #expect(!a.addingReportingOverflow(b).overflow)
        #expect(a.addingReportingOverflow(UInt8.max).overflow)

        // Test equality
        #expect(a != b)
        #endif
    }

    @Test func fixedWidthIntegers() {
        let a: Int16 = -300
        let b: Int16 = 600

        // Test addition
        #expect(a + b == 300)

        // Test subtraction
        #expect(b - a == 900)

        // Test multiplication
        //XCTAssertEqual(a * b, -180000)

        // Test division
        #expect(b / a == -2)

        // Test overflow behavior
        #if !SKIP
        #expect(!a.addingReportingOverflow(b).overflow)
        #expect(!a.addingReportingOverflow(Int16.max).overflow)
        #expect(b.addingReportingOverflow(Int16.max).overflow)
        #endif

        // Test equality
        #expect(a != b)
    }

    @Test func minMax() {
        #expect(1 == min(1, 2))
        #expect(2 == max(1, 2))

        #expect(isWholeNumber(min(1, 2)))
        #expect(!isWholeNumber(min(1.1, 2.2)))
        #expect(!isWholeNumber(min(Double(1), 2.2)))
        #if !SKIP
        #expect(!isWholeNumber(min(1, 2.2))) // inferred type is IntegerLiteralType[Int,Long,Byte,Short] but Comparable<Double> was expected
        #endif
    }

    #if SKIP
    @Test func int128Bit() {
        #expect(Int128("abc") == nil)

        let a = 100
        let sum = Int128(a) + Int128(200)
        #expect(Int128(300) == sum)

        let i = Int(sum)
        #expect(i == 300)
    }
    #endif

    @Test func equatable() {
        // Check that numbers can be used as Equatable
        #expect(isEquatable(1))
        #expect(isEquatable(1.0))
        #expect(isEqual(1, 1))
        #expect(!isEqual(1, 2))
        #expect(isEqual(1.0, 1.0))
        #expect(!isEqual(1.0, 2.0))
    }

    @Test func hashable() {
        // Check that numbers can be used as Hashable
        #expect(isHashable(1))
        #expect(isHashable(1.0))
        #expect(hashValueEqual(1, 1))
        #expect(!hashValueEqual(1, 2))
        #expect(hashValueEqual(1.0, 1.0))
        #expect(!hashValueEqual(1.0, 2.0))
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

    @Test func randomNumbers() {
        #expect(0 == Int.random(in: 0 ... 0))
        #expect(100 == Int.random(in: 100 ..< 101))

        checkRandomRange({ Int.random(in: 0 ..< 3) }, min: 0, max: 2)
        checkRandomRange({ Int.random(in: 0 ... 3) }, min: 0, max: 3)
        checkRandomRange({ Int.random(in: -100 ..< -97) }, min: -100, max: -98)
        checkRandomRange({ Int.random(in: -100 ... -97) }, min: -100, max: -97)
        checkRandomRange({ Int.random(in: -2 ..< 2) }, min: -2, max: 1)
        checkRandomRange({ Int.random(in: -2 ... 2) }, min: -2, max: 2)

        checkRandomRange({ UInt8.random(in: UInt8(0) ..< UInt8(3)) }, min: UInt8(0), max: UInt8(2))
        checkRandomRange({ Int64.random(in: Int64(0) ..< Int64(3)) }, min: Int64(0), max: Int64(2))

        var gen: RandomNumberGenerator = SystemRandomNumberGenerator()
        checkRandomRange({ Int.random(in: 0 ..< 3, using: &gen) }, min: 0, max: 2)

        for _ in 0..<10 {
            let nextDouble = Double.random(in: -2.5...2.5)
            #expect(nextDouble >= -2.5)
            #expect(nextDouble <= 2.5)

            let nextFloat = Float.random(in: Float(-2.5)...Float(2.5))
            #expect(nextFloat >= Float(-2.5))
            #expect(nextFloat <= Float(2.5))
        }
    }

    private func checkRandomRange<T>(_ generator: () -> T, min: T, max: T) where T: Equatable, T: Comparable {
        var randoms: [T] = []
        for _ in 0..<100 {
            randoms.append(generator())
        }
        #expect(randoms.min() == min)
        #expect(randoms.max() == max)
    }
}
