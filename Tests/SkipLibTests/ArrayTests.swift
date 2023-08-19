// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

final class ArrayTests: XCTestCase {
    func testArrayLiteralInit() {
        let emptyArray: [Int] = []
        XCTAssertEqual(emptyArray.count, 0)

        let emptyArray2: Array<Int> = []
        XCTAssertEqual(emptyArray2.count, 0)

        let emptyArray3 = [Int]()
        XCTAssertEqual(emptyArray3.count, 0)

        let emptyArray4 = Array<Int>()
        XCTAssertEqual(emptyArray4.count, 0)

        let singleElementArray = [1]
        XCTAssertEqual(singleElementArray.count, 1)
        XCTAssertEqual(singleElementArray[0], 1)

        let multipleElementArray = [1, 2]
        XCTAssertEqual(multipleElementArray.count, 2)
        XCTAssertEqual(multipleElementArray[0], 1)
        XCTAssertEqual(multipleElementArray[1], 2)
    }

    func testArrayIndex() {
        let a = [1, 2, 3]
        let index: Array.Index? = a.firstIndex(of: 2)
        XCTAssertEqual(index, 1)
    }

    func testOptionalElements() {
        var optionalArray: [Int?] = [1, nil, 2]
        XCTAssertEqual(optionalArray.count, 3)
        XCTAssertEqual(optionalArray[0], 1)
        XCTAssertNil(optionalArray[1])
        XCTAssertEqual(optionalArray[2], 2)

        optionalArray.append(nil)
        XCTAssertNil(optionalArray[3])
    }

    func testAppend() {
        var array = [1, 2]
        array.append(3)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[2], 3)

        var array2 = array
        array2.append(4)
        XCTAssertEqual(array2.count, 4)
        XCTAssertEqual(array2[3], 4)
        XCTAssertEqual(array.count, 3)

        var combined: [Int] = []
        combined.append(contentsOf: array)
        XCTAssertEqual(combined, [1, 2, 3])
        combined.append(contentsOf: array2)
        XCTAssertEqual(combined, [1, 2, 3, 1, 2, 3, 4])
    }

    func testAdd() {
        let array1 = [1, 2, 3]
        let array2 = [4, 5, 6]
        var combined = array1 + array2
        XCTAssertEqual(combined, [1, 2, 3, 4, 5, 6])
        combined += [7, 8]
        XCTAssertEqual(combined, [1, 2, 3, 4, 5, 6, 7, 8])
    }

    func testAppendDidSet() {
        let holder = ArrayHolder()
        XCTAssertEqual(holder.arraySetCount, 0)

        holder.array.append(1)
        XCTAssertEqual(holder.array.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        var array = holder.array
        XCTAssertEqual(array.count, 1)
        array.append(2)
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(holder.array.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        holder.array.append(3)
        holder.array.append(4)
        XCTAssertEqual(holder.array.count, 3)
        XCTAssertEqual(holder.arraySetCount, 3)
        XCTAssertEqual(array.count, 2)
    }

    func testAddDidSet() {
        let holder = ArrayHolder()
        XCTAssertEqual(holder.arraySetCount, 0)

        holder.array += [1, 2, 3]
        XCTAssertEqual(holder.array, [1, 2, 3])
        XCTAssertEqual(holder.arraySetCount, 1)

        var array = holder.array
        array += [4]
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(holder.array.count, 3)
        XCTAssertEqual(holder.arraySetCount, 1)

        holder.array += [4, 5]
        XCTAssertEqual(holder.array.count, 5)
        XCTAssertEqual(holder.arraySetCount, 2)
        XCTAssertEqual(array.count, 4)
    }

    func testSubscriptDidSet() {
        let holder = ArrayHolder()
        holder.array.append(1)
        XCTAssertEqual(holder.array.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        var array = holder.array
        array[0] = 100
        XCTAssertEqual(holder.array[0], 1)
        XCTAssertEqual(holder.array.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        holder.array[0] = 99
        XCTAssertEqual(holder.array[0], 99)
        XCTAssertEqual(holder.array.count, 1)
        XCTAssertEqual(holder.arraySetCount, 2)
        XCTAssertEqual(array[0], 100)
    }

    func testNestedSubscriptDidSet() {
        let holder = ArrayHolder()
        holder.arrayOfArrays.append([1, 2, 3])
        XCTAssertEqual(holder.arrayOfArrays.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        var array = holder.arrayOfArrays
        array[0][1] = 200
        XCTAssertEqual(holder.arrayOfArrays[0], [1, 2, 3])
        XCTAssertEqual(holder.arrayOfArrays.count, 1)
        XCTAssertEqual(holder.arraySetCount, 1)

        holder.arrayOfArrays[0][1] = 199
        XCTAssertEqual(holder.arrayOfArrays[0][1], 199)
        XCTAssertEqual(holder.arrayOfArrays.count, 1)
        XCTAssertEqual(holder.arraySetCount, 2)
        XCTAssertEqual(array[0][1], 200)
    }

    func testDeepNestedArrays() {
        var nested: [[[[[Int]]]]] = [[[[[1]]]]]
        let nested0: [[[Int]]] = [[[-1]]]

        nested[0][0][0][0][0] = nested[0][0][0][0][0] + 1
        nested[0][0] = nested0
        nested[0][0][0][0][0] = nested[0][0][0][0][0] + 1
        XCTAssertEqual(nested[0][0][0][0][0], 0)
    }

    func testArrayReferences() {
        var arr: [Int] = []
        arr.append(1)
        var arr2 = arr
        arr2.append(2)
        var arr3 = arr2
        arr3.append(3)

        arr.append(0)

        XCTAssertEqual(arr.count, 2)
        XCTAssertEqual(arr2.count, 2)
        XCTAssertEqual(arr3.count, 3)
    }

    func testInsert() {
        var array = [1, 2]
        array.insert(3, at: 1)
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 3)
        XCTAssertEqual(array[2], 2)

        var array2 = array
        array2.insert(4, at: 2)
        XCTAssertEqual(array2.count, 4)
        XCTAssertEqual(array2[0], 1)
        XCTAssertEqual(array2[1], 3)
        XCTAssertEqual(array2[2], 4)
        XCTAssertEqual(array2[3], 2)

        XCTAssertEqual(array.count, 3)
    }
}

// Ensure that array generic extensions are transpiled correctly
extension Array {
    var forceFirst: Element? {
        return self[0]
    }
}

private class ArrayHolder {
    var array: [Int] = [] {
        didSet {
            arraySetCount += 1
        }
    }
    var arraySetCount = 0

    var arrayOfArrays: [[Int]] = [] {
        didSet {
            arraySetCount += 1
        }
    }
}
