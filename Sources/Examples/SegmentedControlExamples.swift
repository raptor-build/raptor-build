//
// SegmentedControlExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct SegmentedControlExample1: PostWidget {
    var body: some HTML {
        SegmentedControl {
            Button("General") {
                ShowElement("general")
                HideElement("advanced", "info")
            }

            Button("Advanced") {
                ShowElement("advanced")
                HideElement("general", "info")
            }

            Button("Info") {
                ShowElement("info")
                HideElement("general", "advanced")
            }
            .defaultSelection()
        }
    }
}

struct SegmentedControlExample2: PostWidget {
    var body: some HTML {
        SegmentedControl {
            InlineForEach(ColorScheme.allCases) { scheme in
                Button(
                    scheme.name,
                    action: .switchColorScheme(scheme)
                )
            }
        }
        .selectionPersisted()
    }
}
