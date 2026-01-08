//
// ListExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ListExample1: PostWidget {
    var body: some HTML {
        List {
           "First item"
           "Second item"
           "Third item"
        }
    }
}

struct ListExample2: PostWidget {
    let tasks = ["Design", "Build", "Test", "Deploy"]
    var body: some HTML {
        List(tasks) { task in
           task
        }
    }
}

struct ListExample3: PostWidget {
    var body: some HTML {
        List {
           Text("Styled row")
               .listRowBackground(.blue.opacity(0.1))
               .listRowInsets(12)
               .listRowCornerRadius(8)
               .listRowBorder(.blue, edges: .bottom)
               .listRowSpacing(8)
        }
        .listMarkerStyle(.custom("⭐️"))
    }
}
