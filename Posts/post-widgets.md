---
title: Post Widgets & Includes
date: 2025-12-20 23:50
description: Embed custom HTML components via PostWidget and include external files in Markdown posts with a simple token syntax.
---

Post widgets and includes let you extend Markdown posts with custom HTML views and embed external files—all while keeping your content readable and portable.

## Post Widgets

Post widgets inject custom HTML views directly into your posts. They're a structured, type-safe way to add rich or interactive elements without cluttering your Markdown.

A post widget is a Swift type conforming to `PostWidget` that produces HTML content rendered and injected during post preprocessing:

```swift
struct ErrorWidget: PostWidget {
    var body: some HTML {
        Text("Something went wrong...")
            .background(.red)
    }
}
```

### Registering Post Widgets

Register post widgets with your site before using them in posts:

```swift
struct MySite: Site {
   var name = "Example"
   var url = URL(static: "https://example.com")

   var homePage = Home()
   var layout = MainLayout()

   var postPages: [any PostPage] {
       MainPost()
   }

   var postWidgets: [any PostWidget] {
       MyWidget()
       AlertWidget()
   }
}
```

Only registered widgets are eligible for injection.

### Using Widgets in Markdown

Reference post widgets using token syntax:

```text
$@{MyWidget}
```

Each token gets replaced with the rendered HTML output of the matching `PostWidget` type.

To render a token verbatim without processing, prefix it with `$`:

```text
$$@{MyWidget}
```

Widget tokens work anywhere in Markdown content, but aren't recognized inside elements that do their own Markdown parsing, like `Text(markdown:)`.

If your widget contains HTML that should pass through the markup processor untouched, use `opaqueMarkupGroup()` to ensure the rendered widget is used verbatim.

### Widget Content

To pass content to your widget via its token, follow the widget name with a colon and the content:

```text
$@{AlertWidget:This feature is experimental}
```

Then use the `@WidgetContent` property wrapper to accept this text content:

```swift
struct AlertWidget: PostWidget {
    @WidgetContent(default: "Default alert message") var content

    var body: some HTML {
        Text(content)
            .background(.red)
    }
}
```

The text after the colon is injected into the widget's `@WidgetContent` property. If no content is provided, the default value is used.

Post widgets are resolved by type name, not initializer arguments—so `MyWidget()` and `MyWidget(value: "2")` both match `$@{MyWidget}`.

Think of post widgets as stable insertion points, not highly parameterized components. Extract shared logic into reusable `HTML` views, create a unique widget type per insertion point, and keep Markdown-provided content simple and text-based.

@{AlertWidget:Post widgets render during preprocessing, before all posts have been resolved. This means environment values like `@Environment(\\.posts)` aren't accessible inside post widgets.}

---

## Post Includes

Beyond widgets, you can embed external files directly into Markdown.

### Text Includes

Inline a file's contents as plain text using the `text` token:

```text
$@{text:AlertWidget.swift}
```

Files are loaded relative to your project's `Sources` folder and injected verbatim.

- Missing files don't fail the build
- A warning is logged if the file can't be opened

### Code Includes

Embed source files as fenced Markdown code blocks with syntax highlighting using the `code` token:

```text
$@{code:AlertWidget.swift}
```

The language is inferred from the file extension and rendered using your site's post processor.

#### Stripping Imports

Strip leading import statements with the `noimports` modifier:

```text
$@{code:noimports:AlertWidget.swift}
```

This removes only leading import-related lines (like `import`, `use`, or `#include`), stopping as soon as real code is encountered. Everything else is preserved exactly as written.
