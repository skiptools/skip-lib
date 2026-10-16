// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct DictionaryTests {
    @Test func dictionaryLiteralInit() {
        let emptyDictionary: [String: Int] = [:]
        #expect(emptyDictionary.count == 0)

        let emptyDictionary2: Dictionary<String, Int> = [:]
        #expect(emptyDictionary2.count == 0)

        let emptyDictionary3 = [String: Int]()
        #expect(emptyDictionary3.count == 0)

        let emptyDictionary4 = Dictionary<String, Int>()
        #expect(emptyDictionary4.count == 0)

        let singleElementDictionary = ["a": 1]
        #expect(singleElementDictionary.count == 1)
        #expect(singleElementDictionary["a"] == 1)

        let multipleElementDictionary = ["a": 1, "b": 2]
        #expect(multipleElementDictionary.count == 2)
        #expect(multipleElementDictionary["a"] == 1)
        #expect(multipleElementDictionary["b"] == 2)
    }

    @Test func uniquingKeysInitCombinesInSequenceOrder() {
        let pairs = [("a", 1), ("b", 2), ("a", 3), ("a", 4)]
        var combinedValues: [Int] = []

        let result = Dictionary(pairs, uniquingKeysWith: { old, new in
            combinedValues.append(old)
            combinedValues.append(new)
            return old * 10 + new
        })

        #expect(result == ["a": 134, "b": 2])
        #expect(combinedValues == [1, 3, 13, 4])
    }

    @Test func uniquingKeysInitCanKeepFirstOrLastValue() {
        let pairs = [("a", 1), ("b", 2), ("a", 3)]

        let first = Dictionary(pairs, uniquingKeysWith: { old, _ in old })
        let last = Dictionary(pairs, uniquingKeysWith: { _, new in new })

        #expect(first == ["a": 1, "b": 2])
        #expect(last == ["a": 3, "b": 2])
    }

    @Test func uniquingKeysInitPreservesNilValues() {
        let pairs: [(String, Int?)] = [("a", nil), ("a", 1), ("a", nil), ("b", nil)]
        var combinations = 0
        var sawInitialNil = false

        let result = Dictionary(pairs, uniquingKeysWith: { old, new in
            if combinations == 0 {
                sawInitialNil = old == nil
            }
            combinations += 1
            return new
        })

        #expect(combinations == 2)
        #expect(sawInitialNil)
        #expect(result.count == 2)
        #expect(result.keys.contains("a"))
        #expect(result.keys.contains("b"))
        #expect(result.values.allSatisfy { $0 == nil })
    }

    @Test func uniquingKeysInitDoesNotCombineUniqueOrEmptyInput() {
        let pairs = [("a", 1), ("b", 2)]
        let emptyPairs: [(String, Int)] = []
        var combinations = 0
        let combine: (Int, Int) -> Int = { _, new in
            combinations += 1
            return new
        }

        let result = Dictionary(pairs, uniquingKeysWith: combine)
        let empty = Dictionary(emptyPairs, uniquingKeysWith: combine)

        #expect(result == ["a": 1, "b": 2])
        #expect(empty.isEmpty)
        #expect(combinations == 0)
    }

    @Test func uniquingKeysInitPropagatesCombinerError() {
        let pairs = [("a", 1), ("a", 2), ("a", 3)]
        var combinations = 0
        var caughtExpectedError = false
        let combine: (Int, Int) throws -> Int = { _, _ in
            combinations += 1
            throw CombinationError.failed
        }

        do {
            _ = try Dictionary(pairs, uniquingKeysWith: combine)
        } catch {
            caughtExpectedError = error is CombinationError
        }

        #expect(caughtExpectedError)
        #expect(combinations == 1)
    }

    @Test func uniquingKeysInitPreservesValueSemantics() {
        var original = [1]
        let pairs = [("a", original), ("a", [2])]
        var combined: [Int] = []

        var result = Dictionary(pairs, uniquingKeysWith: { old, new in
            combined = old + new
            return combined
        })
        original.append(3)
        combined.append(4)
        var copy = result
        copy["a"]?.append(5)
        result["a"]?.append(6)

        #expect(pairs[0].1 == [1])
        #expect(result["a"] == [1, 2, 6])
        #expect(copy["a"] == [1, 2, 5])
        #expect(combined == [1, 2, 4])
    }

    @Test func subscriptDidSet() {
        let holder = DictionaryHolder()
        holder.dictionary["a"] = 1
        #expect(holder.dictionary.count == 1)
        #expect(holder.dictionarySetCount == 1)

        var dictionary = holder.dictionary
        dictionary["a"] = 100
        #expect(holder.dictionary["a"] == 1)
        #expect(holder.dictionary.count == 1)
        #expect(holder.dictionarySetCount == 1)

        holder.dictionary["a"] = 99
        #expect(holder.dictionary["a"] == 99)
        #expect(holder.dictionary.count == 1)
        #expect(holder.dictionarySetCount == 2)
        #expect(dictionary["a"] == 100)
    }

    @Test func nestedSubscriptDidSet() {
        let holder = DictionaryHolder()
        holder.dictionaryOfDictionaries["a"] = ["a": 1, "b": 2, "c": 3]
        #expect(holder.dictionaryOfDictionaries.count == 1)
        #expect(holder.dictionarySetCount == 1)

        var dictionary = holder.dictionaryOfDictionaries
        dictionary["a"]!["b"] = 200
        #expect(holder.dictionaryOfDictionaries["a"] == ["a": 1, "b": 2, "c": 3])
        #expect(holder.dictionaryOfDictionaries.count == 1)
        #expect(holder.dictionarySetCount == 1)

        holder.dictionaryOfDictionaries["a"]!["b"] = 199
        #expect(holder.dictionaryOfDictionaries["a"]!["b"] == 199)
        #expect(holder.dictionaryOfDictionaries.count == 1)
        #expect(holder.dictionarySetCount == 2)
        #expect(dictionary["a"]?["b"] == 200)
    }

    @Test func subscriptDefaultValue() {
        var dict = ["a": 1]
        #expect(dict["b"] == nil)
        #expect(2 == dict["b", default: 2])

        dict["a", default: 1] += 100
        #expect(dict["a"] == 101)

        dict["b", default: 3] += 100
        #expect(dict["b"] == 103)

        var arrayDict: [String: [Int]] = [:]
        arrayDict["a", default: [1, 2]].append(3)
        #expect(arrayDict["a"] == [1, 2, 3])
    }

    @Test func dictionaryReferences() {
        var dict: [String: Int] = [:]
        dict["a"] = 1
        var dict2 = dict
        dict2["b"] = 2
        var dict3 = dict2
        dict3["c"] = 3

        dict["z"] = 0

        #expect(dict.count == 2)
        #expect(dict2.count == 2)
        #expect(dict3.count == 3)
    }

    @Test func iterate() {
        let dict = ["a": 1, "b": 2, "c": 3]
        var keys: [String] = []
        var values: [Int] = []
        for (key, value) in dict {
            keys.append(key)
            values.append(value)
        }
        #expect(keys.sorted() == ["a", "b", "c"])
        #expect(values.sorted() == [1, 2, 3])

        keys.removeAll()
        values.removeAll()
        for entry in dict {
            keys.append(entry.key)
            values.append(entry.value)
        }
        #expect(keys.sorted() == ["a", "b", "c"])
        #expect(values.sorted() == [1, 2, 3])

        keys.removeAll()
        values.removeAll()
        var itr = dict.makeIterator()
        while let (key, value) = itr.next() {
            keys.append(key)
            values.append(value)
        }
        #expect(keys.sorted() == ["a", "b", "c"])
        #expect(values.sorted() == [1, 2, 3])
    }

    @Test func keysValues() {
        let dict = ["a": 1, "b": 2, "c": 3]
        #expect(dict.keys.contains("b"))
        #expect(!dict.keys.contains("d"))
        #expect(dict.values.contains(1))
        #expect(!dict.values.contains(4))
        let keys = Array(dict.keys).sorted()
        let values = Array(dict.values).sorted()
        #expect(keys == ["a", "b", "c"])
        #expect(values == [1, 2, 3])
    }

    @Test func popFirst() {
        var dict = ["a": 1]
        let popped = dict.popFirst()
        #expect(popped?.key == "a")
        #expect(popped?.value == 1)
        #expect(dict.isEmpty)
        #expect(dict.popFirst() == nil)
    }
}

private class DictionaryHolder {
    var dictionary: [String: Int] = [:] {
        didSet {
            dictionarySetCount += 1
        }
    }
    var dictionarySetCount = 0

    var dictionaryOfDictionaries: [String: [String: Int]] = [:] {
        didSet {
            dictionarySetCount += 1
        }
    }
}

// MARK: - Test Errors
private extension DictionaryTests {
    enum CombinationError: Error {
        case failed
    }
}
