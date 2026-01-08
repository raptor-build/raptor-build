---
title: Layouts
date: 2025-12-20 23:56
description: Learn how Layouts structure pages with regions, content injection, metadata management, and per-page overrides.
---

A `Layout` defines the macro-level structure of a page—things like navigation, main content area, banners, and footers. Layouts describe the structure of pages, while pages and posts define the content itself.

This is intentionally distinct from a **theme**, which handles visual styling like colors, fonts, materials, and typography. Layouts establish structure and composition; themes establish appearance.

## Regions

The body of a layout is composed of regions with an API surface similar to SwiftUI's scenes:

- **`Main`**  
The primary content area of the page.

- **`Navigation`**  
Navigation bars and persistent navigation UI.

- **`Banner`**  
Fixed or prominent banners, like announcements or alerts.

- **`Footer`**  
Content rendered after `Main`, typically for site-wide footer content like links, copyright notices, or secondary navigation.

---

## Injecting Page Content

The `Main` region is where your page's content appears. Inside `Main`, use the implicit `content` property—this is the body of whatever page is currently being rendered.

In other words, layouts provide the wrapper (navigation, footer, etc.), and pages provide what goes in the middle.

```swift
struct MyLayout: Layout {
   var body: some Document {
       Navigation {
           InlineText("RAPTOR")
               .navigationItemRole(.logo)
       }

       Main {
           content // <- The page's body gets inserted here
           SubscribeForm()
       }
   }
}
```

---

## Page Metadata and Head Management

Beyond structure, `Main` exposes modifiers that let layouts influence page-level metadata—things like inserting scripts, configuring social sharing images and previews, or adding custom meta tags and resources.

This makes layouts the right place to define global or structural metadata, while keeping page content focused on semantics and presentation.

---

## Default and Per-Page Layouts

A site defines a default layout that applies to all pages automatically.

Individual pages can override this by specifying their own layout:

```swift
struct MyPage: Page {
   var layout = AlternateLayout()

   var body: some HTML {
       Text("This page has a different layout!")
   }
}
```

This lets you reuse layouts across broad sections of your site while still tailoring structure for specific content types like posts, landing pages, or documentation.
