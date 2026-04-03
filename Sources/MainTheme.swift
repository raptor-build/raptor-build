//
// MainTheme.swift
// Raptor.build
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

extension Font {
    static let advocate = Font(name: "Advocate") {
        FontSource(file: "Advocate-Regular.woff2", weight: .regular)
        FontSource(file: "Advocate-Medium.woff2", weight: .medium)
        FontSource(file: "Advocate-Bold.woff2", weight: .bold)
    }

    static let mdIO = Font(name: "MDIO") {
        FontSource(file: "MDIO-Regular.woff2", weight: .regular)
        FontSource(file: "MDIO-Bold.woff2", weight: .bold)
    }
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
