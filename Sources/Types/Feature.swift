//
// Feature.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

enum FeatureImage: Sendable {
    case system(String)
    case asset(String)
}

struct Feature: Identifiable, Sendable {
    let id = UUID()
    let image: FeatureImage
    let title: String
    let description: String
}

extension Feature {
    static var featureSets: [[Feature]] {
        [[.init(
             image: .system("globe-americas"),
             title: "Multilingual Sites",
             description: """
             Build fully localized sites with automatic routing, locale-aware \
             content loading, and clean URLs for every supported language.
             """
         ),
         .init(
             image: .asset("/images/vapor-logo.png"),
             title: "Vapor Integration",
             description: """
             Run Raptor on Vapor for server-side rendering, dynamic routing, \
             previews, and deploying sites that scale beyond static builds.
             """
         ),
         .init(
             image: .system("search"),
             title: "Side-Wide Search",
             description: """
             Index all posts and pages automatically, enabling fast, accurate \
             search results without external services or client-side JavaScript.
             """
         )],
         [.init(
             image: .system("css"),
             title: "Framework Agnostic",
             description: """
             Raptor generates clean HTML without third-party CSS frameworks, \
             giving you full freedom over CSS, JavaScript, and styling.
             """
         ),
         .init(
             image: .system("palette"),
             title: "Highly Customizable",
             description: """
             Control layouts, themes, typography, colors, syntax highlighting, \
             and rendering behavior through a flexible, structured API.
             """
         ),
         .init(
             image: .system("journal-code"),
             title: "First-Class Docs",
             description: """
             Raptor provides thorough, well-structured documentation that’s \
             easy to read, navigate, and understand.
             """
         )]]
    }
}
