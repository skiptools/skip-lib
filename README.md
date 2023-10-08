# SkipLib

Swift standard library for [Skip](https://skip.tools) apps.

## About 

SkipLib vends the `skip.lib` Kotlin package. It serves two purposes:

1. SkipLib is a reimplementation of the Swift standard library for Kotlin on Android. Its goal is to mirror as much of the Swift standard library as possible, allowing Skip developers to use Swift standard library API with confidence.
1. SkipLib contains custom Kotlin API that the Skip transpiler takes advantage of when translating your Swift source to the equivalent Kotlin code. For example, the Kotlin language does not have tuples. Instead, SkipLib's `Tuple.kt` defines bespoke Kotlin `Tuple` classes. When the transpiler translates Swift code that references tuples, it uses these `Tuple` classes in the Kotlin it generates.

## Dependencies

SkipLib depends on the [skip](https://source.skip.tools/skip) transpiler plugin and has no additional library dependencies.

It is part of the core Skip stack and is not intended to be imported directly.
The module is transparently adopted through the automatic addition of `import skip.lib.*` to transpiled files by the Skip transpiler.

## Status

- SkipLib's Swift symbol files (see [Implementation Strategy](#implementation-strategy)) are nominally complete. They should declare all Swift standard library API. This is difficult to validate, however, so if you find anything missing, please [report it](https://github.com/skiptools/skip-lib/issues) to us.
- Unimplemented API is appropriately marked with `@available(*, unavailable)` annotations. Skip will generate an error when you attempt to use an unimplemented API.
- In particular, a significant portion of the [collections](#collections) API is not yet implemented.
- Unit testing is not comprehensive. See [Tests](#tests) for the current test run status.

## Contributing

We welcome contributions to SkipLib. The Skip product documentation includes helpful instructions on [local Skip library development](https://skip.tools/docs/#local-libraries). 

The most pressing need is to reduce the amount of unimplemented API. To help fill in unimplemented API in SkipLib:

1. Find unimplemented API. Unimplemented API should be marked with `@available(*, unavailable)` in the Swift symbol files.
1. Write an appropriate Kotlin implementation. See [Implementation Strategy](#implementation-strategy) below. For [collections](#collections) API, make sure your implementation is duplicated for `String` as well.
1. Write unit tests.
1. [Submit a PR.](https://github.com/skiptools/skip-lib/pulls)

Other forms of contributions such as test cases, comments, and documentation are also welcome!

## Implementation Strategy

Apart from the Skip transpiler itself, SkipLib implements the lowest levels of the Swift language. Its implementation strategy, therefore, differs from other Skip libraries. 

Most Skip libraries *call* Kotlin API, but are *written* in Swift, relying on the Skip transpiler for translation to Kotlin. Most of SkipLib, however, is written in pure Kotlin. Consider SkipLib's implementation of Swift's `Array`. SkipLib divides its `Array` support into two files:

1. `Sources/SkipLib/Array.swift` acts as a Swift header file, declaring the `Array` type's Swift API but stubbing out the implementation. The `// SKIP SYMBOLFILE` comment at the top of the file marks it as such. Read more about special Skip comments in the Skip product [documentation](https://skip.tools/docs/#dev-skip-comments).
1. `Sources/SkipLib/Skip/Array.kt` contains the actual `Array` implementation in Kotlin. 

This pattern is used for most Swift types throughout SkipLib. Meanwhile, SwiftLib implementations of constructs built directly into the Swift language - e.g. tuples or `inout` parameters - only have a Kotlin file, with no corresponding Swift symbol file.

## Topics

### Collections

Collections are perhaps the most complex part of the Swift standard library, and of SkipLib. Swift's comprehensive collection protocols allow `Array`, `Set`, `Dictionary`, `String`, and other types to all share a common set of API, including iteration, `map`, `reduce`, and much more.

Corresponding Kotlin types - `List`, `Set`, `Map`, `String`, etc - do not share a similarly rich API set. As a result, SkipLib must duplicate collection protocol implementations in both `Collections.kt` and `String.kt`, and must duplicate `SetAlgebra` implementations in both `Set.kt` and `OptionSet.kt`.

See the explanatory comments in `Collections.kt` for more information on the design of SkipLib's internal collections support.

## Tests

The following table shows SkipLib's current test status. Test [contributions](#contributing) are welcome.

| Test               | Case                      | Swift | Kotlin |
| ------------------ | ------------------------- | ----- | ------ |
| ArrayTests         | testAdd                   | PASS  | PASS   |
| ArrayTests         | testAddDidSet             | PASS  | PASS   |
| ArrayTests         | testAppend                | PASS  | PASS   |
| ArrayTests         | testAppendDidSet          | PASS  | PASS   |
| ArrayTests         | testArrayIndex            | PASS  | PASS   |
| ArrayTests         | testArrayLiteralInit      | PASS  | PASS   |
| ArrayTests         | testArrayReferences       | PASS  | PASS   |
| ArrayTests         | testDeepNestedArrays      | PASS  | PASS   |
| ArrayTests         | testInsert                | PASS  | PASS   |
| ArrayTests         | testNestedSubscriptDidSet | PASS  | PASS   |
| ArrayTests         | testOptionalElements      | PASS  | PASS   |
| ArrayTests         | testSubscriptDidSet       | PASS  | PASS   |
| CollectionsTests   | testCompactMap            | PASS  | PASS   |
| CollectionsTests   | testDictionaryForEach     | PASS  | PASS   |
| CollectionsTests   | testDoubleStride          | PASS  | PASS   |
| CollectionsTests   | testEmptyStride           | PASS  | PASS   |
| CollectionsTests   | testEnumerated            | PASS  | PASS   |
| CollectionsTests   | testFilter                | PASS  | PASS   |
| CollectionsTests   | testFilterMapReduce       | PASS  | PASS   |
| CollectionsTests   | testFirstLast             | PASS  | PASS   |
| CollectionsTests   | testFlatMap               | PASS  | PASS   |
| CollectionsTests   | testIndices               | PASS  | PASS   |
| CollectionsTests   | testJoin                  | PASS  | PASS   |
| CollectionsTests   | testLazyFilterMap         | PASS  | SKIP   |
| CollectionsTests   | testMap                   | PASS  | PASS   |
| CollectionsTests   | testReadSlice             | PASS  | PASS   |
| CollectionsTests   | testReduce                | PASS  | PASS   |
| CollectionsTests   | testRemoveFirst           | PASS  | PASS   |
| CollectionsTests   | testSort                  | PASS  | PASS   |
| CollectionsTests   | testStride                | PASS  | PASS   |
| CollectionsTests   | testStrideThrough         | PASS  | PASS   |
| CollectionsTests   | testWriteSlice            | PASS  | PASS   |
| CollectionsTests   | testZipCompactMap         | PASS  | SKIP   |
| ConcurrencyTests   | testAsyncLet              | PASS  | PASS   |
| ConcurrencyTests   | testAsyncSequence         | PASS  | PASS   |
| ConcurrencyTests   | testMainActor             | PASS  | PASS   |
| ConcurrencyTests   | testSimpleValue           | PASS  | PASS   |
| ConcurrencyTests   | testTaskCancelWithExcepti | PASS  | PASS   |
| ConcurrencyTests   | testTaskCancelWithoutExce | PASS  | PASS   |
| ConcurrencyTests   | testTaskIsCancelled       | PASS  | PASS   |
| ConcurrencyTests   | testThrowsException       | PASS  | PASS   |
| DictionaryTests    | testDictionaryLiteralInit | PASS  | PASS   |
| DictionaryTests    | testDictionaryReferences  | PASS  | PASS   |
| DictionaryTests    | testIterate               | PASS  | PASS   |
| DictionaryTests    | testKeysValues            | PASS  | PASS   |
| DictionaryTests    | testNestedSubscriptDidSet | PASS  | PASS   |
| DictionaryTests    | testPopFirst              | PASS  | PASS   |
| DictionaryTests    | testSubscriptDefaultValue | PASS  | PASS   |
| DictionaryTests    | testSubscriptDidSet       | PASS  | PASS   |
| GlobalsTests       | testFatalError            | PASS  | PASS   |
| GlobalsTests       | testSwap                  | PASS  | PASS   |
| KotlinInteropTests | testCustomKotlinConversio | PASS  | PASS   |
| MathTests          | testCeil                  | PASS  | PASS   |
| MathTests          | testEulersNumbers         | PASS  | PASS   |
| MathTests          | testFloor                 | PASS  | PASS   |
| MathTests          | testHypot                 | PASS  | PASS   |
| MathTests          | testInfinity              | PASS  | PASS   |
| MathTests          | testMath                  | PASS  | PASS   |
| MathTests          | testNaN                   | PASS  | PASS   |
| MathTests          | testPow                   | PASS  | PASS   |
| MathTests          | testRound                 | PASS  | PASS   |
| MathTests          | testSpecialNumbers        | PASS  | PASS   |
| MathTests          | testSqrt                  | PASS  | PASS   |
| NumberTests        | testEquatable             | PASS  | PASS   |
| NumberTests        | testFixedWidthIntegers    | PASS  | PASS   |
| NumberTests        | testFloatingPoint         | PASS  | PASS   |
| NumberTests        | testHashable              | PASS  | PASS   |
| NumberTests        | testIntegers              | PASS  | PASS   |
| NumberTests        | testMinMax                | PASS  | PASS   |
| NumberTests        | testNumberConversions     | PASS  | PASS   |
| NumberTests        | testNumberInitializers    | PASS  | PASS   |
| NumberTests        | testNumberMinMax          | PASS  | PASS   |
| NumberTests        | testUnsignedIntegers      | PASS  | PASS   |
| OptionSetTests     | testContains              | PASS  | PASS   |
| OptionSetTests     | testInsert                | PASS  | PASS   |
| OptionalTests      | testOptionalMap           | PASS  | PASS   |
| ResultTests        | testFailure               | PASS  | PASS   |
| ResultTests        | testSuccess               | PASS  | PASS   |
| SetTests           | testCustomHashable        | PASS  | PASS   |
| SetTests           | testInit                  | PASS  | PASS   |
| SetTests           | testInsert                | PASS  | PASS   |
| SetTests           | testIntersection          | PASS  | PASS   |
| SetTests           | testIsDisjoint            | PASS  | PASS   |
| SetTests           | testPopFirst              | PASS  | PASS   |
| SetTests           | testRemove                | PASS  | PASS   |
| SetTests           | testSubsetSuperset        | PASS  | PASS   |
| SetTests           | testSymmetricDifference   | PASS  | PASS   |
| SetTests           | testUnion                 | PASS  | PASS   |
| SkipLibTests       | testFatalError            | PASS  | PASS   |
| SkipLibTests       | testSkipLib               | PASS  | PASS   |
| SkipLibTests       | testUnitTests             | PASS  | PASS   |
| StringTests        | testCharacterFunctions    | PASS  | PASS   |
| StringTests        | testCreation              | PASS  | PASS   |
| StringTests        | testFirstDropFirst        | PASS  | PASS   |
| StringTests        | testManipulation          | PASS  | PASS   |
| StringTests        | testMultibyteCharacterFun | PASS  | PASS   |
| StringTests        | testMultlineStrings       | PASS  | PASS   |
| StringTests        | testSlice                 | PASS  | PASS   |
| StringTests        | testSplitJoin             | PASS  | PASS   |
| StringTests        | testStringSearching       | PASS  | PASS   |
| StringTests        | testUnicodeStrings        | PASS  | SKIP   |
| StructTests        | testNestedStructDidSet    | PASS  | PASS   |
| StructTests        | testStructMutate          | PASS  | PASS   |
| StructTests        | testStructMutateDidSet    | PASS  | PASS   |
| StructTests        | testStructReferences      | PASS  | PASS   |
|                    |                           | 100%  | 97%    |
