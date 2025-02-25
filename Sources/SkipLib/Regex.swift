// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
#if SKIP
public protocol RegexComponent<RegexOutput> {
    //associatedtype RegexOutput // in Swift but not Kotlin

    /// The regular expression represented by this component.
    var regex: Regex { get }
}

/// Kotlin representation of `Swift.Regex`.
public struct Regex : RegexComponent {
    private let _regex: kotlin.text.Regex

    public typealias RegexOutput = String

    public init(_ string: String) {
        _regex = kotlin.text.Regex(string, RegexOption.MULTILINE)
    }

    public var regex: Self { self }

    /// The result of matching a regular expression against a string.
    public struct Match {
        /// The range of the overall match.
        // public let range: Range<String.Index>

        fileprivate let match: kotlin.text.MatchResult

        public var count: Int {
            match.groups.size
        }

        public subscript(index: Int) -> MatchGroup {
            MatchGroup(group: match.groups.get(index))
        }

        public struct MatchGroup {
            fileprivate let group: kotlin.text.MatchGroup?

            // val range: IntRange

            public var substring: Substring? {
                if let group = group {
                    return Substring(group.value, 0)
                } else {
                    return nil
                }
            }
        }
    }

    public func matches(_ string: String) -> [Match] {
        var matches: [Match] = []
        for match in _regex.findAll(string) {
            matches.append(Match(match: match))
        }
        return matches
    }

    public func replace(_ string: String, with replacement: String) -> String {
        return _regex.replace(string, replacement)
    }
}

#endif
