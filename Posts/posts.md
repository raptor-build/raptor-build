---
title: Posts
date: 2025-12-20 23:51
description: Convert Markdown files to pages using YAML front matter, PostPage layouts, tags, categories, localization, and custom post processors.
---

Raptor takes Markdown files from your `Posts` directory and turns them into fully rendered pages. Each file is a single post that you can enhance with metadata, layouts, localization, and custom processing.

For details on how folder structure maps to generated pages, see [Project Structure](/project-structure).

## Accessing Posts from a View

Grab all your posts from any view using the environment:

```swift
@Environment(\.posts) var posts
```

For example, to render a list of all posts:

```swift
List {
   ForEach(posts) { post in
       Link(post)
   }
}
```

By default, posts are sorted by date, newest first.

---

## Post Types

Organize posts using subfolders inside `Posts`:

```treeview
Posts/
├── tutorials/
└── stories/
```

For multilingual sites, type folders come after the locale folder:

```treeview
Posts/
├── en-us/
│   ├── tutorials/
│   └── stories/
└── it/
   ├── tutorials/
   └── stories/
```

These folders can be used for filtering:

```swift
ForEach(posts.typed("story")) { post in
  Link(post)
}
```

---

## YAML Front Matter

Raptor supports Jekyll-style YAML front matter for post metadata.

These fields are recognized by default:

- **`author`** — The post author's name.
- **`date`** — Publication date in ISO-8601 format.
- **`image`** — Primary image URL used for previews and social sharing.
- **`imageDescription`** — Accessible text describing the image for screen readers.
- **`lastModified`** — Last modification date in ISO-8601 format. Falls back to `date` if not provided.
- **`layout`** — The `PostPage` type to use for rendering this post.
- **`published`** — Set to `false` to exclude the post from your site.
- **`subtitle`** — Optional secondary heading for the post.
- **`tags`** — Comma-separated list of tags for categorization and filtering.

You can also define custom values. They show up in the post's `metadata` dictionary:

```swift
Text(post["CustomValue"] ?? "Not defined")
```

Raptor also gives you derived metadata like `estimatedWordCount` and `estimatedReadingMinutes`.

---

## Post Pages

The visual structure of a post comes from a type conforming to `PostPage`. Think of it as a template—the body gets filled in with the current post's content:

```swift
struct Story: PostPage {
   var layout = MyLayout()

   var body: some HTML {
       Text(post.title)
           .font(.title1)

       post.text
   }
}
```

Raptor applies sensible default typography to post content. Customize spacing using modifiers like `paragraphMargin()`, `headingMargin()`, and `lineSpacing()`.

### Providing Post Pages to the Site

Your site needs at least one `PostPage` to render posts:

```swift
struct ExampleSite: Site {
   var name = "Hello World"
   var url = URL(static: "https://www.example.com")

   var homePage = Home()
   var layout = MyLayout()

   var postPages: [any PostPage] {
       Story()
   }
}
```

---

## Post Processors

Post content gets transformed by a type conforming to `PostProcessor`. It takes raw markup (like Markdown) and converts it into structured content the rendering system can use.

Raptor includes a default Markdown processor, but you can provide your own for alternative formats or specialized processing.

```swift
protocol PostProcessor
```

@{ReferenceWidget:var removeTitleFromBody: Bool}
: Whether to remove the post's title from its body, derived from the first `<h1>`.

@{ReferenceWidget:var syntaxHighlighterLanguages: Set<SyntaxHighlighterLanguage>}
: The syntax highlighter languages used within the post.

@{ReferenceWidget:func delimitRawMarkup(_: String) -> String}
: Wraps rendered widget HTML so it passes through markup processing untouched.

@{ReferenceWidget:mutating func process(_: String) throws -> ProcessedPost}
: Processes the raw markup and returns structured post content.

All post processors declare which languages they need for syntax highlighting. This lets Raptor load only the necessary highlighters.

The default Markdown processor automatically detects languages from your code blocks' fence identifiers. If your processor doesn't emit code blocks, just return an empty set—the default.

@{AlertWidget: If your site uses the default post processor and includes code blocks with angle brackets (`<`…`>`), the HTML prettifier will interpret these as HTML tags and break the code's formatting. To fix this, either set `prettifyHTML` to `false` in `Site`, or replace `<` and `>` with `&amp;lt;` and `&amp;gt;`.}
