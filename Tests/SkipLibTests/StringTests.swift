// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

@Suite struct StringTests {
    @Test func creation() {
        let str1 = "Hello, world!"
        #expect(str1 == "Hello, world!")

        let str2 = String(repeating: "a", count: 5)
        #expect(str2 == "aaaaa")

        let str3 = "Hello, world!".reversed()
        #expect(String(str3) == "!dlrow ,olleH")
    }

    @Test func characterFunctions() {
        let str1 = "Hello, world!"

        let first = str1.first
        #expect(first == Character("H"))

        let last = str1.last
        #expect(last == Character("!"))
    }

    @Test func multibyteCharacterFunctions() {
        let str1 = "你好，世界"

        let first = str1.first
        #expect(first == Character("你"))

        let firstLast = str1.reversed().last
        #expect(first == firstLast)

        let last = str1.last

        #if !SKIP
        #expect(last == "界")
        #expect(last?.isASCII == false)
        #expect(last?.isCased == false)
        #expect(last?.isCurrencySymbol == false)
        #expect(last?.isHexDigit == false)
        #expect(last?.isLetter == true)
        #expect(last?.isLowercase == false)
        #expect(last?.isUppercase == false)
        #expect(last?.isMathSymbol == false)
        #expect(last?.isNewline == false)
        #expect(last?.isNumber == false)
        #expect(last?.isPunctuation == false)
        #expect(last?.isHexDigit == false)
        #expect(last?.isCurrencySymbol == false)
        #expect(last?.isWholeNumber == false)
        #expect(last?.wholeNumberValue == nil)
        #endif
        #expect(last == Character("界"))

        let lastFirst = str1.reversed().first
        #expect(last == lastFirst)
    }

    @Test func manipulation() {
        var str = "Hello, world!"
        #expect(str.count == 13)

        #expect(str.isEmpty == false)

        #if !SKIP
        str.append(contentsOf: " How are you?")
        #expect(str == "Hello, world! How are you?")

        str.removeLast(13)
        #expect(str == "Hello, world!")
        #endif

        let index = str.firstIndex(of: ",")!
        let substring = str[..<index]
        #expect(String(substring) == "Hello")
    }

    @Test func stringSearching() {
        let str = "The quick brown fox jumps over the lazy dog."

        #expect(str.hasPrefix("The"))
        #expect(str.hasSuffix("."))
        #expect(str.contains("fox"))

        let index = str.firstIndex(of: "b")!
        #expect(str.distance(from: str.startIndex, to: index) == 10)
    }

    @Test func firstLast() {
        let str = "hello, world!"
        let firstChar = str.first
        #expect(firstChar?.description == "h")
        let rest = str.dropFirst()
        #expect(rest == "ello, world!")
        let rest2 = str.dropFirst(2)
        #expect(rest2 == "llo, world!")
        let frst = str.dropLast()
        #expect(frst == "hello, world")
        let frst2 = str.dropLast(2)
        #expect(frst2 == "hello, worl")

        #expect(", world!" == str.drop(while: { "hellow".contains($0) }))
        #expect("" == str.drop(while: { _ in true }))
    }

    @Test func prefixSuffix() {
        let str = "abc"
        #expect("" == str.prefix(0))
        #expect("c" == str.suffix(1))
        #expect("bc" == str.suffix(2))
        #expect("abc" == str.suffix(4))

        #expect("" == str.prefix(0))
        #expect("a" == str.prefix(1))
        #expect("ab" == str.prefix(2))
        #expect("abc" == str.prefix(4))

        #expect("ab" == str.prefix(while: { $0 != "c" }))
        #expect("" == str.prefix(while: { _ in false }))

        #expect("c" == str.suffix(from: str.index(before: str.endIndex)))
        #expect("abc" == str.suffix(from: str.startIndex))
    }

    @Test func elementsEqual() {
        let str = "abc"
        #expect(str.elementsEqual("abc"))
        #expect(!str.elementsEqual("ab"))
        #expect(str.elementsEqual("abc", by: { $0 == $1 }))
        #expect(!str.elementsEqual("abc", by: { $0 != $1 }))
    }

    @Test func multlineStrings() {
        let str = """
        Hello there,

        How do you do?

            Bye!
        """
        let str2 = "Hello there,\n\nHow do you do?\n\n    Bye!"
        #expect(str == str2)
    }

    @Test func slice() {
        let str = "abcdef"
        let bindex: String.Index = str.firstIndex(of: "b")!
        let char = str[bindex]
        #expect(char == "b")

        let sub1 = str[bindex..<str.index(str.startIndex, offsetBy: 3)]
        #expect(String(sub1) == "bc")

        let sub2 = str[sub1.startIndex...sub1.endIndex]
        #expect(String(sub2) == "bcd")

        let str2 = str + sub2
        #expect(str2 == "abcdefbcd")
    }

    @Test func unicodeStrings() {
        #if SKIP
        // skip: TODO: testUnicodeStrings
        return
        #else
        // Illegal escape: '\u'
        #expect("Bu\u{00f1}uelos" == "Bun\u{0303}uelos")

        let character1 = "É"
        let character2 = "E\u{0301}"
        #expect(character1 == character2)

        let alpha1 = "α"
        let alpha2 = "\u{03B1}"
        #expect(alpha1 == alpha2)

        let beta1 = "β"
        let beta2 = "\u{03B2}"
        #expect(beta1 == beta2)

        let squareRoot1 = "√"
        let squareRoot2 = "\u{221A}"
        #expect(squareRoot1 == squareRoot2)

        let notEqual1 = "≠"
        let notEqual2 = "\u{2260}"
        #expect(notEqual1 == notEqual2)

        let emoji1 = "👨‍💻"
        let emoji2 = "👨\u{200D}💻"
        #expect(emoji1 == emoji2)

        let flagUS1 = "🇺🇸"
        let flagUS2 = "\u{1F1FA}\u{1F1F8}"
        #expect(flagUS1 == flagUS2)

        let flagFrance1 = "🇫🇷"
        let flagFrance2 = "\u{1F1EB}\u{1F1F7}"
        #expect(flagFrance1 == flagFrance2)

        let word1 = "café"
        let word2 = "cafe\u{301}"
        #expect(word1 == word2)

        let mixed1 = "Hello 世界!"
        let mixed2 = "Hello \u{4E16}\u{754C}!"
        #expect(mixed1 == mixed2)

        let hiragana1 = "ひらがな"
        let hiragana2 = "\u{3072}\u{3089}\u{304C}\u{306A}"
        #expect(hiragana1 == hiragana2)

        let katakana1 = "カタカナ"
        let katakana2 = "\u{30AB}\u{30BF}\u{30AB}\u{30CA}"
        #expect(katakana1 == katakana2)

        let dollar1 = "$"
        let dollar2 = "\u{0024}"
        #expect(dollar1 == dollar2)

        let euro1 = "€"
        let euro2 = "\u{20AC}"
        #expect(euro1 == euro2)

        let alef1 = "ا"
        let alef2 = "\u{0627}"
        #expect(alef1 == alef2)

        let beh1 = "ب"
        let beh2 = "\u{0628}"
        #expect(beh1 == beh2)

        let smiley1 = "😊"
        let smiley2 = "\u{1F60A}"
        #expect(smiley1 == smiley2)

        let heart1 = "💖"
        let heart2 = "\u{1F496}"
        #expect(heart1 == heart2)

        // combining characters
        let oU1 = "Ǔ"
        let oU2 = "U\u{030C}"
        #expect(oU1 == oU2)
        #endif
    }

    @Test func splitJoin() {
        let str = "ab,cd,efg,,hi"
        let arr = str.split(separator: ",")
        #expect(arr.count == 4)

        let str2 = arr.joined(separator: "++")
        #expect(str2 == "ab++cd++efg++hi")
    }

    @Test func splitMax() {
        let str = "ab,cd,efg,,hi"
        #expect(["ab,cd,efg,,hi"] == str.split(separator: ",", maxSplits: 0))
        #expect(["ab", "cd,efg,,hi"] == str.split(separator: ",", maxSplits: 1))
        #expect(["ab", "cd", "efg,,hi"] == str.split(separator: ",", maxSplits: 2))
        #expect(["ab", "cd", "efg", ",hi"] == str.split(separator: ",", maxSplits: 3))
        #expect(["ab", "cd", "efg", "hi"] == str.split(separator: ",", maxSplits: 4))

        #expect(["ab,cd,efg,,hi"] == str.split(separator: ",", maxSplits: 0, omittingEmptySubsequences: false))
        #expect(["ab", "cd,efg,,hi"] == str.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: false))
        #expect(["ab", "cd", "efg,,hi"] == str.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: false))
        #expect(["ab", "cd", "efg", ",hi"] == str.split(separator: ",", maxSplits: 3, omittingEmptySubsequences: false))
        #expect(["ab", "cd", "efg", "", "hi"] == str.split(separator: ",", maxSplits: 4, omittingEmptySubsequences: false))

        #expect([""] == "".split(separator: ",", omittingEmptySubsequences: false))
    }

    @Test func map() {
        let str = "abc"
        let mapped = str.map { String($0) }
        #expect(mapped == ["a", "b", "c"])

        let flatMapped = str.flatMap { [String($0), String($0)] }
        #expect(flatMapped == ["a", "a", "b", "b", "c", "c"])
    }

    @Test func stringFormat() {
        #expect(String(format: "%%") == "%") // Escaping percent sign
        #expect(String(format: "%d", 42) == "42") // Integer format
        #expect(String(format: "%f", 3.14159) == "3.141590") // Float format (note: can fail for non-English languages: e.g., 3,131590)
        #expect(String(format: "%.2f", 3.14159) == "3.14") // Float format with precision
        #expect(String(format: "%5d", 42) == "   42") // Padding
        #expect(String(format: "%.3f", 2.71828) == "2.718") // Float format with precision
        #expect(String(format: "x %0.4f", 2.71828) == "x 2.7183") // Float format with precision with preceeding 0 (https://github.com/skiptools/skip-lib/issues/2)
        #expect(String(format: "%.2f%%", 75.0) == "75.00%") // Percent format
        #expect(String(format: "%3$d %2$d %1$d", 1, 2, 3) == "3 2 1") // Argument reordering
        #expect(String(format: "%3$d %2$d %d", 1, 2, 3, 4) == "3 2 1") // Extra arguments ignored
        //XCTAssertNil(String(format: "%@")) // Missing argument

        #expect(String(format: "Name: %@, Age: %d", "Alice", 30) == "Name: Alice, Age: 30") // Mixed formats
        #expect(String(format: "%@ %d", arguments: ["Answer:", 42]) == "Answer: 42") // Arguments in an array
        #expect(String(format: "Hello, %@", "world") == "Hello, world") // Basic substitution
        #expect(String(format: "%@, %@", "Hello", "world") == "Hello, world") // Multiple substitutions
        #expect(String(format: "%%@ %@ %d", "String", 42) == "%@ String 42") // Mixed literal and format specifiers
        #expect(String(format: "%@%@%@%@", "a", "b", "c", "d") == "abcd") // Multiple %@ substitutions
        #expect(String(format: "%1$@ %2$@ %1$@", "A", "B") == "A B A") // Reusing arguments

        #if !os(Linux)
        #expect(String(format: "%4$@ %1$d %3$.5f", 42, "hello", 3.14159, "world") == "world 42 3.14159") // Mixed arguments
        #endif
        #expect(String(format: "The %@ is %3$@: %2$d", "answer", 42, "forty-two") == "The answer is forty-two: 42") // Mixed substitutions

        // format styles used in .xcstrings files
        #expect(String(format: "Tap: (%1$lld, %2$lld)", 9, 10) == "Tap: (9, 10)")
        #expect(String(format: "String: %1$@ Number: %2$lf", "XXX", 12.34) == "String: XXX Number: 12.340000")
        #expect(String(format: "Tap: (%1$lf, %2$lf)", 12.34, 56.78) == "Tap: (12.340000, 56.780000)")

        #if !SKIP // java.util.UnknownFormatConversionException: Conversion = '.'
        #expect(String(format: "%.*f", 3, 3.14159) == "3.142") // Precision with variable argument
        #expect(String(format: "%1$.*2$f", 3.14159, 3) == "3.142") // Dynamic width and precision
        #endif

        #expect(String(format: "The answer is %d", arguments: [42]) == "The answer is 42") // Argument in array
        #expect(String(format: "The %% is not replaced: %%%d", 42) == "The % is not replaced: %42") // Escaping and substitution

        #expect(String(format: "The answer is %d", 42) == "The answer is 42") // Basic integer substitution
        #expect(String(format: "The answer is %ld", 42) == "The answer is 42") // Long decimal (Java should convert to %d)
        #expect(String(format: "The answer is %lld", 42) == "The answer is 42") // Long long decimal (Java should convert to %d)

        #if !os(Linux)
        #expect(String(format: "The answer is %lf", 42.2) == "The answer is 42.200000") // Long float (Java should convert to %f)
        #expect(String(format: "The answer is %llf", 42.2) == "The answer is 42.200000") // Long long float (Java should convert to %d)
        #endif
        #expect(String(format: "The value is %u", 42) == "The value is 42") // Unsigned format

        #if !SKIP // java.util.UnknownFormatConversionException: Conversion = 'z'
        #expect(String(format: "The answer is %zd", 42) == "The answer is 42") // Basic integer substitution (alternative specifier)
        #expect(String(format: "The value is %u", -42) == "The value is 4294967254") // Unsigned format (negative number)
        #expect(String(format: "The answer is %05d", 42) == "The answer is 00042") // Zero padding
        #endif

        #expect(String(format: "The answer is %x", 42) == "The answer is 2a") // Hexadecimal format
        #expect(String(format: "The answer is %o", 42) == "The answer is 52") // Octal format
        #expect(String(format: "The answer is %+d", 42) == "The answer is +42") // Positive sign
        #expect(String(format: "The answer is % d", 42) == "The answer is  42") // Space for positive sign
        #expect(String(format: "The answer is %10.2f", 3.14159) == "The answer is       3.14") // Width and precision
        #expect(String(format: "The value is %+.2e", 12345.6789) == "The value is +1.23e+04") // Exponential notation
        #expect(String(format: "The value is %#.2f", 123.45) == "The value is 123.45") // No effect of # flag on float
        #expect(String(format: "The value is %#x", 42) == "The value is 0x2a") // Hex format with # flag
        #expect(String(format: "The value is %02x", 42) == "The value is 2a") // No effect of 0 flag on hex

        #if SKIP
        #expect(String(format: "The value is %.0f", 42.5) == "The value is 43") // Different rounding in Java
        #else
        #expect(String(format: "The value is %.0f", 42.5) == "The value is 42") // No effect of 0 precision on float
        #endif
    }

    @Test func randomElement() {
        #expect("".randomElement() == nil)

        let str = "abcde"
        var seen: Set<Character> = []
        for _ in 0..<100 {
            seen.insert(str.randomElement()!)
        }
        #expect(seen.count == 5)
        #expect(seen.contains("a"))
        #expect(seen.contains("e"))
    }

    @Test func shuffled() {
        let empty: [Character] = []
        #expect(empty == "".shuffled())
        let single: [Character] = ["a"]
        #expect(single == "a".shuffled())

        let str = "abcdefghij"
        let arr: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
        let shuffled = str.shuffled()
        #expect(arr != shuffled)
        #expect(Set(arr) == Set(shuffled))

        var gen: RandomNumberGenerator = SystemRandomNumberGenerator()
        let shuffled2 = str.shuffled(using: &gen)
        #expect(arr != shuffled2)
        #expect(Set(arr) == Set(shuffled2))
    }

    @Test func asciiValue() {
        #expect([UInt8(72), UInt8(101), UInt8(108), UInt8(108), UInt8(111), UInt8(32), UInt8(119), UInt8(111), UInt8(114), UInt8(108), UInt8(100), UInt8(33)] == "Hello world!".compactMap(\.asciiValue))
        #expect(Character("€").isASCII == false)
        #expect(Character("€").asciiValue == nil)

        #expect(Character("\r").isNewline == true)
        #expect(Character("\n").isNewline == true)

        #expect(UInt8(10) == Character("\r\n").asciiValue) // special case for Swift's asciiValue: "A character with the value "\r\n" (CR-LF) is normalized to "\n" (LF) and has an asciiValue property equal to 10."
    }
}
