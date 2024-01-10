// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class KotlinConvertingTests: XCTestCase {
    func testCustomKotlinConversion() throws {
        #if SKIP
        XCTAssertTrue(CustomKotlinConverting().kotlin() is java.util.Date)
        #endif
    }

    func testArrayDeepConversion() throws {
        let a = [[1, 2], [3, 4]]
        let aa = a as Any
        #if SKIP
        let ka = a.kotlin() as! MutableList<MutableList<Int>>
        let kaa = aa.kotlin()
        let kl = listOf(listOf(1, 2), listOf(3, 4))
        XCTAssertEqual(ka, kl)
        XCTAssertEqual(kaa, kl)
        #endif
    }

    func testDictionaryDeepConversion() throws {
        let d = ["a": [1, 2], "b": [3, 4]]
        let da = d as Any
        #if SKIP
        let kd = d.kotlin() as! MutableMap<String, MutableList<Int>>
        let kda = da.kotlin()
        let km = mapOf(Pair("a", listOf(1, 2)), Pair("b", listOf(3, 4)))
        XCTAssertEqual(kd, km)
        XCTAssertEqual(kda, km)
        #endif
    }
}

struct CustomKotlinConverting {
}

#if SKIP
extension CustomKotlinConverting: KotlinConverting<java.util.Date> {
    override func kotlin(nocopy: Bool = false) -> java.util.Date {
        return java.util.Date()
    }
}
#endif
