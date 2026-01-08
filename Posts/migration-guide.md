---
title: Migrating to Raptor
date: 2025-12-20 23:24
description: A practical migration guide for moving an existing Ignite project to Raptor, including type mappings and common before-and-after examples.
---

Raptor is built by the author of Ignite's `HTML`, `Style`, and `Theme` protocols—along with many other of its most widely used features. So the overall API will feel familiar, making migration quick and straightforward.

This guide highlights the most common changes. It's not exhaustive, but it should get most sites about 80–90% of the way there.

Many Ignite types simply map to Raptor with updated naming.

| Raptor | Ignite |
|--------|--------|
| `Post` | `Article` |
| `PostPage` | `ArticlePage` |
| `PostProcessor` | `ArticleRenderer` |
| `InlineContent` | `InlineElement` |
| `Page` | `StaticPage` |
| `CategoryPage` | `TagPage` |
| `Category` | `Tag` |
| `Disclosure` | `Accordion` / `Item` |
| `InlineText` | `Span` / `Strong` / `Emphasis` |

In most cases, renames can be applied directly without changing behavior.

---

## Site Configuration

Raptor consolidates theme configuration and uses a single `themes` array instead of separate light and dark theme properties.

### Ignite

```swift
struct MySite: Site {
   var lightTheme: (any Theme)? = DefaultLightTheme()
   var darkTheme: (any Theme)? = nil

   var articlePages: [any ArticlePage] { ... }
   var staticPages: [any StaticPage] { ... }
}
```

### Raptor

```swift
struct MySite: Site {
   var colorScheme: ColorScheme = .dark
   var themes: [any Theme] {
       MyTheme()
   }

   var postPages: [any PostPage] { ... }
   var pages: [any Page] { ... }
}
```

---

## Themes

Raptor themes use a single type with color scheme branching, replacing Ignite's separate light and dark theme implementations.

### Ignite

```swift
// Base protocol with shared theme values
protocol BaseTheme: Theme {}

// Default implementation for shared values
extension BaseTheme {
   var accent: Color { Color(hex: "#FF0000") }
   var secondaryAccent: Color { Color(hex: "#00FF00") }
}

// Light theme implementation
struct LightTheme: BaseTheme {
   var colorScheme: ColorScheme = .light
   var syntaxHighlighterTheme: HighlighterTheme = .githubLight
}

// Dark theme implementation
struct DarkTheme: BaseTheme {
   var colorScheme: ColorScheme = .dark
   var syntaxHighlighterTheme: HighlighterTheme = .xcodeDark
}
```

### Raptor

```swift
struct MyTheme: Theme {
   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       if colorScheme == .light {
           site
               .syntaxHighlighterTheme(.githubLight)
       } else if colorScheme == .dark {
           site
               .syntaxHighlighterTheme(.xcodeDark)
       } else { // .any
           site
               .accent(Color(hex: "#FF0000"))
               .secondaryAccent(Color(hex: "#00FF00"))
       }
   }
}
```

---

## Layout & Head Content

Raptor uses a single `Main` type instead of separate `Head` and `Body` elements. Scripts and other metadata are applied as modifiers rather than being nested inside `Head`.

### Ignite

```swift
struct MainLayout: Layout {
   var body: some Document {
       Head {
           Script(file: "custom.js")
       }
       Body()
   }
}
```

### Raptor

```swift
struct MainLayout: Layout {
   var body: some Document {
       Main()
           .script(file: "custom.js")
   }
}
```

---

## Navigation

Raptor uses explicit role assignment and layout controls like `Spacer` for flexible navigation structure.

### Ignite

```swift
NavigationBar(logo: "My Site") {
   Link("Home", target: Home())
   Link("Docs", target: Docs())
}
```

### Raptor

```swift
Navigation {
   InlineText("My Site")
       .navigationItemRole(.logo)

   Spacer()

   Link("Docs", target: Docs())
}
```

---

## Length Units & Margins

Rather than the `LengthUnit` type, Raptor uses intent-specific layout modifiers like `containerRelativeFrame(_:)` and `screenRelativeFrame(_:)`, making it clear what a view sizes itself relative to. This removes ambiguity and results in more predictable layouts.

Other than markdown text, all elements lack implicit margins and padding for more predictable spacing.

---

## Grids

Ignite uses a fixed 12-column grid where layout is controlled with numeric widths. Raptor uses a row-driven API instead.

### Ignite

```swift
Grid {
   Text("A")
      .width(4)
   Text("B")
      .width(4)
   Text("C")
      .width(4)
}
```

### Raptor

```swift
Grid {
   GridRow {
       Text("A")
       Text("B")
       Text("C")
   }
}
```

### Full-width content

In Ignite, spanning the full width requires setting width to 12:

```swift
Grid {
   Text("Name")
      .width(4)
   Text("Role")
      .width(4)
   Text("Location")
      .width(4)

   Text("Alex").width(12)
}
```

In Raptor, single items automatically span the grid width:

```swift
Grid {
   GridRow {
       Text("Name")
       Text("Role")
       Text("Location")
   }

   Text("Alex")
}
```

---

## Modals & Popovers

Both frameworks support modals and popovers, but they differ in how presentations are triggered and managed.

### Ignite

```swift
Button("Open settings") {
   ShowModal(id: "settings")
}

Modal(id: "settings") {
   Text("Settings")
}
```

### Raptor

```swift
Button("Open settings", action: showModal("settings")
   .modal(id: "settings") {
      Text("Settings")
   }
```

---

## Scroll Views

Ignite provides a dedicated `Carousel` type with slides, transitions, and background handling built in. Raptor uses a more general-purpose `ScrollView` that covers carousels and many custom use cases that require native scrolling, snapping, and automation.

### Ignite

```swift
Carousel {
   Slide(background: "/images/photos/stack.jpg")
   Slide(background: "/images/photos/wind.jpg")
   Slide(background: "/images/photos/washing.jpg")
}
.carouselStyle(.crossfade(3))
```

### Raptor

```swift
ScrollView(.horizontal, id: "gallery") {
   Image("/images/photos/stack.jpg")
   Image("/images/photos/wind.jpg")
   Image("/images/photos/washing.jpg")
}
.scrollBehavior(.viewAligned(.center))
.autoAdvance(every: 3)
```

---

## Disclosures

Raptor uses individual `Disclosure` views instead of a container-based `Accordion`. Use `matchedTransitionEffect(id:)` to coordinate multiple disclosures so only one stays open at a time.

### Ignite

```swift
Accordion {
   Item("Title") {
       Text("Content")
   }

   Item("Another title") {
       Text("More content")
   }
}
```

### Raptor
```swift
Disclosure("Title") {
   Text("Content")
}
.matchedTransitionEffect(id: "myGroup")

Disclosure("Another title") {
   Text("More content")
}
.matchedTransitionEffect(id: "myGroup")
```

---

Happy migrating! 🚀
