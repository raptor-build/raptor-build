---
title: Links
date: 2025-12-20 23:42
description: Create hyperlinks, wrap interactive content, apply link styles, and protect sensitive URLs with Raptor's Link APIs.
---

Raptor has two primary link types:

- **`Link`** — For inline content like text or icons  
- **`LinkGroup`** — For wrapping larger or composite HTML content  

## Basic Links

Create standard inline hyperlinks with `Link`:

```swift
Link("Read more", destination: "/posts/intro")
```

Or provide inline content:

```swift
Link(destination: "/about") {
   Text("About Us")
       .font(.headline)
}
```

Raptor integrates directly with `Page` and `Post`:

```swift
Link("Get in touch", destination: ContactPage())
Link("Read post", destination: post)
Link(post)  // Uses the post's title as link text
```

---

## Modifiers

**`tint(_:)`** — Control link color (defaults to the active theme’s accent color)

**`linkOpenBehavior(_:)`** — Control where the link opens

**`relationship(_:)`** — Set link relationship metadata

**`privacySensitive(_:)`** — Protect URLs from scraping (`.urlOnly` or `.urlAndDisplay`)

**`linkStyle(_:)`** — Apply built-in link styles (`.automatic` or `.button`)

---

## Link Styles

For advanced styling, create reusable, phase-aware `LinkStyle` types:

```swift
struct UnderlinedLinkStyle: LinkStyle {
   func style(content: Content, phase: Phase) -> Content {
      if phase == .hovered {
         content.underline(pattern: .dotted)
      }
   }
}
```

Then apply it:

```swift
Link("Hover me", destination: "#")
   .linkStyle(UnderlinedLinkStyle())
```

@{LinkExample1}

Links support two interaction phases:

- **`.initial`** — Resting state
- **`.hovered`** — Pointer hover state

## Wrapping Content with `LinkGroup`

When you need to make multiple elements or layout containers clickable, use `LinkGroup`:

```swift
LinkGroup(destination: post) {
   VStack {
       Text(post.title)
           .font(.title3)

       Text(post.description)
           .font(.subheadline)
   }
}
```
