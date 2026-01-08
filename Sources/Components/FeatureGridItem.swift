//
// FeatureGridItem.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct FeatureGridItem: HTML {
    let image: FeatureImage
    let title: String
    let description: String

    var body: some HTML {
        VStack(alignment: .leading) {
            switch image {
            case .system(let name):
                Image(systemName: name)
                    .font(.system(.title5, size: 45))

            case .asset(let path):
                Image(decorative: path)
                    .resizable()
                    .frame(maxHeight: 50)
            }

            Text(title)
                .font(.title5)
                .margin(.vertical, 10)

            Text(description)
                .lineSpacing(1.15)
        }
        .background(.ultraThinMaterial)
        .border(.primary.opacity(0.15))
        .cornerRadius(20)
        .containerRelativeFrame(.vertical)
        .padding(15)
        .hoverEffect { content in
            content.scaleEffect(1.025)
        }
    }
}
