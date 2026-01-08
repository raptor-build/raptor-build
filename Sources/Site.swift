//
// Site.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor
import Foundation

@main
struct RaptorWebsite {
    static func main() async {
        var site = MySite()
        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MySite: Site {
    var name = "Raptor | Swift Static Site Generator with Server-Side Rendering"
    var url = URL(static: "https://raptor.build")
    var description: String? = """
    Raptor is a modern Swift static site generator with built-in support \
    for blog posts, multilingual sites, and server-side rendering via Vapor.
    """

    var layout = MainLayout()
    var themes: [any Theme] = [MainTheme()]
    var feedConfiguration: FeedConfiguration?
    var postProcessor = PandocProcessor()

    var homePage = Home()
    var searchPage = MySearchPage()

    var postPages: [any PostPage] {
        MainArticle()
    }

    var postWidgets: [any PostWidget] {
        ReferenceWidget()
        AlertWidget()
        ImportantWidget()
        GridExample1()
        GridExample2()
        GridExample3()
        GridExample4()
        GridExample5()
        FormExample1()
        FormExample2()
        FormExample3()
        FormExample4()
        FormExample5()
        CodeExample1()
        DisclosureExample1()
        DisclosureExample2()
        DisclosureExample3()
        DisclosureExample4()
        ImageExample1()
        EmbedExample1()
        ButtonExample1()
        ButtonExample2()
        ButtonExample3()
        LinkExample1()
        MenuExample1()
        MenuExample2()
        MenuExample3()
        MenuExample4()
        SegmentedControlExample1()
        SegmentedControlExample2()
        ScrollViewExample1()
        ScrollViewExample2()
        ScrollViewExample3()
        ScrollViewExample4()
        ScrollViewExample5()
        ScrollViewExample6()
        TableExample1()
        TableExample2()
        TableExample3()
        TableExample4()
        TableExample5()
        TableExample6()
        TableExample7()
        FrameExample1()
        FrameExample2()
        FrameExample3()
        FrameExample4()
        OverlayExample1()
        OverlayExample2()
        ListExample1()
        ListExample2()
        ListExample3()
        ModalExample1()
        ModalExample2()
        PopoverExample1()
        AnimationExample1()
        AnimationExample2()
        AnimationExample3()
        AnimationExample4()
        AnimationExample5()
        HoverEffectExample1()
        EntryEffectExample1()
        EnvironmentEffectExample1()
        IdentityEffectExample1()
    }
}
