// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing
import XCTest

@Suite struct MathTests {
    @Test func nan() {
        #expect(Double.nan.isNaN)
        #expect(Float.nan.isNaN)
    }

    @Test func infinity() {
        #expect(Double.infinity.isInfinite)
        #expect(Float.nan.isNaN)
    }

    @Test func specialNumbers() {
        #expect(Float(3.1415925) == Float.pi)
        #expect(Double(3.141592653589793) == Double.pi)
    }

    @Test func eulersNumbers() {
        #expect(2.718281828459045 == M_E)
        #expect(1.4426950408889634 == M_LOG2E)
        XCTAssertEqual(0.4342944819032518, M_LOG10E, accuracy: 1e-14)
        #expect(0.6931471805599453 == M_LN2)
        #expect(2.302585092994046 == M_LN10)
    }

    @Test func roundTest() {
        #expect(2.0 == round(1.5))
        #expect(1.0 == round(1.499))
        #expect(1.0 == round(1.1))
        #expect(1.0 == round(0.9))
        #expect(0.0 == round(0.49))

        #if !SKIP
        #expect(1.0 == round(0.49999999999999999))
        #else
        #expect(0.0 == round(0.49999999999999999))
        #endif
    }

    @Test func powTest() {
        #expect(1.0 == pow(10.0, 0.0))
        #expect(10.0 == pow(10.0, 1.0))
        #expect(100.0 == pow(10.0, 2.0))
        #expect(1000.0 == pow(10.0, 3.0))
    }

    @Test func math() {
        #expect(1.5707963267948966 == acos(0.0))
        #expect(0.0 == acos(1.0))
        #expect(acos(2.0).isNaN)
        #expect(.pi == acos(-1.0))
        #expect(acos(Double.pi).isNaN)
        #expect(acos(M_E).isNaN)
        #expect(acos(Double.nan).isNaN)

        #expect(0.0 == asin(0.0))
        #expect(1.5707963267948966 == asin(1.0))
        #expect(asin(2.0).isNaN)
        #expect(-1.5707963267948966 == asin(-1.0))
        #expect(asin(Double.pi).isNaN)
        #expect(asin(M_E).isNaN)
        #expect(asin(Double.nan).isNaN)

        #expect(0.0 == atan(0.0))
        #expect(0.7853981633974483 == atan(1.0))
        XCTAssertEqual(1.1071487177940905, atan(2.0), accuracy: 1e-14)
        #expect(-0.7853981633974483 == atan(-1.0))

        // Swift & Robo JVM gives: 1.2626272556789115
        // Android emulator gives: 1.2626272556789118
        XCTAssertEqual(1.2626272556789115, atan(Double.pi), accuracy: 1e-14)

        #expect(1.2182829050172777 == atan(M_E))
        #expect(atan(Double.nan).isNaN)

        #expect(1.0 == cos(0.0))
        #expect(0.5403023058681398 == cos(1.0))
        #expect(-0.4161468365471424 == cos(2.0))
        #expect(0.5403023058681398 == cos(-1.0))
        #expect(-1.0 == cos(Double.pi))
        #expect(-0.9117339147869651 == cos(M_E))
        #expect(cos(Double.nan).isNaN)

        #expect(0.0 == sin(0.0))
        #expect(0.8414709848078965 == sin(1.0))
        #expect(0.9092974268256817 == sin(2.0))
        #expect(-0.8414709848078965 == sin(-1.0))
        #expect(1.2246467991473532e-16 == sin(Double.pi))
        XCTAssertEqual(0.41078129050290885, sin(M_E), accuracy: 1e-14)
        #expect(sin(Double.nan).isNaN)

        #expect(0.0 == tan(0.0))
        XCTAssertEqual(1.557407724654902, tan(1.0), accuracy: 1e-14)
        #expect(-2.185039863261519 == tan(2.0))
        XCTAssertEqual(-1.557407724654902, tan(-1.0), accuracy: 1e-14)
        #expect(-1.2246467991473532e-16 == tan(Double.pi))
        XCTAssertEqual(-0.45054953406980763, tan(M_E), accuracy: 1e-14)
        #expect(tan(Double.nan).isNaN)

        #expect(1.0 == cosh(0.0))
        XCTAssertEqual(1.5430806348152437, cosh(1.0), accuracy: 1e-14)
        #expect(3.7621956910836314 == cosh(2.0))
        XCTAssertEqual(1.5430806348152437, cosh(-1.0), accuracy: 1e-14)
        #expect(11.591953275521519 == cosh(Double.pi))
        XCTAssertEqual(7.610125138662287, cosh(M_E), accuracy: 1e-14)
        #expect(cosh(Double.nan).isNaN)

        #expect(0.0 == sinh(0.0))
        #expect(1.1752011936438014 == sinh(1.0))
        XCTAssertEqual(3.6268604078470186, sinh(2.0), accuracy: 1e-14)
        #expect(-1.1752011936438014 == sinh(-1.0))
        XCTAssertEqual(11.548739357257746, sinh(Double.pi), accuracy: 1e-14)
        #expect(7.544137102816975 == sinh(M_E))
        #expect(sinh(Double.nan).isNaN)

        #expect(0.0 == tanh(0.0))
        #expect(0.7615941559557649 == tanh(1.0))
        #expect(0.9640275800758169 == tanh(2.0))
        #expect(-0.7615941559557649 == tanh(-1.0))
        #expect(0.99627207622075 == tanh(Double.pi))
        #expect(0.9913289158005998 == tanh(M_E))
        #expect(tanh(Double.nan).isNaN)
    }

    @Test func hypotTest() {
        XCTAssertEqual(hypot(3.0, 4.0), 5.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(5.0, 12.0), 13.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(8.0, 15.0), 17.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(7.0, 24.0), 25.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(9.0, 40.0), 41.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(6.0, 8.0), 10.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(12.0, 16.0), 20.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(15.0, 20.0), 25.0, accuracy: 1e-10)
        XCTAssertEqual(hypot(7.5, 9.0), 11.71537451385, accuracy: 1e-10)
        XCTAssertEqual(hypot(2.0, 2.0), 2.8284271247461903, accuracy: 1e-10)
        XCTAssertEqual(hypot(10.5, 3.0), 10.920164833920778, accuracy: 1e-10)
        XCTAssertEqual(hypot(1.0, 0.0), 1.0, accuracy: 1e-10)
    }

    @Test func sqrtTest() throws {
        #expect(sqrt(4.0) == 2.0)
        #expect(sqrt(144.0) == 12.0)
        #expect(sqrt(0.25) == 0.5)
        #expect(sqrt(0.01) == 0.1)

        #expect(sqrt(0.0) == 0.0)
        #expect(sqrt(Double.nan).isNaN)
        #expect(sqrt(Double.infinity) == Double.infinity)
    }

    @Test func ceilTest() throws {
        #expect(ceil(3.5) == 4.0)
        #expect(ceil(6.2) == 7.0)
        #expect(ceil(9.9) == 10.0)
        #expect(ceil(4.2) == 5.0)
        #expect(ceil(7.8) == 8.0)
        #expect(ceil(11.3) == 12.0)
        #expect(ceil(0.5) == 1.0)
        #expect(ceil(1.7) == 2.0)
        #expect(ceil(0.0) == 0.0)

        #expect(ceil(0.0) == 0.0)
        #expect(ceil(Double.nan).isNaN)
        #expect(ceil(Double.infinity) == Double.infinity)
    }

    @Test func floorTest() throws {
        #expect(floor(3.5) == 3.0)
        #expect(floor(6.2) == 6.0)
        #expect(floor(9.9) == 9.0)
        #expect(floor(2.0) == 2.0)
        #expect(floor(5.0) == 5.0)
        #expect(floor(8.0) == 8.0)
        #expect(floor(4.2) == 4.0)
        #expect(floor(7.8) == 7.0)
        #expect(floor(11.3) == 11.0)
        #expect(floor(0.5) == 0.0)
        #expect(floor(1.7) == 1.0)
        #expect(floor(0.0) == 0.0)

        #expect(floor(0.0) == 0.0)
        #expect(floor(Double.nan).isNaN)
        #expect(floor(Double.infinity) == Double.infinity)
    }

    @Test func wrappingOperators() throws {
        #expect(2 == 1 &+ 1)
        #expect(0 == 1 &- 1)
        #expect(12 == 3 &* 4)

        #expect(Int8(15) == Int8(Int8(5) + Int8(10)))


        #expect(Int8(-119) == Int8(Int8.max &+ Int8(10)))

        #expect(Int8.min == Int8(Int8.max &+ Int8(1)))
        #expect(Int16.min == Int16(Int16.max &+ Int16(1)))
        #expect(Int32.min == Int32(Int32.max &+ Int32(1)))
        #expect(Int64.min == Int64(Int64.max &+ Int64(1)))

        //XCTAssertEqual(UInt8.min, UInt8(UInt8.max &+ UInt8(1)))
        #expect(UInt16.min == UInt16(UInt16.max &+ UInt16(1)))
        #expect(UInt32.min == UInt32(UInt32.max &+ UInt32(1)))
        #expect(UInt64.min == UInt64(UInt64.max &+ UInt64(1)))

        #expect(Int8.max == Int8(Int8.min &- Int8(1)))
        #expect(Int16.max == Int16(Int16.min &- Int16(1)))
        #expect(Int32.max == Int32(Int32.min &- Int32(1)))
        #expect(Int64.max == Int64(Int64.min &- Int64(1)))

        //XCTAssertEqual(UInt8.max, UInt8(UInt8.min &- UInt8(1)))
        #expect(UInt16.max == UInt16(UInt16.min &- UInt16(1)))
        #expect(UInt32.max == UInt32(UInt32.min &- UInt32(1)))
        #expect(UInt64.max == UInt64(UInt64.min &- UInt64(1)))
    }

}
