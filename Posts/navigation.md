---
title: Navigation
date: 2025-12-20 23:55
description: Build responsive navigation bars with logos, flexible layouts, fixed positioning, and adaptive behavior across screen sizes.
---

Use `Navigation` to create a navigation bar. Content inside is rendered as horizontal navigation items at the top of the page.

## Basic Usage

The following example creates a navigation bar with a logo aligned to the leading edge and a call-to-action button aligned to the trailing edge:

```swift
Navigation {
   InlineText("Raptor".uppercased())
       .navigationItemRole(.logo)

   Spacer()

   Link("Download", target: "https://github.com/raptor-build/raptor")
       .linkStyle(.button)
}
```

Use `Spacer` to push navigation items apart, just as you would in SwiftUI.

Apply `navigationItemRole(.logo)` to designate an item as the navigation bar's logo. Logo items automatically link back to the site's home page.

---

## Navigation Bar Sizing

Control how the navigation bar sizes itself horizontally using the `navigationBarSizing(_:)` modifier:

@{ReferenceWidget:NavigationBarSizing.contentArea}
: Constrains the navigation bar to the site's content width, as defined by the theme's `contentWidth(max:)` setting.

@{ReferenceWidget:NavigationBarSizing.window}
: Expands the navigation bar to span the full width of the browser window.

---

## Fixed Navigation Bars

Navigation bars can be positioned relative to the viewport using the `position(_:)` modifier.

When you apply a fixed position (for example, `.fixedTop`), Raptor automatically reserves vertical space equal to the navigation bar's height at the top of the page. This prevents page content from being obscured by the fixed navigation bar.

You can disable this behavior by using `navigationBarReservedSpaceDisabled()`.

---

## Responsive Behavior

To adapt navigation content to different screen sizes, use `environmentEffect()`.

```swift
Link("Download", target: "https://github.com")
   .environmentEffect(\.horizontalSizeClass) { content, sizeClass in
       content.hidden(sizeClass == .compact)
   }
```
