//
// AnimationExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct AnimationExample1: PostWidget {
    var body: some HTML {
        Disclosure("What is this?") {
            Text("Click above to reveal this text!")
        }
        .animation(.bouncy.speed(0.5))
    }
}

struct AnimationExample2: PostWidget {
    var body: some HTML {
        Disclosure("What is this?") {
            Text("Click above to reveal this text!")
        }
        .animation(nil)
    }
}

struct AnimationExample3: PostWidget {
    var body: some HTML {
        VStack {
            Image(systemName: "balloon")
                .font(.system(size: 50))
                .keyframeAnimator(trigger: .tap) { content, percent in
                    if percent == 0% {
                        content
                            .scaleEffect(1 + percent.value * 0.5)
                            .opacity(1)
                    } else if percent == 100% {
                        content
                            .scaleEffect(2)
                            .opacity(0)
                    }
                }
        }
    }
}

struct AnimationExample4: PostWidget {
    var body: some HTML {
        VStack {
            Image(systemName: "balloon")
                .font(.system(size: 50))
                .keyframeAnimator(
                    trigger: .hover,
                    options: [
                        .duration(2),
                        .timingCurve(.bouncy),
                        .repeatCount(.infinity),
                        .lifecycle(.automatic),
                        .direction(.forward.reversing())
                    ]
                ) { content, percent in
                    if percent == 0% {
                        content
                            .scaleEffect(1 + percent.value * 0.5)
                            .foregroundStyle(.red)
                    } else if percent == 100% {
                        content
                            .scaleEffect(2)
                            .foregroundStyle(.blue)
                    }
                }
        }
    }
}

struct AnimationExample5: PostWidget {
    var body: some HTML {
        VStack {
            Color.blue
                .frame(width: 50, height: 50)
                .keyframeAnimator(
                    trigger: .entry,
                    anchor: .topLeading
                ) { content, percent in
                    if percent == 0% {
                        content
                            .scaleEffect(1)
                    } else if percent == 100% {
                        content
                            .scaleEffect(3)
                    }
                }
        }
    }
}
