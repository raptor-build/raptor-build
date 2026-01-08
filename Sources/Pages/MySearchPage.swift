//
// MySearchPage.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct MySearchPage: SearchPage {
    var body: some HTML {
        if searchResults.isEmpty {
            Text("No results were found for “\(searchText)”")
                .multilineTextAlignment(.center)
        } else {
            Group {
                Text("Results for “\(searchText)”")
                    .multilineTextAlignment(.center)
                ForEach(searchResults) { result in
                    Section {
                        result.title
                            .font(.title4)
                            .margin(.bottom, .xSmall)
                        result.description
                    }
                    .background(.background)
                    .padding()
                    .margin(.top)
                    .cornerRadius(15)
                    .hoverEffect { content in
                        content.scaleEffect(1.025)
                    }
                }
            }
        }
    }
}
