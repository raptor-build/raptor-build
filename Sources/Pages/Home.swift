//
// Home.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct Home: Page {
    var title = "Raptor | Swift Static Site Generator with Server-Side Rendering"

    var layout = MainLayout(
        background: .linearGradient(colors: .red, .black, from: .bottomLeading, to: .topTrailing),
        colorScheme: .dark
    )

    @Environment(\.posts) private var posts

    var body: some HTML {
        heroSection
        apiExample
        featureGrid
        documentationSection
    }

    private var heroSection: some HTML {
        ZStack {
            Image(decorative: "images/raptor-logo.svg")
                .resizable()
                .frame(maxHeight: 350)
                .foregroundStyle(.white.opacity(0.15))
            VStack(alignment: .center) {
                Group {
                    Text("RAPTOR")
                        .font(.custom("Advocate", style: .title1, size: 100, weight: .bold))
                        .lineSpacing(1)

                    Text("a Swift framework for static sites and server-side rendering")
                        .font(.title4)
                        .fontWeight(.regular)
                        .margin(.bottom, 25)
                }
                .multilineTextAlignment(.center)

                Link("Get Started", destination: "/getting-started")
                    .linkStyle(.button)
                    .buttonStyle(.filledProminent)
                    .buttonShape(.capsule)
                    .controlSize(.xLarge)
            }
            .frame(minHeight: 450, alignment: .center)
        }
    }

    @HTMLBuilder
    private var apiExample: some HTML {
        Text("Create a type-safe website with less than 15 lines of code.")
            .multilineTextAlignment(.center)
            .font(.title3)
            .margin(.bottom, 15)

        CodeBlock(.swift) {
            """
            struct MySite: Site {
                var name = "Raptor | Swift Static Site Generator"
                var url = URL(static: "https://raptor.build")
                var layout = MainLayout()
                var homePage = Home()
            }

            struct Home: Page {
                var title = "Home"
                var body: some HTML {
                    Text("Welcome to Raptor")
                }
            }
            """
        }
        .lineNumberVisibility(.visible)
        .margin(.bottom, 50)
    }

    @HTMLBuilder
    private var featureGrid: some HTML {
        Text("Powerful Features".uppercased())
            .font(.custom("Advocate", style: .title2))
            .margin(.bottom, 15)

        Grid(Feature.featureSets, alignment: .top) { featureSet in
            GridRow {
                ForEach(featureSet) { feature in
                    FeatureGridItem(
                        image: feature.image,
                        title: feature.title,
                        description: feature.description
                    )
                }
            }
        }
    }

    @HTMLBuilder
    private var documentationSection: some HTML {
        Text("Documentation".uppercased())
            .font(.custom("Advocate", style: .title2))
            .margin(.bottom, 15)
            .margin(.top, 50)

        ControlGroup {
            SearchField()
        }
        .controlShape(.capsule)
        .containerRelativeFrame(.horizontal)
        .controlSize(.xLarge)
        .margin(.bottom, .large)

        Grid(posts.prefix(5)) { post in
            postPreview(post)
        }
        .margin(.bottom, 25)

        Button("View More", action: .toggleElementVisibility("postOverflow", "moreButton"))
            .id("moreButton")
            .buttonShape(.capsule)
            .buttonSizing(.flexible)

        Grid(posts.dropFirst(5)) { post in
            postPreview(post)
        }
        .hidden()
        .id("postOverflow")
    }

    private func postPreview(_ post: Post) -> some HTML {
        GridRow {
            LinkGroup(destination: post) {
                Text(post.title)
                    .font(.title3)

                Text(post.description)
            }
            .background(.ultraThinMaterial)
            .border(.primary.opacity(0.15))
            .cornerRadius(15)
            .padding()
            .hoverEffect { content in
                content.scaleEffect(1.025)
            }
        }
    }
}
