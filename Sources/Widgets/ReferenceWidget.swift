//
// ReferenceWidget.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ReferenceWidget: PostWidget {
    @WidgetContent(default: "To be replaced...") var content
    var body: some HTML {
        Code(content, language: .swift)
            .syntaxHighlighterTheme(.appleInline)
    }
}
