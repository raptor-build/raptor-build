//
// MainArticle.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct MainArticle: PostPage {
    @Environment(\.posts) private var posts
    var body: some HTML {
        Text(post.title)
            .font(.title1)
            .lineSpacing(1.2)
            .margin(.bottom, .medium)

        if let subtitle = post.subtitle {
            Text(subtitle)
        }

        post.text
            .definitionGroupIndent(.scaled(2.75))

        navigationButtons
            .margin(.top, .xLarge)
    }

    private var navigationButtons: some HTML {
        HStack {
            if let previousPost {
                navigationLink(label: "previous", post: previousPost)
            }

            Spacer()

            if let nextPost {
                navigationLink(label: "next", post: nextPost, alignment: .trailing)
            }
        }
    }

    private func navigationLink(
        label: String,
        post: Post,
        alignment: TextAlignment = .leading
    ) -> some HTML {
        LinkGroup(destination: post) {
            Text(label)
                .foregroundStyle(.secondary)
                .smallCaps()

            Text(post.title)
                .fontWeight(.bold)
        }
        .multilineTextAlignment(alignment)
    }

    private var currentPostIndex: Int? {
        posts.firstIndex { $0.path == post.path }
    }

    private var previousPost: Post? {
        guard let index = currentPostIndex, index > 0 else { return nil }
        return posts[index - 1]
    }

    private var nextPost: Post? {
        guard let index = currentPostIndex, index < posts.count - 1 else { return nil }
        return posts[index + 1]
    }
}
