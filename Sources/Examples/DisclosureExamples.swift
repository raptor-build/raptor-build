//
// DisclosureExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct DisclosureExample1: PostWidget {
    var body: some HTML {
        Disclosure("What is Raptor?") {
            Text("Raptor is a Swift static site generator.")
        }
        .border(.secondaryBackground)
        .padding()
        .cornerRadius(8)
    }
}

struct DisclosureExample2: PostWidget {
    var body: some HTML {
        Disclosure {
            Text("Configurable settings...")
        } label: {
            InlineText("Advanced Settings")
                .fontWeight(.bold)
        }
    }
}

struct DisclosureExample3: PostWidget {
    var body: some HTML {
        Disclosure("General", isExpanded: true) {
            Text("General settings")
        }
        .matchedTransitionEffect(id: "settings")

        Disclosure("Account") {
            Text("Account settings")
        }
        .matchedTransitionEffect(id: "settings")
    }
}

struct DisclosureExample4: PostWidget {
    private struct MyDisclosureStyle: DisclosureLabelStyle {
        func style(content: Content, phase: Phase) -> Content {
            switch phase {
            case .hovered:
                content
                    .background(.pink)
            case .opened:
                content
                    .background(.red)
            case .closed:
                content
                    .cornerRadius(8)
                    .disclosureLabelIndicator(.ellipsis)
            }
        }
    }

    var body: some HTML {
        Disclosure {
            Text("Raptor is a Swift static site generator.")
                .padding(.horizontal, 25)
                .padding(.top, 15)
        } label: {
            InlineText("What is Raptor?")
                .fontWeight(.medium)
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
        }
        .disclosureLabelStyle(MyDisclosureStyle())
    }
}
