//
// ButtonExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ButtonExample1: PostWidget {
    let styles = PrimitiveButtonStyle.allCases
    let sizes = ControlSize.allCases
    let shapes = ButtonShape.allCases
    let colors: [Color] = [.blue, .indigo, .purple, .pink, .red]

    var body: some HTML {
        ForEach(styles.indices) { index in
            Button("Tap!", action: SubmitAction())
                .buttonStyle(styles[index])
                .controlSize(sizes[index % sizes.count])
                .buttonShape(shapes[index % shapes.count])
                .tint(colors[index % colors.count])
                .margin(.trailing, 20)
        }
    }
}

struct ButtonExample2: PostWidget {
    var body: some HTML {
        HStack(spacing: 10) {
            ForEach(ButtonIconPlacement.allCases) { placement in
                Button("Settings", systemImage: "gear-fill", action: SubmitAction())
                    .buttonIconPlacement(placement)
                    .buttonSizing(.flexible)
                    .tint(.gray)
            }
        }
    }
}

struct ButtonExample3: PostWidget {
    private struct PrimaryButtonStyle: ButtonStyle {
        func style(content: Content, phase: Phase) -> Content {
            switch phase {
            case .initial:
                content
                    .background(.red)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
            case .hovered:
                content.background(.pink)
            case .pressed:
                content.background(.orange)
            case .disabled:
                content.background(.gray)
            }
        }
    }

    var body: some HTML {
        Button("Submit", action: SubmitAction())
            .buttonSizing(.flexible)
            .buttonStyle(PrimaryButtonStyle())
    }
}
