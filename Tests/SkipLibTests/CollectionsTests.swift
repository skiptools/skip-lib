// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class CollectionsTests: XCTestCase {
    func testStride() {
        var ints: [Int] = []
        for i in stride(from: 2, to: 6, by: 2) {
            ints.append(i)
        }
        XCTAssertEqual(ints, [2, 4])

        ints = []
        for i in stride(from: 6, to: 2, by: -2) {
            ints.append(i)
        }
        XCTAssertEqual(ints, [6, 4])
    }

    func testStrideThrough() {
        var ints: [Int] = []
        for i in stride(from: 2, through: 6, by: 2) {
            ints.append(i)
        }
        XCTAssertEqual(ints, [2, 4, 6])

        ints = []
        for i in stride(from: 6, through: 2, by: -2) {
            ints.append(i)
        }
        XCTAssertEqual(ints, [6, 4, 2])
    }

    func testEmptyStride() {
        for _ in stride(from: 1, to: 1, by: 1) {
            XCTFail()
        }
        for _ in stride(from: 3, to: 0, by: 1) {
            XCTFail()
        }
    }

    func testDoubleStride() {
        var doubles: [Double] = []
        for d in stride(from: 1.0, through: 2.5, by: 0.5) {
            doubles.append(d)
        }
        XCTAssertEqual(doubles, [1.0, 1.5, 2.0, 2.5])
    }

    func testMap() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.map {
            $0 + $0
        }
        XCTAssertEqual(strings2, ["AA", "ZZ", "MM"])

        let stringCounts = ["A", "AA", "AAA"].map(\.count)
        XCTAssertEqual(stringCounts, [1, 2, 3])

        let raws = [1, 2, 3].map { ElementEnum(rawValue: $0) }
        XCTAssertEqual(raws[0], .one)
        XCTAssertEqual(raws[1], .two)
        XCTAssertEqual(raws[2], .three)

        let cases = [0, 1, 2].map { ElementEnum.allCases[$0] }
        XCTAssertEqual(cases[0], .one)
        XCTAssertEqual(cases[1], .two)
        XCTAssertEqual(cases[2], .three)
    }

    func testCompactMap() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.compactMap {
            $0 == "Z" ? nil : $0 + $0
        }
        XCTAssertEqual(strings2, ["AA", "MM"])

        let raws = [1, 5, 3].compactMap { ElementEnum(rawValue: $0) }
        XCTAssertEqual(2, raws.count)
        XCTAssertEqual(raws[0], .one)
        XCTAssertEqual(raws[1], .three)
    }

    func testFlatMap() {
        let strings = [["A", "a"], ["B", "b"], ["C", "c"]]
        let strings2 = strings.flatMap { $0 }
        XCTAssertEqual(strings2, ["A", "a", "B", "b", "C", "c"])

        let enums = [1, 2].flatMap { _ in ElementEnum.allCases }
        XCTAssertEqual(enums, [.one, .two, .three, .one, .two, .three])
    }

    func testReduce() {
        let strings = ["K", "I", "P"]
        XCTAssertEqual(strings.reduce("S", { $0 + $1 }), "SKIP")
        XCTAssertEqual(strings.reduce("S", +), "SKIP")

        let dict = [1, 2, 3].reduce(into: [Int: ElementEnum]()) { result, i in
            result[i] = ElementEnum(rawValue: i)!
        }
        XCTAssertEqual(dict[1], .one)
        XCTAssertEqual(dict[2], .two)
        XCTAssertEqual(dict[3], .three)

        #if !SKIP
        XCTAssertEqual(strings.lazy.reduce("S", { $0 + $1 }), "SKIP")
        XCTAssertEqual(strings.lazy.lazy.reduce("S", { $0 + $1 }), "SKIP") // Cannot infer a type for this parameter. Please specify it explicitly.
        #endif
    }

    func testFilter() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.filter {
            $0 != "M"
        }
        XCTAssertEqual(strings2, ["A", "Z"])

        let filtered = [ElementEnum.one, ElementEnum.two, ElementEnum.three].filter { $0.rawValue % 2 == 1 }
        XCTAssertEqual(2, filtered.count)
        XCTAssertEqual(filtered[0], .one)
        XCTAssertEqual(filtered[1], .three)
    }

    func testFilterMapReduce() {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let result = numbers.filter { $0 % 2 == 0 }
                            .map { $0 * 2 }
                            .reduce(0, { $0 + $1 })
        XCTAssertEqual(result, 60)
    }

    func testZipCompactMap() {
        #if SKIP
        throw XCTSkip("testZipCompactMap")
        #else
        let names = ["Alice", "Bob", "Charlie"]
        let ages = [25, nil, 35]
        let result = zip(names, ages)
            .compactMap { (name, age) in
                age.map { "\($0) year old \($0 < 30 ? "youth" : "adult") named \(name)" }
            }
        XCTAssertEqual(result, ["25 year old youth named Alice", "35 year old adult named Charlie"])
        #endif
    }

    func testLazyFilterMap() {
        #if SKIP
        throw XCTSkip("testLazyFilterMap")
        #else
        let numbers = sequence(first: 0, next: { $0 + 1 })
        let result = numbers.lazy.filter { $0 % 2 == 0 }
                                .map { $0 * 3 }
                                .prefix(10)
        XCTAssertEqual(Array(result), [0, 6, 12, 18, 24, 30, 36, 42, 48, 54])
        #endif
    }

    func testEnumerated() {
        var enumerated: [(Int, String)] = []
        for (index, string) in ["A", "Z", "M"].enumerated() {
            enumerated.append((index, string))
        }
        XCTAssertEqual(enumerated.count, 3)
        XCTAssertEqual(enumerated[0].0, 0)
        XCTAssertEqual(enumerated[0].1, "A")
        XCTAssertEqual(enumerated[1].0, 1)
        XCTAssertEqual(enumerated[1].1, "Z")
        XCTAssertEqual(enumerated[2].0, 2)
        XCTAssertEqual(enumerated[2].1, "M")
    }

    func testSort() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.sorted()
        XCTAssertEqual(strings, ["A", "Z", "M"])
        XCTAssertEqual(strings2, ["A", "M", "Z"])

        var strings3 = strings
        strings3.sort()
        XCTAssertEqual(strings3, ["A", "M", "Z"])
    }

    func testFirstLast() {
        let strings = ["A", "Z", "M"]

        XCTAssertEqual("A", strings.first)
        XCTAssertEqual("Z", strings.first(where: { $0 == "Z" }))
        XCTAssertEqual(nil, strings.first(where: { $0 == "Q" }))

        XCTAssertEqual("M", strings.last)
        XCTAssertEqual("Z", strings.last(where: { $0 == "Z" }))
        XCTAssertEqual(nil, strings.last(where: { $0 == "Q" }))

        XCTAssertEqual(true, strings.contains(where: { $0 == "Z" }))
        XCTAssertEqual(false, strings.contains(where: { $0 == "Q" }))

        var mstrings = ["A", "Z"]
        XCTAssertEqual("A", mstrings.removeFirst())
        XCTAssertEqual(["Z"], mstrings)
        XCTAssertEqual("Z", mstrings.removeFirst())
        XCTAssertTrue(mstrings.isEmpty)

        XCTAssertEqual(["M"], strings.drop(while: { $0 == "A" || $0 == "Z" }))
        XCTAssertEqual([String](), Array(strings.drop(while: { _ in true })))

        let repeatedStrings = strings + strings
        XCTAssertEqual(repeatedStrings.lastIndex(of: "Z"), 4)
        XCTAssertNil(repeatedStrings.lastIndex(of: "Q"))

        XCTAssertEqual(repeatedStrings.lastIndex(where: { $0 == "Z" }), 4)
        XCTAssertNil(repeatedStrings.lastIndex(of: "Q"))
    }

    func testPrefixSuffix() {
        let arr = [1, 2, 3]
        XCTAssertEqual([Int](), arr.suffix(0))
        XCTAssertEqual([3], arr.suffix(1))
        XCTAssertEqual([2, 3], arr.suffix(2))
        XCTAssertEqual([1, 2, 3], arr.suffix(4))

        XCTAssertEqual([1], arr.prefix(1))
        XCTAssertEqual([1, 2], arr.prefix(2))
        XCTAssertEqual([1, 2, 3], arr.prefix(4))

        XCTAssertEqual([1, 2], arr.prefix(while: { $0 != 3 }))
        XCTAssertEqual([Int](), arr.prefix(while: { _ in false }))

        XCTAssertEqual([3], arr.suffix(from: 2))
        XCTAssertEqual([1, 2, 3], arr.suffix(from: 0))
    }

    func testElementsEqual() {
        let arr = [1, 2, 3]
        XCTAssertTrue(arr.elementsEqual([1, 2, 3]))
        XCTAssertFalse(arr.elementsEqual([1, 2]))
        XCTAssertTrue(arr.elementsEqual([1, 2, 3], by: { $0 == $1 }))
        XCTAssertFalse(arr.elementsEqual([1, 2, 3], by: { $0 != $1 }))
    }

    func testReadSlice() {
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        func copy<T: Collection<Int>>(_ c: T) -> [Int] {
            var a: [Int] = []
            for i in c {
                a.append(i)
            }
            return a
        }

        let closedSlice = numbers[1...3]
        XCTAssertEqual(Array(closedSlice), [1, 2, 3])
        XCTAssertEqual(copy(closedSlice), [1, 2, 3])

        XCTAssertEqual(3, closedSlice.count)
        XCTAssertEqual(closedSlice[1], 1)
        XCTAssertEqual(closedSlice[2], 2)
        XCTAssertEqual(closedSlice[3], 3)

        let openUpperSlice = numbers[7...]
        let openUpperSliceCopy = Array(openUpperSlice)
        XCTAssertEqual(openUpperSliceCopy, [7, 8, 9])

        XCTAssertEqual(3, openUpperSlice.count)
        XCTAssertEqual(openUpperSlice[7], 7)
        XCTAssertEqual(openUpperSlice[8], 8)
        XCTAssertEqual(openUpperSlice[9], 9)

        let openLowerSlice = numbers[..<3]
        let openLowerSliceCopy = Array(openLowerSlice)
        XCTAssertEqual(openLowerSliceCopy, [0, 1, 2])

        XCTAssertEqual(3, openLowerSlice.count)
        XCTAssertEqual(openLowerSlice[0], 0)
        XCTAssertEqual(openLowerSlice[1], 1)
        XCTAssertEqual(openLowerSlice[2], 2)

        // Check that mutating the source does not affect the slice
        numbers.append(10)
        XCTAssertEqual(3, openUpperSlice.count)

        let enums: [ElementEnum] = [.one, .two, .three]
        let enumSlice = enums[1...]
        XCTAssertEqual(enumSlice[1], .two)
    }

    func testWriteSlice() {
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[1..<5] = []
        XCTAssertEqual(numbers, [0, 5, 6, 7, 8, 9])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[1..<5] = [99, 100]
        XCTAssertEqual(numbers, [0, 99, 100, 5, 6, 7, 8, 9])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[5...] = [99, 100]
        XCTAssertEqual(numbers, [0, 1, 2, 3, 4, 99, 100])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[..<5] = [99, 100]
        XCTAssertEqual(numbers, [99, 100, 5, 6, 7, 8, 9])
    }

    func testDictionaryForEach() {
        let dictionary = ["apple": 3, "banana": 5, "cherry": 2]
        var count = 0
        dictionary.forEach { count += $0.value }
        XCTAssertEqual(count, 10)
    }

    func testJoin() {
        let iarr: [[ElementEnum]] = [[.one, .two], [.three]]
        let ijoined = iarr.joined()
        XCTAssertEqual(Array(ijoined), [.one, .two, .three])

        // Skip is unable to determine the owning types of the elements
        //let ijoined2 = iarr.joined(separator: [ElementEnum.one, ElementEnum.two])
        let ijoined2 = iarr.joined(separator: [ElementEnum.one, ElementEnum.two])
        XCTAssertEqual(Array(ijoined2), [.one, .two, .one, .two, .three])

        let sarr = ["ab", "cde", "fg"]
        let sjoined = sarr.joined()
        XCTAssertEqual(sjoined, "abcdefg")

        let sjoined2 = sarr.joined(separator: "++")
        XCTAssertEqual(sjoined2, "ab++cde++fg")
    }

    func testIndices() {
        let arr = ["0", "1", "2", "3"]
        let idxs = arr.indices.reversed()
        XCTAssertEqual(Array(idxs), [3, 2, 1, 0])
    }

    func testRandomElement() {
        let empty: [Int] = []
        XCTAssertNil(empty.randomElement())

        let arr = [100, 101, 102, 103, 104]
        var seen: Set<Int> = []
        for _ in 0..<100 {
            seen.insert(arr.randomElement()!)
        }
        XCTAssertEqual(seen.count, 5)
        XCTAssertTrue(seen.contains(100))
        XCTAssertTrue(seen.contains(104))
    }

    func testShuffle() {
        let empty: [Int] = []
        XCTAssertEqual(empty, empty.shuffled())
        XCTAssertEqual([1], [1].shuffled())

        let arr = [100, 101, 102, 103, 104, 105, 106, 107, 108, 109]
        let shuffled = arr.shuffled()
        XCTAssertNotEqual(arr, shuffled)
        XCTAssertEqual(Set(arr), Set(shuffled))

        var gen: RandomNumberGenerator = SystemRandomNumberGenerator()
        let shuffled2 = arr.shuffled(using: &gen)
        XCTAssertNotEqual(arr, shuffled2)
        XCTAssertEqual(Set(arr), Set(shuffled2))

        var arr2 = arr
        arr2.shuffle()
        XCTAssertNotEqual(arr, arr2)
        XCTAssertEqual(Set(arr), Set(arr2))
    }

    func testZip() {
        let arr1 = [1, 3, 5]
        let arr2 = [0, 2, 4, 6]
        let zipped = zip(arr1, arr2)
        let expected = [(1, 0), (3, 2), (5, 4)]
        var i = 0
        for (a1, a2) in zipped {
            XCTAssertEqual(a1, expected[i].0)
            XCTAssertEqual(a2, expected[i].1)
            i += 1
        }
    }

    func testRemoveLast() {
        var arr = [1, 3, 5]
        XCTAssertEqual(5, arr.removeLast())
        XCTAssertEqual(3, arr.removeLast())
        XCTAssertEqual([1], arr)
        XCTAssertEqual(1, arr.popLast())
        XCTAssertEqual(nil, arr.popLast())
        XCTAssertEqual(0, arr.count)
        XCTAssertTrue(arr.isEmpty)
    }
}

private enum ElementEnum: Int, CaseIterable {
    case one = 1
    case two
    case three
}
