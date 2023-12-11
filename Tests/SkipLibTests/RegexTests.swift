// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import XCTest

// note differences between ICU (Swift's impl) and Java (Kotlin's impl): https://unicode-org.github.io/icu/userguide/strings/regexp.html#differences-with-java-regular-expressions

final class RegexTests: XCTestCase {
    func testRegexMatch() throws {
        XCTAssertEqual(1, "1".matches(of: try Regex("[0-9]")).count)
        XCTAssertEqual(2, "1X1".matches(of: try Regex("[0-9]")).count)
    }

    func testRegexReplace() throws {
        XCTAssertEqual("X", "1".replacing(try Regex("[0-9]"), with: "X"))
        XCTAssertEqual("XXX", "1X1".replacing(try Regex("[0-9]"), with: "X"))
        XCTAssertEqual("1Z1", "1X1".replacing(try Regex("[A-Z]"), with: "Z"))
        XCTAssertEqual("abc", "a1b2c3".replacing(try Regex("\\d"), with: ""))
        XCTAssertEqual("1Z1", "1X1".replacing(try Regex("[A-Z]"), with: "Z"))
        XCTAssertEqual("1z1", "1x1".replacing(try Regex("[a-z]"), with: "z"))
        XCTAssertEqual("Z1X1", "!1X1".replacing(try Regex("^[^a-zA-Z0-9]"), with: "Z"))
        XCTAssertEqual("1X1Z", "1X1!".replacing(try Regex("[^a-zA-Z0-9]$"), with: "Z"))
        
        XCTAssertEqual("Hello, Alice!", "Hello, Bob!".replacing(try Regex("Hello, (\\w+)!"), with: "Hello, Alice!"))

        #if SKIP
        throw XCTSkip("regular expression support is incomplete")
        #endif

    }

    func testRegexAPI() throws {
        let re = try Regex("^\"(.*)\"[ ]*=[ ]*\"(.*)\";$")
        let check = #""X" = "1";"#

        for match in check.matches(of: re) {
            if match.count == 3,
               let key = match[1].substring,
               let value = match[2].substring {
                XCTAssertEqual("X", key.description)
                XCTAssertEqual("1", value.description)
            } else {
                XCTFail("no matches")
            }
        }
    }

    func testRegularExpresionParity() throws {
        try XCTAssertEqual(1, matches(regex: "A.*", text: "ABC"))
    }

    // tests adapted from: https://blog.robertelder.org/regular-expression-test-cases/

    func testEmailValidationRegex() throws {
        let exp = "^([a-z0-9_\\.\\-]+)@([\\da-z\\.\\-]+)\\.([a-z\\.]{2,5})$"
        try XCTAssertEqual(1, matches(regex: exp, text: "john.doe@example.com"))
        try XCTAssertEqual(1, matches(regex: exp, text: "jane_doe@example.co.uk"))
        try XCTAssertEqual(0, matches(regex: exp, text: "john.doe@.com"))
        try XCTAssertEqual(0, matches(regex: exp, text: "john.doe@example"))
    }

    func testWordsWithMultipleSuffixesRegex() throws {
        let exp = "employ(|er|ee|ment|ing|able)"
        try XCTAssertEqual(1, matches(regex: exp, text: "employee"))
        try XCTAssertEqual(1, matches(regex: exp, text: "employer"))
        try XCTAssertEqual(1, matches(regex: exp, text: "employment"))
        try XCTAssertEqual(1, matches(regex: exp, text: "employ"))
        try XCTAssertEqual(0, matches(regex: exp, text: "emplox"))
    }

    func testHashValidationRegex() throws {
        let exp = "^[a-f0-9]{32}$"
        try XCTAssertEqual(1, matches(regex: exp, text: "5d41402abc4b2a76b9719d911017c592"))
        try XCTAssertEqual(1, matches(regex: exp, text: "e4da3b7fbbce2345d7772b0674a318d5"))
        try XCTAssertEqual(0, matches(regex: exp, text: "5d41402abc4b2a76b9719d911017c59"), "31 characters")
        //try XCTAssertEqual(0, matches(regex: exp, text: "5d41402abc4b2a76b9719d911017c5921"), "33 characters")
    }

    func testXMLTagRegex() throws {
        let exp = "<tag>[^<]*</tag>"
        try XCTAssertEqual(1, matches(regex: exp, text: "<tag>Content</tag>"))
        try XCTAssertEqual(1, matches(regex: exp, text: "<tag></tag>"))
        try XCTAssertEqual(0, matches(regex: exp, text: "<tag><nested>Content</nested></tag>"))
        try XCTAssertEqual(0, matches(regex: exp, text: "<tag attr=\"value\">Content</tag>"))
    }

    func testCharacterClassesRegex() throws {
        try XCTAssertEqual(1, matches(regex: "日本国", text: "日本国"))
        try XCTAssertEqual(0, matches(regex: "\\s", text: "日本国"))
        try XCTAssertEqual(3, matches(regex: ".", text: "日本国"))

        #if false // Failing in CI
        #if SKIP
        try XCTAssertEqual(0, matches(regex: "\\w", text: "日本国"))
        #else
        try XCTAssertEqual(3, matches(regex: "\\w", text: "日本国"))
        #endif
        #endif

        //try XCTAssertEqual(1, matches(regex: "[^]", text: "XXX"), "Similar to the empty character class '[]', but a bit more useful. This case would be interpreted as 'any character NOT in the following empty list'. Therefore, this would mean 'match any possible character'.")
        //try XCTAssertEqual(1, matches(regex: "[.]", text: "XXX"), "Test to make sure that period inside a character class is interpreted as a literal period character.")
        //try XCTAssertEqual(1, matches(regex: "[^.]", text: "XXX"), "Another test to make sure that period inside a character class is interpreted as a literal period character.")
    }

    func testErrorRegex() throws {
        XCTAssertEqual(nil, try? matches(regex: "[]", text: "XXX"), "This case represents an 'empty' character class. Many regular expression engines don't allow this since it's almost certainly a mistake to write this. The only meaningful interpretation would be to mean 'match a character that that belongs to this empty list of characters'. In order words it represents the impossible constraint of being a character that isn't any character.")
        XCTAssertEqual(nil, try? matches(regex: "[b-a]", text: ""), "Range endpoints out of order. This case should cause an error.")
        XCTAssertEqual(nil, try? matches(regex: "[a-\\w]", text: ""), "Range endpoints should not be 'sets' of characters. This case should cause an error.")
        XCTAssertEqual(nil, try? matches(regex: "[a-\\d]", text: ""), "Range endpoints should not be 'sets' of characters. This case should cause an error.")
    }

    private func matches(regex expressionString: String, text: String) throws -> Int {
        try text.matches(of: Regex(expressionString)).count
    }

}
