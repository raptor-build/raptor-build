//
// ScrollViewExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ScrollViewExample1: PostWidget {
    var body: some HTML {
        ScrollView(id: "features") {
            Color.blue
            Color.red
            Color.yellow
        }
        .scrollViewItemSizing(.flexible)
        .frame(height: 150)
    }
}

struct ScrollViewExample2: PostWidget {
    var body: some HTML {
        ScrollView(.vertical, id: "features") {
            Color.blue
                .frame(height: 150)
            Color.red
                .frame(height: 150)
            Color.yellow
                .frame(height: 150)
        }
        .frame(height: 150)
    }
}

struct ScrollViewExample3: PostWidget {
    var body: some HTML {
        ScrollView(id: "features") {
            Color.blue
                .frame(width: 500)
            Color.red
                .frame(width: 500)
            Color.yellow
                .frame(width: 500)
        }
        .scrollBehavior(.viewAligned(.center))
        .frame(height: 150)
    }
}

struct ScrollViewExample4: PostWidget {
    var body: some HTML {
        ScrollView(id: "features") {
            Color.blue
                .frame(width: 500)
            Color.red
                .frame(width: 500)
            Color.yellow
                .frame(width: 500)
        }
        .scrollBehavior(.viewAligned(.center))
        .autoAdvance(every: 4.0, loops: true)
        .frame(height: 150)
    }
}

struct ScrollViewExample5: PostWidget {
    var body: some HTML {
        ScrollView(id: "features") {
            Color.blue
                .frame(width: 500)
            Color.red
                .frame(width: 500)
            Color.yellow
                .frame(width: 500)
        }
        .continuousScroll(duration: 15)
        .frame(height: 150)
    }
}

struct ScrollViewExample6: PostWidget {
    var body: some HTML {
        ScrollView(id: "myScrollView") {
            Color.blue
            Color.red
            Color.yellow
        }
        .scrollViewItemSizing(.flexible)
        .frame(height: 150)
        .margin(.bottom)

        HStack {
            Button("Last", action: .scrollBackward(in: "myScrollView"))
            Spacer()
            Button("Next", action: .scrollForward(in: "myScrollView"))
        }
    }
}
