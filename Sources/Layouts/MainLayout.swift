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

            Link("Download", destination: "https://github.com/raptor-build/raptor")
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
            .background(background)
            .preferredColorScheme(colorScheme)

        Footer {
            Group {
                Text("© 2026 Tailored Swift LLC")
                Text("""
                Licensed under Creative Commons Attribution 4.0 International (CC-BY-4.0).
                """)
                .margin(.bottom, 25)
            }
            .font(.xxSmall)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
        }
    }
}
