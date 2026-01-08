//
// EffectExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct HoverEffectExample1: PostWidget {
    var body: some HTML {
        LinkGroup(destination: "#") {
            Text("Effects")
                .font(.title3)

            Text("Use effects to add motion, interaction, and state-aware behavior to your views.")
        }
        .background(.red)
        .padding()
        .cornerRadius(8)
        .hoverEffect { content in
            content.scaleEffect(1.025)
        }
        .opaqueMarkupGroup()
    }
}

struct EntryEffectExample1: PostWidget {
    var body: some HTML {
        VStack {
            Color.blue
                .frame(width: 200, height: 200)
                .scaleEffect(0.5, anchor: .center)
                .entryEffect(anchor: .bottomLeading) { content in
                    content
                        .scaleEffect(1)
                }
        }
    }
}

struct EnvironmentEffectExample1: PostWidget {
    var body: some HTML {
        VStack {
            Color.pink
                .frame(height: 100)
                .environmentEffect(\.horizontalSizeClass) { content, sizeClass in
                    if sizeClass == .compact {
                        content.background(.yellow)
                    }
                }
        }
    }
}

struct IdentityEffectExample1: PostWidget {
    struct BackgroundTrait: IdentityTrait {}
    var body: some HTML {
        HStack(spacing: 25) {
            Button("Toggle Color", action: .toggleIdentityTrait(BackgroundTrait.self, for: "myID"))
            Color.clear
                .frame(height: 75)
                .id("myID")
                .identityEffect(BackgroundTrait.self) { content in
                    content.background(.indigo)
                }
        }
    }
}
