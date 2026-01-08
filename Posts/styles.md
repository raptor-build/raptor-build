---
title: Styles
date: 2025-12-20 23:46
description: Create reusable, environment-aware visual treatments with the Style protocol, automatic CSS generation, and adaptive behavior.
---

A `Style` defines a reusable visual treatment that can adapt to environment conditions like color scheme, motion preferences, contrast, layout orientation, breakpoints, and active themes.

Styles resolve into CSS classes that get included in your site's output.

---

## Simple Styles

A basic style applies the same visual treatment regardless of environment conditions:

```swift
struct InlineCode: Style {
   func style(content: Content, environment: EnvironmentConditions) -> Content {
       content
           .font(.custom("Gintronic"))
           .background(.thinMaterial)
           .border(.gray.opacity(0.4), width: 1)
           .cornerRadius(4)
           .padding(.horizontal, 4)
           .padding(.top, 1)
           .xHeightScale(0.425)
   }
}
```

Apply styles using the `style(_:)` modifier:

```swift
InlineText("let value = compute()")
   .style(InlineCode())
```

---

## Complex Styles

The real power of styles comes from their ability to respond to environment conditions. Each style receives `EnvironmentConditions` describing a possible runtime environment.

### Available Conditions

Your styles can inspect:

- `colorScheme` — Light or dark appearance
- `horizontalSizeClass` — Browser window width
- `layoutOrientation` — Portrait or landscape
- `isMotionReduced` — Whether reduced motion is preferred
- `contrastLevel` — Contrast preference
- `transparencyLevel` — Transparency preference
- `displayMode` — Display mode setting
- `theme` — Active theme

### Conditional Styling Example

Here's a style that changes based on color scheme:

```swift
struct CalloutStyle: Style {
   func style(content: Content, environment: EnvironmentConditions) -> Content {
       if environment.colorScheme == .dark {
           content.background(.yellow.opacity(0.25))
       } else {
           content.background(.orange.opacity(0.25))
       }
   }
}
```

---

## Related Approaches

- **Reusable treatments** — Use `Style` for visual patterns you'll apply in multiple places
- **One-off styling** — For single-use adaptive styling, reach for `environmentEffect()` instead
- **Built-in elements** — For things like `Button`, `Link`, or `Disclosure`, use their dedicated style protocols for better integration. Those dedicated style protocols give you more targeted control and work directly with each component's semantics and interaction model.
