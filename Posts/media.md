---
title: Media
date: 2025-12-20 23:41
description: Display images, system icons, and embed external content with resizing, lazy loading, accessibility support, and automatic light/dark variants.
---

Images can be local files from your **Assets/Images** directory or built-in system icons. You can also embed external content like YouTube videos, Vimeo videos, or entire websites.

## Images

Local images are referenced using paths relative to the site root, like `/images/photos/rug.jpg`. Images render at their natural size by default—use `resizable()` to make them flexible:

```swift
Image("/images/photos/raptor-logo.jpg", description: "Raptor's logo.")
    .resizable()
```

Providing a `description` is strongly recommended. This text is used as the image's accessibility label and improves the experience for users with screen readers. Decorative images that convey no semantic meaning can use `Image(decorative:)` instead.

For large images, use the `lazy()` modifier to defer loading until the image scrolls into view.

---

## Icons

Create images from built-in system icons. When placed inside `Text`, icons automatically scale with the font and can be recolored using `foregroundStyle()`:

```swift
let icons = [
   "airplane", "apple", "arrow-counterclockwise",
   "award", "balloon", "book", "brightness-high"
]

let colors: [Color] = [
   .green, .blue, .indigo, .gray, 
   .yellow, .orange, .pink
]

let fonts = Font.Style.allCases

Text {
   InlineForEach(
      Array(zip(icons, zip(fonts, colors)))
   ) { icon, pair in
      let (font, color) = pair

      Image(systemName: icon)
         .font(font)
         .foregroundStyle(color)
         .margin(.trailing, 20)
   }
}
```

@{ImageExample1}

---

## Image Variants

Raptor supports automatic image variants based on filename conventions. Place multiple related files in the same directory and Raptor generates responsive images and color-scheme–aware output automatically.

### Light and Dark Variants

Provide different images for light and dark color schemes using `~light` or `~dark` suffixes:

- `hero.png`
- `hero~dark.png`

When both variants exist, your site selects the appropriate image based on the user's color scheme.

### High-Resolution Variants

Support high-density displays with pixel density suffixes using `@Nx` format:

- `hero.png`
- `hero@2x.png`
- `hero@3x.png`

The browser chooses the best resolution for the device.

You can also combine light/dark and density variants (e.g., `hero~dark@2x.png`)—Raptor groups them automatically and generates the correct `srcset` and color-scheme–specific sources.

---

## Embeds

Embed external content like YouTube videos, Vimeo videos, or entire websites using `Embed`:

```swift
Embed(title: "Vimeo video title", source: .vimeo(id: 291590798))
    .aspectRatio(.r16x9)

Embed(title: "Website title", url: "https://example.com")
    .aspectRatio(.r16x9)
```

@{EmbedExample1}
