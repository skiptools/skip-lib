// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
import Testing
#if !SKIP
@testable import SkipLib
#endif

@Test func skipLibModuleName() throws {
    #expect(3 == 1 + 2)
    #expect("SkipLib" == SkipLibInternalModuleName())
    #expect("SkipLib" == SkipLibPublicModuleName())
}

@Suite struct SkipLibTests {
    @Test func unitTests() throws {
        // test the various test assertions and ensure the JUnit implementations match the XCUnit ones
        #expect(1 == 1)

        #expect(1 != 2)

        #expect(1 >= 1)

        #expect(2 > 1)

        #expect(1 <= 1)

        #expect(1 < 2)
    }

    @Test func fatalError() throws {
        if ({ false }()) {
            Swift.fatalError("this is a fatal error")
        }

        if ({ false }()) {
            Swift.fatalError() // no-arg
        }
    }
}

#if !SKIP
public struct DemoStruct {
    public let publicInt: Int = 1
    private var privateOptionalString: String?
    private var impliedDouble = (1.234 * 1)
}
#endif
