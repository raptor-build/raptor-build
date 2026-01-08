//
// MediaExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ImageExample1: PostWidget {
    let icons = [
        "airplane",
        "apple",
        "arrow-counterclockwise",
        "award",
        "balloon",
        "book",
        "brightness-high"
    ]

    let fonts = Font.Style.allCases

    let colors: [Color] = [
        .green,
        .blue,
        .indigo,
        .gray,
        .yellow,
        .orange,
        .pink
    ]

    var body: some HTML {
        Text {
            InlineForEach(
                Array(zip(icons, zip(fonts, colors)))
            ) { icon, pair in
                let (font, color) = pair

                Image(systemName: icon)
                    .font(font)
                    .foregroundStyle(color)
                    .margin(.trailing, 20)
            }
        }
    }
}

struct EmbedExample1: PostWidget {
    var body: some HTML {
        Embed(title: "Website title", source: .youtube(id: "0_DjDdfqtUE"))
            .aspectRatio(.r16x9)
    }
}
