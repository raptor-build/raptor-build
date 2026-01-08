//
// MainTheme.swift
// Raptor.build
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

extension Font {
    static let advocate = Font(
        name: "Advocate",
        sources:
        FontSource(url: URL(static: "/fonts/Advocate-Regular.woff2"), weight: .regular),
        FontSource(url: URL(static: "/fonts/Advocate-Medium.woff2"), weight: .medium),
        FontSource(url: URL(static: "/fonts/Advocate-Bold.woff2"), weight: .bold)
    )

    static let mdIO = Font(
        name: "MDIO",
        sources:
        FontSource(url: URL(static: "/fonts/MDIO-Regular.woff2"), weight: .regular),
        FontSource(url: URL(static: "/fonts/MDIO-Bold.woff2"), weight: .bold)
    )
}

struct MainTheme: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        if colorScheme == .dark {
            site
        } else {
            site
                .codeFont(.mdIO)
                .inlineCodeStyle(InlineCode())
                .syntaxHighlighterTheme(.xcode)
                .contentWidth(max: 800)
                .accent(.red)
        }
    }
}
