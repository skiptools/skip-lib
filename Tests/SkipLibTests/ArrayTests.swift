// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct ArrayTests {
    @Test func arrayLiteralInit() {
        let emptyArray: [Int] = []
        #expect(emptyArray.count == 0)

        let emptyArray2: Array<Int> = []
        #expect(emptyArray2.count == 0)

        let emptyArray3 = [Int]()
        #expect(emptyArray3.count == 0)

        let emptyArray4 = Array<Int>()
        #expect(emptyArray4.count == 0)

        let singleElementArray = [1]
        #expect(singleElementArray.count == 1)
        #expect(singleElementArray[0] == 1)

        let multipleElementArray = [1, 2]
        #expect(multipleElementArray.count == 2)
        #expect(multipleElementArray[0] == 1)
        #expect(multipleElementArray[1] == 2)
    }

    @Test func arrayIndex() {
        let a = [1, 2, 3]
        let index: Array.Index? = a.firstIndex(of: 2)
        #expect(index == 1)
    }

    @Test func optionalElements() {
        var optionalArray: [Int?] = [1, nil, 2]
        #expect(optionalArray.count == 3)
        #expect(optionalArray[0] == 1)
        #expect(optionalArray[1] == nil)
        #expect(optionalArray[2] == 2)

        optionalArray.append(nil)
        #expect(optionalArray[3] == nil)
    }

    @Test func append() {
        var array = [1, 2]
        array.append(3)
        #expect(array.count == 3)
        #expect(array[2] == 3)

        var array2 = array
        array2.append(4)
        #expect(array2.count == 4)
        #expect(array2[3] == 4)
        #expect(array.count == 3)

        var combined: [Int] = []
        combined.append(contentsOf: array)
        #expect(combined == [1, 2, 3])
        combined.append(contentsOf: array2)
        #expect(combined == [1, 2, 3, 1, 2, 3, 4])
    }

    @Test func add() {
        let array1 = [1, 2, 3]
        let array2 = [4, 5, 6]
        var combined = array1 + array2
        #expect(combined == [1, 2, 3, 4, 5, 6])
        combined += [7, 8]
        #expect(combined == [1, 2, 3, 4, 5, 6, 7, 8])
    }

    @Test func appendDidSet() {
        let holder = ArrayHolder()
        #expect(holder.arraySetCount == 0)

        holder.array.append(1)
        #expect(holder.array.count == 1)
        #expect(holder.arraySetCount == 1)

        var array = holder.array
        #expect(array.count == 1)
        array.append(2)
        #expect(array.count == 2)
        #expect(holder.array.count == 1)
        #expect(holder.arraySetCount == 1)

        holder.array.append(3)
        holder.array.append(4)
        #expect(holder.array.count == 3)
        #expect(holder.arraySetCount == 3)
        #expect(array.count == 2)
    }

    @Test func addDidSet() {
        let holder = ArrayHolder()
        #expect(holder.arraySetCount == 0)

        holder.array += [1, 2, 3]
        #expect(holder.array == [1, 2, 3])
        #expect(holder.arraySetCount == 1)

        var array = holder.array
        array += [4]
        #expect(array.count == 4)
        #expect(holder.array.count == 3)
        #expect(holder.arraySetCount == 1)

        holder.array += [4, 5]
        #expect(holder.array.count == 5)
        #expect(holder.arraySetCount == 2)
        #expect(array.count == 4)
    }

    @Test func subscriptDidSet() {
        let holder = ArrayHolder()
        holder.array.append(1)
        #expect(holder.array.count == 1)
        #expect(holder.arraySetCount == 1)

        var array = holder.array
        array[0] = 100
        #expect(holder.array[0] == 1)
        #expect(holder.array.count == 1)
        #expect(holder.arraySetCount == 1)

        holder.array[0] = 99
        #expect(holder.array[0] == 99)
        #expect(holder.array.count == 1)
        #expect(holder.arraySetCount == 2)
        #expect(array[0] == 100)
    }

    @Test func nestedSubscriptDidSet() {
        let holder = ArrayHolder()
        holder.arrayOfArrays.append([1, 2, 3])
        #expect(holder.arrayOfArrays.count == 1)
        #expect(holder.arraySetCount == 1)

        var array = holder.arrayOfArrays
        array[0][1] = 200
        #expect(holder.arrayOfArrays[0] == [1, 2, 3])
        #expect(holder.arrayOfArrays.count == 1)
        #expect(holder.arraySetCount == 1)

        holder.arrayOfArrays[0][1] = 199
        #expect(holder.arrayOfArrays[0][1] == 199)
        #expect(holder.arrayOfArrays.count == 1)
        #expect(holder.arraySetCount == 2)
        #expect(array[0][1] == 200)
    }

    @Test func deepNestedArrays() {
        var nested: [[[[[Int]]]]] = [[[[[1]]]]]
        let nested0: [[[Int]]] = [[[-1]]]

        nested[0][0][0][0][0] = nested[0][0][0][0][0] + 1
        nested[0][0] = nested0
        nested[0][0][0][0][0] = nested[0][0][0][0][0] + 1
        #expect(nested[0][0][0][0][0] == 0)
    }

    @Test func arrayReferences() {
        var arr: [Int] = []
        arr.append(1)
        var arr2 = arr
        arr2.append(2)
        var arr3 = arr2
        arr3.append(3)

        arr.append(0)

        #expect(arr.count == 2)
        #expect(arr2.count == 2)
        #expect(arr3.count == 3)
    }

    @Test func insert() {
        var array = [1, 2]
        array.insert(3, at: 1)
        #expect(array.count == 3)
        #expect(array[0] == 1)
        #expect(array[1] == 3)
        #expect(array[2] == 2)

        var array2 = array
        array2.insert(4, at: 2)
        #expect(array2.count == 4)
        #expect(array2[0] == 1)
        #expect(array2[1] == 3)
        #expect(array2[2] == 4)
        #expect(array2[3] == 2)

        #expect(array.count == 3)
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
