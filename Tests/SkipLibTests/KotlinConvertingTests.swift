// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct KotlinConvertingTests {
    @Test func customKotlinConversion() throws {
        #if SKIP
        #expect(CustomKotlinConverting().kotlin() is java.util.Date)
        #endif
    }

    @Test func arrayDeepConversion() throws {
        let a = [[1, 2], [3, 4]]
        let aa = a as Any
        #if SKIP
        let ka = a.kotlin() as! MutableList<MutableList<Int>>
        let kaa = aa.kotlin()
        let kl = listOf(listOf(1, 2), listOf(3, 4))
        #expect(ka == kl)
        #expect(kaa == kl)
        #endif
    }

    @Test func dictionaryDeepConversion() throws {
        let d = ["a": [1, 2], "b": [3, 4]]
        let da = d as Any
        #if SKIP
        let kd = d.kotlin() as! MutableMap<String, MutableList<Int>>
        let kda = da.kotlin()
        let km = mapOf(Pair("a", listOf(1, 2)), Pair("b", listOf(3, 4)))
        #expect(kd == km)
        #expect(kda == km)
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
