---
title: Elements
date: 2025-12-20 23:44
description: Learn how Raptor elements work, including composition, nesting, modifiers, and reusable components for building structured HTML pages.
---

In Raptor, everything you render is built from elements. Elements describe pieces of HTML—text, images, layouts, controls—and they're designed to be highly composable.

If you know SwiftUI, the programming model will feel natural—Raptor uses the same declarative, composition-based approach for building web pages.

## Elements and Composition

Most of the time, you work with concrete element types like `Text`, `Image`, `Section`, or `Link`. These types conform to Raptor's internal protocols, but you rarely need to think about that—what matters is how they compose.

A page's content is defined by returning elements from `body`:

```swift
var body: some HTML {
   Text("Hello, world!")
}
```

You can return multiple sibling elements simply by listing them:

```swift
var body: some HTML {
   Text("Title")
   Text("Subtitle")
}
```

This produces multiple elements at the same level in the output HTML.

---

## Nesting Elements

Elements can contain other elements. Layout elements exist primarily to group and arrange their children:

```swift
VStack {
   Text("Welcome")
   Text("This is Raptor.")
}
```

There's no hard distinction between "layout code" and "content code"—everything is just elements composed together.

---

## Modifiers

Modifiers let you adjust layout, appearance, and behavior without changing the structure of your elements:

```swift
Text("Get Started")
   .font(.title3)
   .margin(.bottom, 20)
```

Modifiers are chainable and apply consistently across different element types.

---

## Building Reusable Components

Elements aren't limited to pages. You can extract reusable components into their own functions, properties, or types that return `some HTML`.

This is one of the most important ideas in Raptor: large pages are built by composing small, focused pieces.

```swift
struct FeatureGridItem: HTML {
   var body: some HTML {
       VStack(alignment: .leading) {
           Text(title)
               .font(.title5)

           Text(description)
               .lineSpacing(1.15)
       }
       .padding(15)
       .cornerRadius(12)
   }
}
```

Then, you can use these components anywhere:

```swift
Grid {
   FeatureGridItem(
       title: "Fast Builds",
       description: "Generate sites quickly and reliably."
   )

   FeatureGridItem(
       title: "Composable API",
       description: "Build complex pages from small pieces."
   )
}
```

---

## Conditional Content with `@HTMLBuilder`

To return different elements based on conditions, use `@HTMLBuilder`:

```swift
@HTMLBuilder
var subscriptionStatus: some HTML {
    if isSubscribed {
        Text("Thanks for subscribing!")
            .font(.title4)
    } else {
        SubscribeForm()
    }
}
```

Use it wherever you need to return different structures based on state, environment values, or input data.

---

## Inline Content

HTML has two kinds of elements: **block elements** that define structure and spacing, and **inline elements** that flow within text. Valid HTML doesn't allow inline elements to contain block elements.

You generally don't need to think about this when building views—Raptor's type safety handles it automatically through `InlineContent`. Inline content represents things like links, emphasis, and icons that belong *inside* text.

If you need to define custom inline content, it works just like creating a custom `HTML` element:

```swift
struct MyLabel: InlineContent {
   var body: some InlineContent {
       InlineText("Red Label")
           .foregroundStyle(.red)
   }
}
```
