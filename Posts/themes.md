---
title: Themes
date: 2025-12-20 23:48
description: Customize your site's visual identity with themes—control colors, typography, page width, and color schemes.
---

Themes define the global visual styling of your site. They control colors, typography, layout constraints, and syntax highlighting, applied consistently across all pages and posts.

Themes are declarative, composable, and evaluated at render time, letting you adapt styling based on the active color scheme or user selection.

## Defining a Theme

Create a theme by conforming to the `Theme` protocol and implementing `theme(site:colorScheme:)`:

```swift
struct MyTheme: Theme {
   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       if colorScheme == .dark {
           site.accent(.indigo)
       } else if colorScheme == .light {
           site.accent(.blue)
       } else {
           site
               .syntaxHighlighterTheme(.xcode)
               .codeFont(.gintronic)
               .contentWidth(max: 800)
       }
   }
}
```

The method receives a proxy of the current site and the resolved color scheme. Return a modified version with your desired styling applied.

---

## Understanding Color Schemes

Color schemes aren't binary—they have three possible values:

- `.light` — Light appearance
- `.dark` — Dark appearance
- `.any` — Shared styles that apply regardless of appearance

This matters when writing conditional logic:

```swift
struct MyTheme: Theme {
   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       if colorScheme == .dark {
           site.font(.mdIO)
       } else {
           site
               .contentWidth(max: 800)
               .accent(.red)
       }
   }
}
```

The `else` block applies to **both** `.light` and `.any`, not just "the opposite of dark". If you want distinct styling for light and dark, check both explicitly.

---

## Theme Modifiers

Configure themes using fluent modifiers for colors, typography, and layout:

```swift
site
    .accent(.blue)
    .background(.gray)
    .font(.system)
    .titleFont(.serif)
    .codeFont(.monospaced)
    .contentWidth(max: 800)
    .syntaxHighlighterTheme(.github)
```

Common categories include:

- **Colors**  
`accent()`, `foregroundStyle()`, `background()`

- **Typography**  
`font()`, `titleFont()`, `codeFont()`, `fontSize()`, `fontWeight()`, `lineSpacing()`

- **Layout**  
`contentWidth()`, `inlineCodeStyle()`

- **Code Highlighting**  
`syntaxHighlighterTheme()` (see [Syntax Highlighting](/syntax-highlighting))

---

## Registering Themes

Register themes directly on your site:

```swift
struct MySite: Site {
   var themes: [any Theme] {
       MyTheme()
       AnotherTheme()
   }
}
```

When multiple themes are present, Raptor treats the first as the default.

---

## Color Schemes and Themes

Themes and color schemes are independent concepts:

- A **theme** defines what styles exist
- A **color scheme** defines which appearance is active

This lets users switch themes without affecting their light/dark preference—and vice versa.

### Switching Themes

Let users pick a theme:

```swift
struct ThemePicker: HTML {
   @Environment(\.themes) private var themes

   var body: some HTML {
       SegmentedControl {
           InlineForEach(themes) { theme in
               Button(
                   theme.name.capitalized,
                   action: .switchTheme(theme)
               )
           }
       }
       .selectionPersisted()
   }
}
```

### Switching Color Schemes

Let users toggle light/dark mode:

```swift
SegmentedControl {
   InlineForEach(ColorScheme.allCases) { scheme in
       Button(
           scheme.name,
           action: .switchColorScheme(scheme)
       )
   }
}
.selectionPersisted()
```

These controls can coexist, giving users full control over both appearance axes.

---

## Forcing Color Schemes

By default, sites follow the user or system preference (`.automatic`), but you can force a specific appearance site-wide:

```swift
struct MySite: Site {
   var colorScheme: ColorScheme = .light 
}
```

You can also force a color scheme for individual elements using `preferredColorScheme(_:)`:

```swift
Text("Dark Background")
   .padding()
   .background(.thickMaterial)
   .preferredColorScheme(.dark)
```

This is useful for elements like dark-themed navigation bars or light hero sections that should maintain their appearance regardless of the user's preference.
