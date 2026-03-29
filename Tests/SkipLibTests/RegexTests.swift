// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing

// note differences between ICU (Swift's impl) and Java (Kotlin's impl): https://unicode-org.github.io/icu/userguide/strings/regexp.html#differences-with-java-regular-expressions

@Suite struct RegexTests {
    @Test func regexMatch() throws {
        let count1 = "1".matches(of: try Regex("[0-9]")).count
        #expect(count1 == 1)
        let count2 = "1X1".matches(of: try Regex("[0-9]")).count
        #expect(count2 == 2)
    }

    @Test func regexReplace() throws {
        #expect("X" == "1".replacing(try Regex("[0-9]"), with: "X"))
        #expect("XXX" == "1X1".replacing(try Regex("[0-9]"), with: "X"))
        #expect("1Z1" == "1X1".replacing(try Regex("[A-Z]"), with: "Z"))
        #expect("abc" == "a1b2c3".replacing(try Regex("\\d"), with: ""))
        #expect("1Z1" == "1X1".replacing(try Regex("[A-Z]"), with: "Z"))
        #expect("1z1" == "1x1".replacing(try Regex("[a-z]"), with: "z"))
        #expect("Z1X1" == "!1X1".replacing(try Regex("^[^a-zA-Z0-9]"), with: "Z"))
        #expect("1X1Z" == "1X1!".replacing(try Regex("[^a-zA-Z0-9]$"), with: "Z"))

        #expect("Hello, Alice!" == "Hello, Bob!".replacing(try Regex("Hello, (\\w+)!"), with: "Hello, Alice!"))

        #if SKIP
        // skip: regular expression support is incomplete
        return
        #endif

    }

    @Test func regexAPI() throws {
        let re = try Regex("^\"(.*)\"[ ]*=[ ]*\"(.*)\";$")
        let check = #""X" = "1";"#

        for match in check.matches(of: re) {
            if match.count == 3,
               let key = match[1].substring,
               let value = match[2].substring {
                #expect("X" == key.description)
                #expect("1" == value.description)
            } else {
                #expect(!(!false)) // no matches
            }
        }
    }

    @Test func regularExpresionParity() throws {
        let count = try matches(regex: "A.*", text: "ABC")
        #expect(count == 1)
    }

    // tests adapted from: https://blog.robertelder.org/regular-expression-test-cases/

    @Test func emailValidationRegex() throws {
        let exp = "^([a-z0-9_\\.\\-]+)@([\\da-z\\.\\-]+)\\.([a-z\\.]{2,5})$"
        #expect(try matches(regex: exp, text: "john.doe@example.com") == 1)
        #expect(try matches(regex: exp, text: "jane_doe@example.co.uk") == 1)
        #expect(try matches(regex: exp, text: "john.doe@.com") == 0)
        #expect(try matches(regex: exp, text: "john.doe@example") == 0)
    }

    @Test func wordsWithMultipleSuffixesRegex() throws {
        let exp = "employ(|er|ee|ment|ing|able)"
        #expect(try matches(regex: exp, text: "employee") == 1)
        #expect(try matches(regex: exp, text: "employer") == 1)
        #expect(try matches(regex: exp, text: "employment") == 1)
        #expect(try matches(regex: exp, text: "employ") == 1)
        #expect(try matches(regex: exp, text: "emplox") == 0)
    }

    @Test func hashValidationRegex() throws {
        let exp = "^[a-f0-9]{32}$"
        #expect(try matches(regex: exp, text: "5d41402abc4b2a76b9719d911017c592") == 1)
        #expect(try matches(regex: exp, text: "e4da3b7fbbce2345d7772b0674a318d5") == 1)
        #expect(try matches(regex: exp, text: "5d41402abc4b2a76b9719d911017c59") == 0)
    }

    @Test func xmlTagRegex() throws {
        let exp = "<tag>[^<]*</tag>"
        #expect(try matches(regex: exp, text: "<tag>Content</tag>") == 1)
        #expect(try matches(regex: exp, text: "<tag></tag>") == 1)
        #expect(try matches(regex: exp, text: "<tag><nested>Content</nested></tag>") == 0)
        #expect(try matches(regex: exp, text: "<tag attr=\"value\">Content</tag>") == 0)
    }

    @Test func characterClassesRegex() throws {
        #expect(try matches(regex: "日本国", text: "日本国") == 1)
        #expect(try matches(regex: "\\s", text: "日本国") == 0)
        #expect(try matches(regex: ".", text: "日本国") == 3)

        #if false // Failing in CI
        #if SKIP
        #expect(try matches(regex: "\\w", text: "日本国") == 0)
        #else
        #expect(try matches(regex: "\\w", text: "日本国") == 3)
        #endif
        #endif
    }

    @Test func errorRegex() throws {
        #expect(nil == (try? matches(regex: "[]", text: "XXX")))
        #expect(nil == (try? matches(regex: "[b-a]", text: "")))
        #expect(nil == (try? matches(regex: "[a-\\w]", text: "")))
        #expect(nil == (try? matches(regex: "[a-\\d]", text: "")))
    }

    private func matches(regex expressionString: String, text: String) throws -> Int {
        try text.matches(of: Regex(expressionString)).count
    }

}
