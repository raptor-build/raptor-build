//
// CodeExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct CodeExample1: PostWidget {
    var body: some HTML {
        CodeBlock(.swift) {
            """
            let value = compute()
            print(value)
            """
        }
        .lineNumberVisibility(.visible)
        .whitespaceCharacterVisibility(.visible)
        .highlightedLines(2)
        .syntaxHighlighterTheme(.monokai)
    }
}
