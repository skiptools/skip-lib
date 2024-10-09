// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class DictionaryTests: XCTestCase {
    func testDictionaryLiteralInit() {
        let emptyDictionary: [String: Int] = [:]
        XCTAssertEqual(emptyDictionary.count, 0)

        let emptyDictionary2: Dictionary<String, Int> = [:]
        XCTAssertEqual(emptyDictionary2.count, 0)

        let emptyDictionary3 = [String: Int]()
        XCTAssertEqual(emptyDictionary3.count, 0)

        let emptyDictionary4 = Dictionary<String, Int>()
        XCTAssertEqual(emptyDictionary4.count, 0)

        let singleElementDictionary = ["a": 1]
        XCTAssertEqual(singleElementDictionary.count, 1)
        XCTAssertEqual(singleElementDictionary["a"], 1)

        let multipleElementDictionary = ["a": 1, "b": 2]
        XCTAssertEqual(multipleElementDictionary.count, 2)
        XCTAssertEqual(multipleElementDictionary["a"], 1)
        XCTAssertEqual(multipleElementDictionary["b"], 2)
    }

    func testSubscriptDidSet() {
        let holder = DictionaryHolder()
        holder.dictionary["a"] = 1
        XCTAssertEqual(holder.dictionary.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 1)

        var dictionary = holder.dictionary
        dictionary["a"] = 100
        XCTAssertEqual(holder.dictionary["a"], 1)
        XCTAssertEqual(holder.dictionary.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 1)

        holder.dictionary["a"] = 99
        XCTAssertEqual(holder.dictionary["a"], 99)
        XCTAssertEqual(holder.dictionary.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 2)
        XCTAssertEqual(dictionary["a"], 100)
    }

    func testNestedSubscriptDidSet() {
        let holder = DictionaryHolder()
        holder.dictionaryOfDictionaries["a"] = ["a": 1, "b": 2, "c": 3]
        XCTAssertEqual(holder.dictionaryOfDictionaries.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 1)

        var dictionary = holder.dictionaryOfDictionaries
        dictionary["a"]!["b"] = 200
        XCTAssertEqual(holder.dictionaryOfDictionaries["a"], ["a": 1, "b": 2, "c": 3])
        XCTAssertEqual(holder.dictionaryOfDictionaries.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 1)

        holder.dictionaryOfDictionaries["a"]!["b"] = 199
        XCTAssertEqual(holder.dictionaryOfDictionaries["a"]!["b"], 199)
        XCTAssertEqual(holder.dictionaryOfDictionaries.count, 1)
        XCTAssertEqual(holder.dictionarySetCount, 2)
        XCTAssertEqual(dictionary["a"]?["b"], 200)
    }

    func testSubscriptDefaultValue() {
        var dict = ["a": 1]
        XCTAssertNil(dict["b"])
        XCTAssertEqual(2, dict["b", default: 2])

        dict["a", default: 1] += 100
        XCTAssertEqual(dict["a"], 101)

        dict["b", default: 3] += 100
        XCTAssertEqual(dict["b"], 103)

        var arrayDict: [String: [Int]] = [:]
        arrayDict["a", default: [1, 2]].append(3)
        XCTAssertEqual(arrayDict["a"], [1, 2, 3])
    }

    func testDictionaryReferences() {
        var dict: [String: Int] = [:]
        dict["a"] = 1
        var dict2 = dict
        dict2["b"] = 2
        var dict3 = dict2
        dict3["c"] = 3

        dict["z"] = 0

        XCTAssertEqual(dict.count, 2)
        XCTAssertEqual(dict2.count, 2)
        XCTAssertEqual(dict3.count, 3)
    }

    func testIterate() {
        let dict = ["a": 1, "b": 2, "c": 3]
        var keys: [String] = []
        var values: [Int] = []
        for (key, value) in dict {
            keys.append(key)
            values.append(value)
        }
        XCTAssertEqual(keys.sorted(), ["a", "b", "c"])
        XCTAssertEqual(values.sorted(), [1, 2, 3])

        keys.removeAll()
        values.removeAll()
        for entry in dict {
            keys.append(entry.key)
            values.append(entry.value)
        }
        XCTAssertEqual(keys.sorted(), ["a", "b", "c"])
        XCTAssertEqual(values.sorted(), [1, 2, 3])

        keys.removeAll()
        values.removeAll()
        var itr = dict.makeIterator()
        while let (key, value) = itr.next() {
            keys.append(key)
            values.append(value)
        }
        XCTAssertEqual(keys.sorted(), ["a", "b", "c"])
        XCTAssertEqual(values.sorted(), [1, 2, 3])
    }

    func testKeysValues() {
        let dict = ["a": 1, "b": 2, "c": 3]
        XCTAssertTrue(dict.keys.contains("b"))
        XCTAssertFalse(dict.keys.contains("d"))
        XCTAssertTrue(dict.values.contains(1))
        XCTAssertFalse(dict.values.contains(4))
        let keys = Array(dict.keys).sorted()
        let values = Array(dict.values).sorted()
        XCTAssertEqual(keys, ["a", "b", "c"])
        XCTAssertEqual(values, [1, 2, 3])
    }

    func testPopFirst() {
        var dict = ["a": 1]
        let popped = dict.popFirst()
        XCTAssertEqual(popped?.key, "a")
        XCTAssertEqual(popped?.value, 1)
        XCTAssertTrue(dict.isEmpty)
        XCTAssertNil(dict.popFirst())
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
