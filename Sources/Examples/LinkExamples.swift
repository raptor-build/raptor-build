//
// LinkExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct LinkExample1: PostWidget {
    private struct UnderlinedLinkStyle: LinkStyle {
        func style(content: Content, phase: Phase) -> Content {
           if phase == .hovered {
              content.underline(pattern: .dotted)
           }
        }
    }

    var body: some HTML {
        Link("Hover me", destination: "#")
           .linkStyle(UnderlinedLinkStyle())
    }
}
