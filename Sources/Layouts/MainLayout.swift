//
// MainLayout.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct MainLayout: Layout {
    @Environment(\.themes) private var themes
    var background: Gradient?
    var colorScheme: SystemColorScheme?

    private var navigationBar: some Region {
        Navigation {
            Label {
                InlineText("Raptor".uppercased())
                    .font(.custom("Advocate", size: 20, weight: .bold))
            } icon: {
                Image("images/raptor-logo.svg", description: "Raptor static site generator logo")
                    .resizable()
                    .frame(height: 20)
            }
            .iconPlacement(.trailing)
            .labelIconToTitleSpacing(5)
            .navigationItemRole(.logo)

            Spacer()
            Link(destination: "https://github.com/raptor-build/raptor") {
                Label("GitHub", systemImage: "github")
                    .labelIconToTitleSpacing(5)
            }
            .linkStyle(.button)
            .linkOpenBehavior(.newWindow)
            .buttonShape(.capsule)
            .buttonStyle(.filledProminent)
            .controlSize(.small)
            .margin(.trailing, -8)
        }
        .margin(.vertical, 25)
        .position(.fixedTop)
        .background(.thinMaterial)
        .cornerRadius(999)
        .border(.gray.opacity(0.2))
        .navigationBarSizing(.contentArea)
        .preferredColorScheme(colorScheme)
    }

    var body: some Document {
        navigationBar

        Main()
            .margin(.bottom, 100)
            .environmentEffect(\.horizontalSizeClass) { content, sizeClass in
                if let background, sizeClass > .compact {
                    content.background(background)
                }
            }
            .preferredColorScheme(colorScheme)
            .shareLinkImage("https://raptor.build/images/raptor-share.png?v=0.1.2")
            .shareLinkDescription("A SwiftUI-inspired framework for building type-safe websites in Swift.")
            .analytics(.plausible(siteID: "gF6rd0TQFgBuEy9hdr44W"))

        Footer {
            Group {
                Text("© 2026 The Raptor Authors")
                    .foregroundStyle(.white)
                Text("SwiftUI is a trademark of Apple Inc. and has no affiliation with Raptor.")
                    .foregroundStyle(.white.opacity(0.75))
                Text(" Licensed under Creative Commons Attribution 4.0 International (CC-BY-4.0)")
                    .foregroundStyle(.white.opacity(0.75))
                Text {
                    Link("raptor.build source code ↗", destination: "https://github.com/raptor-build/raptor-build")
                        .linkOpenBehavior(.newWindow)
                        .tint(.white.opacity(0.75))
                }
                .margin(.bottom, 25)
            }
            .font(.xxSmall)
            .multilineTextAlignment(.center)
        }
    }
}
