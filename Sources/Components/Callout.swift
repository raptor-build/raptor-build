//
// Callout.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct Callout: HTML {
    var color: Color
    var content: String
    var body: some HTML {
        Text(markdown: content)
            .padding(.horizontal)
            .padding(.small)
            .cornerRadius(8)
            .environmentEffect(\.colorScheme) { content, colorScheme in
                content
                    .background(color.opacity(colorScheme == .light ? 0.1 : 0.25))
                    .border(color.opacity(colorScheme == .light ? 0.2 : 0.3))
            }
    }
}
