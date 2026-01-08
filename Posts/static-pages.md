---
title: Static Pages
date: 2025-12-20 23:54
description: Create standalone pages with custom paths, titles, metadata, and layouts using the Page protocol.
---

Use the `Page` protocol to create standalone pages with static content—home pages, landing pages, about pages, legal documents, and more.

Unlike dynamic page types like `PostPage`, which act as templates populated from external content, `Page` defines everything in code as a self-contained view.

## Declaring a Page

To create a page, define a type conforming to `Page` and provide at minimum a title and body:

```swift
struct About: Page {
   var title = "About"

   var body: some HTML {
       Text("About this site...")
   }
}
```

Each page is rendered independently and included directly in your site's output.

---

## Page Metadata

The `Page` protocol defines several properties that control routing and metadata:

@{ReferenceWidget:var title: String}
: The title of the page. Used for the document title and metadata.

@{ReferenceWidget:var path: String}
: The URL path where the page is published. By default, Raptor generates a path automatically using the page's type name, converted into a URL-safe slug. Override this to provide a custom path like `/about`.

@{ReferenceWidget:var description: String}
: A plain-text description of the page, typically used for metadata and previews. Defaults to an empty string.

@{ReferenceWidget:var image: String?}
: An optional image URL used for link sharing and social previews. Defaults to `nil`.

---

## Layout Integration

Pages use the site's global layout by default, but you can override it by providing a custom `layout` property.

This lets pages share a consistent structure while still supporting customization on a per-page basis.
