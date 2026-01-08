//
// MenuExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct MenuExample1: PostWidget {
    var body: some HTML {
        VStack(alignment: .center) {
            Menu("Settings", systemImage: "gear-fill") {
                Button("Profile", action: SubmitAction())
                Link("Help", destination: "#")
            }
            .tint(.blue)
        }
        .margin(.bottom, 25)
    }
}

struct MenuExample2: PostWidget {
    var body: some HTML {
        VStack(alignment: .center) {
            Menu("More", systemImage: "three-dots") {
                Button("Settings", action: SubmitAction())
                Button("Pin", systemImage: "pin", action: SubmitAction())
            }
            .menuActionDismissBehavior(.disabled)
            .dropdownAnchor(.bottomTrailing)
        }
        .margin(.bottom, 25)
    }
}

struct MenuExample3: PostWidget {
    var body: some HTML {
        VStack(alignment: .center) {
            Menu(
                "Download",
                systemImage: "download",
                primaryAction: SubmitAction()
            ) {
                Button("Download as ZIP", action: SubmitAction())
                Button("Download as PDF", action: SubmitAction())
            }
        }
        .margin(.bottom, 25)
    }
}

struct MenuExample4: PostWidget {
    private struct ContextMenuStyle: MenuDropdownStyle {
        func style(content: Content) -> Content {
            content
                .background(.gray.opacity(0.5))
                .border(.primary.opacity(0.15))
                .cornerRadius(0)
                .dropdownItemCornerStyle(.square)
        }
    }

    var body: some HTML {
        VStack(alignment: .center) {
            Menu("Options") {
                Button("Edit", action: SubmitAction())
                Button("Delete", action: SubmitAction())
            }
            .menuDropdownStyle(ContextMenuStyle())
        }
        .margin(.bottom, 25)
    }
}
