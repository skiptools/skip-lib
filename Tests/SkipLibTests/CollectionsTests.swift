// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct CollectionsTests {
    @Test func stride() {
        var ints: [Int] = []
        for i in Swift.stride(from: 2, to: 6, by: 2) {
            ints.append(i)
        }
        #expect(ints == [2, 4])

        ints = []
        for i in Swift.stride(from: 6, to: 2, by: -2) {
            ints.append(i)
        }
        #expect(ints == [6, 4])
    }

    @Test func strideThrough() {
        var ints: [Int] = []
        for i in Swift.stride(from: 2, through: 6, by: 2) {
            ints.append(i)
        }
        #expect(ints == [2, 4, 6])

        ints = []
        for i in Swift.stride(from: 6, through: 2, by: -2) {
            ints.append(i)
        }
        #expect(ints == [6, 4, 2])
    }

    @Test func emptyStride() {
        for _ in Swift.stride(from: 1, to: 1, by: 1) {
            #expect(!(!false))
        }
        for _ in Swift.stride(from: 3, to: 0, by: 1) {
            #expect(!(!false))
        }
    }

    @Test func doubleStride() {
        var doubles: [Double] = []
        for d in Swift.stride(from: 1.0, through: 2.5, by: 0.5) {
            doubles.append(d)
        }
        #expect(doubles == [1.0, 1.5, 2.0, 2.5])
    }

    @Test func map() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.map {
            $0 + $0
        }
        #expect(strings2 == ["AA", "ZZ", "MM"])

        let stringCounts = ["A", "AA", "AAA"].map(\.count)
        #expect(stringCounts == [1, 2, 3])

        let raws = [1, 2, 3].map { ElementEnum(rawValue: $0) }
        #expect(raws[0] == .one)
        #expect(raws[1] == .two)
        #expect(raws[2] == .three)

        let cases = [0, 1, 2].map { ElementEnum.allCases[$0] }
        #expect(cases[0] == .one)
        #expect(cases[1] == .two)
        #expect(cases[2] == .three)
    }

    @Test func compactMap() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.compactMap {
            $0 == "Z" ? nil : $0 + $0
        }
        #expect(strings2 == ["AA", "MM"])

        let raws = [1, 5, 3].compactMap { ElementEnum(rawValue: $0) }
        #expect(2 == raws.count)
        #expect(raws[0] == .one)
        #expect(raws[1] == .three)
    }

    @Test func flatMap() {
        let strings = [["A", "a"], ["B", "b"], ["C", "c"]]
        let strings2 = strings.flatMap { $0 }
        #expect(strings2 == ["A", "a", "B", "b", "C", "c"])

        let enums = [1, 2].flatMap { _ in ElementEnum.allCases }
        #expect(enums == [.one, .two, .three, .one, .two, .three])
    }

    @Test func reduce() {
        let strings = ["K", "I", "P"]
        #expect(strings.reduce("S", { $0 + $1 }) == "SKIP")
        #expect(strings.reduce("S", +) == "SKIP")

        let dict = [1, 2, 3].reduce(into: [Int: ElementEnum]()) { result, i in
            result[i] = ElementEnum(rawValue: i)!
        }
        #expect(dict[1] == .one)
        #expect(dict[2] == .two)
        #expect(dict[3] == .three)

        #if !SKIP
        #expect(strings.lazy.reduce("S", { $0 + $1 }) == "SKIP")
        #expect(strings.lazy.lazy.reduce("S", { $0 + $1 }) == "SKIP") // Cannot infer a type for this parameter. Please specify it explicitly.
        #endif
    }

    @Test func filter() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.filter {
            $0 != "M"
        }
        #expect(strings2 == ["A", "Z"])

        let filtered = [ElementEnum.one, ElementEnum.two, ElementEnum.three].filter { $0.rawValue % 2 == 1 }
        #expect(2 == filtered.count)
        #expect(filtered[0] == .one)
        #expect(filtered[1] == .three)
    }

    @Test func filterMapReduce() {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let result = numbers.filter { $0 % 2 == 0 }
                            .map { $0 * 2 }
                            .reduce(0, { $0 + $1 })
        #expect(result == 60)
    }

    @Test func zipCompactMap() {
        #if SKIP
        // skip: testZipCompactMap
        return
        #else
        let names = ["Alice", "Bob", "Charlie"]
        let ages = [25, nil, 35]
        let result = Swift.zip(names, ages)
            .compactMap { (name, age) in
                age.map { "\($0) year old \($0 < 30 ? "youth" : "adult") named \(name)" }
            }
        #expect(result == ["25 year old youth named Alice", "35 year old adult named Charlie"])
        #endif
    }

    @Test func lazyFilterMap() {
        #if SKIP
        // skip: testLazyFilterMap
        return
        #else
        let numbers = sequence(first: 0, next: { $0 + 1 })
        let result = numbers.lazy.filter { $0 % 2 == 0 }
                                .map { $0 * 3 }
                                .prefix(10)
        #expect(Array(result) == [0, 6, 12, 18, 24, 30, 36, 42, 48, 54])
        #endif
    }

    @Test func enumerated() {
        var enumerated: [(Int, String)] = []
        for (index, string) in ["A", "Z", "M"].enumerated() {
            enumerated.append((index, string))
        }
        #expect(enumerated.count == 3)
        #expect(enumerated[0].0 == 0)
        #expect(enumerated[0].1 == "A")
        #expect(enumerated[1].0 == 1)
        #expect(enumerated[1].1 == "Z")
        #expect(enumerated[2].0 == 2)
        #expect(enumerated[2].1 == "M")
    }

    @Test func sort() {
        let strings = ["A", "Z", "M"]
        let strings2 = strings.sorted()
        #expect(strings == ["A", "Z", "M"])
        #expect(strings2 == ["A", "M", "Z"])

        var strings3 = strings
        strings3.sort()
        #expect(strings3 == ["A", "M", "Z"])
    }

    @Test func firstLast() {
        let strings = ["A", "Z", "M"]

        #expect("A" == strings.first)
        #expect("Z" == strings.first(where: { $0 == "Z" }))
        #expect(nil == strings.first(where: { $0 == "Q" }))

        #expect("M" == strings.last)
        #expect("Z" == strings.last(where: { $0 == "Z" }))
        #expect(nil == strings.last(where: { $0 == "Q" }))

        #expect(true == strings.contains(where: { $0 == "Z" }))
        #expect(false == strings.contains(where: { $0 == "Q" }))

        var mstrings = ["A", "Z"]
        #expect("A" == mstrings.removeFirst())
        #expect(["Z"] == mstrings)
        #expect("Z" == mstrings.removeFirst())
        #expect(mstrings.isEmpty)

        #expect(["M"] == strings.drop(while: { $0 == "A" || $0 == "Z" }))
        #expect([String]() == Array(strings.drop(while: { _ in true })))

        let repeatedStrings = strings + strings
        #expect(repeatedStrings.lastIndex(of: "Z") == 4)
        #expect(repeatedStrings.lastIndex(of: "Q") == nil)

        #expect(repeatedStrings.lastIndex(where: { $0 == "Z" }) == 4)
        #expect(repeatedStrings.lastIndex(of: "Q") == nil)
    }

    @Test func prefixSuffix() {
        let arr = [1, 2, 3]
        #expect([Int]() == arr.suffix(0))
        #expect([3] == arr.suffix(1))
        #expect([2, 3] == arr.suffix(2))
        #expect([1, 2, 3] == arr.suffix(4))

        #expect([1] == arr.prefix(1))
        #expect([1, 2] == arr.prefix(2))
        #expect([1, 2, 3] == arr.prefix(4))

        #expect([1, 2] == arr.prefix(while: { $0 != 3 }))
        #expect([Int]() == arr.prefix(while: { _ in false }))

        #expect([3] == arr.suffix(from: 2))
        #expect([1, 2, 3] == arr.suffix(from: 0))
    }

    @Test func elementsEqual() {
        let arr = [1, 2, 3]
        #expect(arr.elementsEqual([1, 2, 3]))
        #expect(!arr.elementsEqual([1, 2]))
        #expect(arr.elementsEqual([1, 2, 3], by: { $0 == $1 }))
        #expect(!arr.elementsEqual([1, 2, 3], by: { $0 != $1 }))
    }

    @Test func readSlice() {
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        func copy<T: Collection<Int>>(_ c: T) -> [Int] {
            var a: [Int] = []
            for i in c {
                a.append(i)
            }
            return a
        }

        let closedSlice = numbers[1...3]
        #expect(Array(closedSlice) == [1, 2, 3])
        #expect(copy(closedSlice) == [1, 2, 3])

        #expect(3 == closedSlice.count)
        #expect(closedSlice[1] == 1)
        #expect(closedSlice[2] == 2)
        #expect(closedSlice[3] == 3)

        let openUpperSlice = numbers[7...]
        let openUpperSliceCopy = Array(openUpperSlice)
        #expect(openUpperSliceCopy == [7, 8, 9])

        #expect(3 == openUpperSlice.count)
        #expect(openUpperSlice[7] == 7)
        #expect(openUpperSlice[8] == 8)
        #expect(openUpperSlice[9] == 9)

        let openLowerSlice = numbers[..<3]
        let openLowerSliceCopy = Array(openLowerSlice)
        #expect(openLowerSliceCopy == [0, 1, 2])

        #expect(3 == openLowerSlice.count)
        #expect(openLowerSlice[0] == 0)
        #expect(openLowerSlice[1] == 1)
        #expect(openLowerSlice[2] == 2)

        // Check that mutating the source does not affect the slice
        numbers.append(10)
        #expect(3 == openUpperSlice.count)

        let enums: [ElementEnum] = [.one, .two, .three]
        let enumSlice = enums[1...]
        #expect(enumSlice[1] == .two)
    }

    @Test func writeSlice() {
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[1..<5] = []
        #expect(numbers == [0, 5, 6, 7, 8, 9])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[1..<5] = [99, 100]
        #expect(numbers == [0, 99, 100, 5, 6, 7, 8, 9])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[5...] = [99, 100]
        #expect(numbers == [0, 1, 2, 3, 4, 99, 100])

        numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers[..<5] = [99, 100]
        #expect(numbers == [99, 100, 5, 6, 7, 8, 9])
    }

    @Test func dictionaryForEach() {
        let dictionary = ["apple": 3, "banana": 5, "cherry": 2]
        var count = 0
        dictionary.forEach { count += $0.value }
        #expect(count == 10)
    }

    @Test func join() {
        let iarr: [[ElementEnum]] = [[.one, .two], [.three]]
        let ijoined = iarr.joined()
        #expect(Array(ijoined) == [.one, .two, .three])

        // Skip is unable to determine the owning types of the elements
        //let ijoined2 = iarr.joined(separator: [ElementEnum.one, ElementEnum.two])
        let ijoined2 = iarr.joined(separator: [ElementEnum.one, ElementEnum.two])
        #expect(Array(ijoined2) == [.one, .two, .one, .two, .three])

        let sarr = ["ab", "cde", "fg"]
        let sjoined = sarr.joined()
        #expect(sjoined == "abcdefg")

        let sjoined2 = sarr.joined(separator: "++")
        #expect(sjoined2 == "ab++cde++fg")
    }

    @Test func indices() {
        let arr = ["0", "1", "2", "3"]
        let idxs = arr.indices.reversed()
        #expect(Array(idxs) == [3, 2, 1, 0])
    }

    @Test func randomElement() {
        let empty: [Int] = []
        #expect(empty.randomElement() == nil)

        let arr = [100, 101, 102, 103, 104]
        var seen: Set<Int> = []
        for _ in 0..<100 {
            seen.insert(arr.randomElement()!)
        }
        #expect(seen.count == 5)
        #expect(seen.contains(100))
        #expect(seen.contains(104))
    }

    @Test func shuffle() {
        let empty: [Int] = []
        #expect(empty == empty.shuffled())
        #expect([1] == [1].shuffled())

        let arr = [100, 101, 102, 103, 104, 105, 106, 107, 108, 109]
        let shuffled = arr.shuffled()
        #expect(arr != shuffled)
        #expect(Set(arr) == Set(shuffled))

        var gen: RandomNumberGenerator = SystemRandomNumberGenerator()
        let shuffled2 = arr.shuffled(using: &gen)
        #expect(arr != shuffled2)
        #expect(Set(arr) == Set(shuffled2))

        var arr2 = arr
        arr2.shuffle()
        #expect(arr != arr2)
        #expect(Set(arr) == Set(arr2))
    }

    @Test func zip() {
        let arr1 = [1, 3, 5]
        let arr2 = [0, 2, 4, 6]
        let zipped = Swift.zip(arr1, arr2)
        let expected = [(1, 0), (3, 2), (5, 4)]
        var i = 0
        for (a1, a2) in zipped {
            #expect(a1 == expected[i].0)
            #expect(a2 == expected[i].1)
            i += 1
        }
    }

    @Test func removeLast() {
        var arr = [1, 3, 5]
        #expect(5 == arr.removeLast())
        #expect(3 == arr.removeLast())
        #expect([1] == arr)
        #expect(1 == arr.popLast())
        #expect(nil == arr.popLast())
        #expect(0 == arr.count)
        #expect(arr.isEmpty)
    }

    @Test func reserveCapacity() {
        var arr = [1, 3, 5]
        arr.reserveCapacity(100)
    }

    @Test func ranges() {
        let rangeExclusiveInt = 1..<3
        #expect(rangeExclusiveInt.lowerBound == 1)
        #expect(rangeExclusiveInt.upperBound == 3)

        let rangeInclusiveInt = 1...3
        #expect(rangeInclusiveInt.lowerBound == 1)
        // #expect(rangeInclusiveInt.upperBound == 3) // java.lang.AssertionError: 4 != 3 // https://github.com/skiptools/skip-lib/issues/30

        let rangeExclusiveInt16 = Int16(1)..<Int16(3)
        #expect(rangeExclusiveInt16.lowerBound == 1)
        #expect(rangeExclusiveInt16.upperBound == 3)

        let rangeExclusiveInt64 = Int64(1)..<Int64(3)
        #expect(rangeExclusiveInt64.lowerBound == 1)
        #expect(rangeExclusiveInt64.upperBound == 3)

        let rangeExclusiveUInt64 = UInt64(1)..<UInt64(3)
        #expect(rangeExclusiveUInt64.lowerBound == UInt64(1))
        #expect(rangeExclusiveUInt64.upperBound == UInt64(3))

        let rangeExclusiveUInt = UInt(1)..<UInt(3)
        #expect(rangeExclusiveUInt.lowerBound == UInt(1))
        #expect(rangeExclusiveUInt.upperBound == UInt(3))
    }
}

private enum ElementEnum: Int, CaseIterable {
    case one = 1
    case two
    case three
}
