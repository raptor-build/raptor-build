//
// FrameExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct FrameExample1: PostWidget {
    var body: some HTML {
        VStack(alignment: .center) {
            Section {
                Text("Aligned")
                    .border(.accent)
                    .frame(width: 200, height: 200, alignment: .center)
            }
            .fixedSize()
            .border(.blue, style: .dotted)
        }
    }
}

struct FrameExample2: PostWidget {
    var body: some HTML {
        Text("Half width")
            .background(.red)
            .padding()
            .containerRelativeFrame(width: 50%)
    }
}

struct FrameExample3: PostWidget {
    var body: some HTML {
        Text("Full width")
            .background(.blue)
            .padding()
            .containerRelativeFrame(.horizontal)
    }
}

struct FrameExample4: PostWidget {
    var body: some HTML {
        Text("Edge to edge")
            .background(.gray.weighted(.darkest))
            .padding(.vertical)
            .multilineTextAlignment(.center)
            .backgroundExtensionEffect()
    }
}

struct OverlayExample1: PostWidget {
    var body: some HTML {
        VStack {
            Color.red
                .frame(width: 100, height: 100)
                .overlay(alignment: .bottomTrailing) {
                    Text("Caption")
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.6))
                }
        }
    }
}

struct OverlayExample2: PostWidget {
    var body: some HTML {
        Text("Find me at the bottom right!")
            .fullScreenOverlay(alignment: .bottomTrailing) {
                Image(systemName: "emoji-smile")
                    .padding(20)
                    .margin(.trailing, 20)
                    .background(.black)
                    .cornerRadius(8)
                    .foregroundStyle(.white)
            }
    }
}
