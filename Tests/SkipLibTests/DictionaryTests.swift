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
