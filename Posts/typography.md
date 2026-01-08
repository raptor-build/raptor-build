---
title: Fonts
date: 2025-12-20 23:45
description: Add custom fonts, map weights and variants through filename conventions, and construct font families with FontSource.
---

Adding custom fonts to your site is straightforward—drop font files in **Assets/Fonts** and Raptor automatically generates the corresponding `@font-face` rules at build time.

## Filename Conventions

Filenames must follow this convention:

```text
FontName-WeightVariant.ext
```

Use numeric weights (100–900) or named weights. Append `Italic` or `Oblique` for slant variants.

**Examples:**

- `Advocate-100.woff2` (Ultralight)
- `Advocate-400.woff2` (Regular)
- `Advocate-400Italic.woff2` (Regular Italic)
- `Advocate-700.woff2` (Bold)

Raptor derives font family, weight, and variant from the filename—defaulting to regular (400) roman if the latter are not specified. Since named weight terminology can vary, prefer numeric weights for consistency.

**Weights** 

- **100** — Ultralight
- **200** — Thin
- **300** — Light
- **400** — Regular (Normal)
- **500** — Medium
- **600** — Semibold
- **700** — Bold
- **800** — Heavy
- **900** — Black

---

## Manual Font Registration

For finer control over the generated `@font-face` rules—like custom ascent, descent, or line-gap metrics—register fonts manually using `Font` and `FontSource`:

```swift
struct MyTheme: Theme {
   private let advocate = Font(
       name: "Advocate",
       sources:
           FontSource(
               url: URL(static: "/fonts/Advocate-400.woff2"),
               ascent: 0.9
           )
   )

   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       site.font(.advocate)
   }
}
```

**Note:** Overriding a font's ascent, descent, and line-gap metrics are progressive enhancements and may not be supported by all browsers. Unsupported browsers safely ignore these values.
