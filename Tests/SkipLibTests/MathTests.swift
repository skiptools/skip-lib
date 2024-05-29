// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class MathTests: XCTestCase {
    func testNaN() {
        XCTAssertTrue(Double.nan.isNaN)
        XCTAssertTrue(Float.nan.isNaN)
    }

    func testInfinity() {
        XCTAssertTrue(Double.infinity.isInfinite)
        XCTAssertTrue(Float.nan.isNaN)
    }

    func testSpecialNumbers() {
        XCTAssertEqual(Float(3.1415925), Float.pi)
        XCTAssertEqual(Double(3.141592653589793), Double.pi)
    }

    func testEulersNumbers() {
        XCTAssertEqual(2.718281828459045, M_E)
        XCTAssertEqual(1.4426950408889634, M_LOG2E)
        XCTAssertEqual(0.4342944819032518, M_LOG10E, accuracy: 1e-14)
        XCTAssertEqual(0.6931471805599453, M_LN2)
        XCTAssertEqual(2.302585092994046, M_LN10)
    }

    func testRound() {
        XCTAssertEqual(2.0, round(1.5))
        XCTAssertEqual(1.0, round(1.499))
        XCTAssertEqual(1.0, round(1.1))
        XCTAssertEqual(1.0, round(0.9))
        XCTAssertEqual(0.0, round(0.49))

        #if !SKIP
        XCTAssertEqual(1.0, round(0.49999999999999999))
        #else
        XCTAssertEqual(0.0, round(0.49999999999999999))
        #endif
    }

    func testPow() {
        XCTAssertEqual(1.0, pow(10.0, 0.0))
        XCTAssertEqual(10.0, pow(10.0, 1.0))
        XCTAssertEqual(100.0, pow(10.0, 2.0))
        XCTAssertEqual(1000.0, pow(10.0, 3.0))
    }

    func testMath() {
        XCTAssertEqual(1.5707963267948966, acos(0.0))
        XCTAssertEqual(0.0, acos(1.0))
        XCTAssertTrue(acos(2.0).isNaN)
        XCTAssertEqual(.pi, acos(-1.0))
        XCTAssertTrue(acos(Double.pi).isNaN)
        XCTAssertTrue(acos(M_E).isNaN)
        XCTAssertTrue(acos(Double.nan).isNaN)

        XCTAssertEqual(0.0, asin(0.0))
        XCTAssertEqual(1.5707963267948966, asin(1.0))
        XCTAssert(asin(2.0).isNaN)
        XCTAssertEqual(-1.5707963267948966, asin(-1.0))
        XCTAssert(asin(Double.pi).isNaN)
        XCTAssert(asin(M_E).isNaN)
        XCTAssertTrue(asin(Double.nan).isNaN)

        XCTAssertEqual(0.0, atan(0.0))
        XCTAssertEqual(0.7853981633974483, atan(1.0))
        XCTAssertEqual(1.1071487177940905, atan(2.0), accuracy: 1e-14)
        XCTAssertEqual(-0.7853981633974483, atan(-1.0))

        // Swift & Robo JVM gives: 1.2626272556789115
        // Android emulator gives: 1.2626272556789118
        XCTAssertEqual(1.2626272556789115, atan(Double.pi), accuracy: 1e-14)

        XCTAssertEqual(1.2182829050172777, atan(M_E))
        XCTAssertTrue(atan(Double.nan).isNaN)

        XCTAssertEqual(1.0, cos(0.0))
        XCTAssertEqual(0.5403023058681398, cos(1.0))
        XCTAssertEqual(-0.4161468365471424, cos(2.0))
        XCTAssertEqual(0.5403023058681398, cos(-1.0))
        XCTAssertEqual(-1.0, cos(Double.pi))
        XCTAssertEqual(-0.9117339147869651, cos(M_E))
        XCTAssertTrue(cos(Double.nan).isNaN)

        XCTAssertEqual(0.0, sin(0.0))
        XCTAssertEqual(0.8414709848078965, sin(1.0))
        XCTAssertEqual(0.9092974268256817, sin(2.0))
        XCTAssertEqual(-0.8414709848078965, sin(-1.0))
        XCTAssertEqual(1.2246467991473532e-16, sin(Double.pi))
        XCTAssertEqual(0.41078129050290885, sin(M_E), accuracy: 1e-14)
        XCTAssertTrue(sin(Double.nan).isNaN)

        XCTAssertEqual(0.0, tan(0.0))
        XCTAssertEqual(1.557407724654902, tan(1.0), accuracy: 1e-14)
        XCTAssertEqual(-2.185039863261519, tan(2.0))
        XCTAssertEqual(-1.557407724654902, tan(-1.0), accuracy: 1e-14)
        XCTAssertEqual(-1.2246467991473532e-16, tan(Double.pi))
        XCTAssertEqual(-0.45054953406980763, tan(M_E), accuracy: 1e-14)
        XCTAssertTrue(tan(Double.nan).isNaN)

        XCTAssertEqual(1.0, cosh(0.0))
        XCTAssertEqual(1.5430806348152437, cosh(1.0), accuracy: 1e-14)
        XCTAssertEqual(3.7621956910836314, cosh(2.0))
        XCTAssertEqual(1.5430806348152437, cosh(-1.0), accuracy: 1e-14)
        XCTAssertEqual(11.591953275521519, cosh(Double.pi))
        XCTAssertEqual(7.610125138662287, cosh(M_E), accuracy: 1e-14)
        XCTAssertTrue(cosh(Double.nan).isNaN)

        XCTAssertEqual(0.0, sinh(0.0))
        XCTAssertEqual(1.1752011936438014, sinh(1.0))
        XCTAssertEqual(3.6268604078470186, sinh(2.0), accuracy: 1e-14)
        XCTAssertEqual(-1.1752011936438014, sinh(-1.0))
        XCTAssertEqual(11.548739357257746, sinh(Double.pi), accuracy: 1e-14)
        XCTAssertEqual(7.544137102816975, sinh(M_E))
        XCTAssertTrue(sinh(Double.nan).isNaN)

        XCTAssertEqual(0.0, tanh(0.0))
        XCTAssertEqual(0.7615941559557649, tanh(1.0))
        XCTAssertEqual(0.9640275800758169, tanh(2.0))
        XCTAssertEqual(-0.7615941559557649, tanh(-1.0))
        XCTAssertEqual(0.99627207622075, tanh(Double.pi))
        XCTAssertEqual(0.9913289158005998, tanh(M_E))
        XCTAssertTrue(tanh(Double.nan).isNaN)
    }

    func testHypot() {
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

    func testSqrt() throws {
        XCTAssertEqual(sqrt(4.0), 2.0)
        XCTAssertEqual(sqrt(144.0), 12.0)
        XCTAssertEqual(sqrt(0.25), 0.5)
        XCTAssertEqual(sqrt(0.01), 0.1)

        XCTAssertEqual(sqrt(0.0), 0.0)
        XCTAssertTrue(sqrt(Double.nan).isNaN)
        XCTAssertEqual(sqrt(Double.infinity), Double.infinity)
    }

    func testCeil() throws {
        XCTAssertEqual(ceil(3.5), 4.0)
        XCTAssertEqual(ceil(6.2), 7.0)
        XCTAssertEqual(ceil(9.9), 10.0)
        XCTAssertEqual(ceil(4.2), 5.0)
        XCTAssertEqual(ceil(7.8), 8.0)
        XCTAssertEqual(ceil(11.3), 12.0)
        XCTAssertEqual(ceil(0.5), 1.0)
        XCTAssertEqual(ceil(1.7), 2.0)
        XCTAssertEqual(ceil(0.0), 0.0)

        XCTAssertEqual(ceil(0.0), 0.0)
        XCTAssertTrue(ceil(Double.nan).isNaN)
        XCTAssertEqual(ceil(Double.infinity), Double.infinity)
    }

    func testFloor() throws {
        XCTAssertEqual(floor(3.5), 3.0)
        XCTAssertEqual(floor(6.2), 6.0)
        XCTAssertEqual(floor(9.9), 9.0)
        XCTAssertEqual(floor(2.0), 2.0)
        XCTAssertEqual(floor(5.0), 5.0)
        XCTAssertEqual(floor(8.0), 8.0)
        XCTAssertEqual(floor(4.2), 4.0)
        XCTAssertEqual(floor(7.8), 7.0)
        XCTAssertEqual(floor(11.3), 11.0)
        XCTAssertEqual(floor(0.5), 0.0)
        XCTAssertEqual(floor(1.7), 1.0)
        XCTAssertEqual(floor(0.0), 0.0)

        XCTAssertEqual(floor(0.0), 0.0)
        XCTAssertTrue(floor(Double.nan).isNaN)
        XCTAssertEqual(floor(Double.infinity), Double.infinity)
    }

    func testWrappingOperators() throws {
        XCTAssertEqual(2, 1 &+ 1)
        XCTAssertEqual(0, 1 &- 1)
        XCTAssertEqual(12, 3 &* 4)

        XCTAssertEqual(Int8(15), Int8(Int8(5) + Int8(10)))


        XCTAssertEqual(Int8(-119), Int8(Int8.max &+ Int8(10)))

        XCTAssertEqual(Int8.min, Int8(Int8.max &+ Int8(1)))
        XCTAssertEqual(Int16.min, Int16(Int16.max &+ Int16(1)))
        XCTAssertEqual(Int32.min, Int32(Int32.max &+ Int32(1)))
        XCTAssertEqual(Int64.min, Int64(Int64.max &+ Int64(1)))

        //XCTAssertEqual(UInt8.min, UInt8(UInt8.max &+ UInt8(1)))
        XCTAssertEqual(UInt16.min, UInt16(UInt16.max &+ UInt16(1)))
        XCTAssertEqual(UInt32.min, UInt32(UInt32.max &+ UInt32(1)))
        XCTAssertEqual(UInt64.min, UInt64(UInt64.max &+ UInt64(1)))

        XCTAssertEqual(Int8.max, Int8(Int8.min &- Int8(1)))
        XCTAssertEqual(Int16.max, Int16(Int16.min &- Int16(1)))
        XCTAssertEqual(Int32.max, Int32(Int32.min &- Int32(1)))
        XCTAssertEqual(Int64.max, Int64(Int64.min &- Int64(1)))

        //XCTAssertEqual(UInt8.max, UInt8(UInt8.min &- UInt8(1)))
        XCTAssertEqual(UInt16.max, UInt16(UInt16.min &- UInt16(1)))
        XCTAssertEqual(UInt32.max, UInt32(UInt32.min &- UInt32(1)))
        XCTAssertEqual(UInt64.max, UInt64(UInt64.min &- UInt64(1)))
    }

}
