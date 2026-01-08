---
title: Site
date: 2025-12-20 23:57
description: Define your website using the Site protocol—metadata, layouts, themes, pages, feeds, localization, and publishing behavior in one place.
---

The `Site` protocol is your website's central configuration, defining your site's identity, structure, and behavior. When you build your site, Raptor uses this configuration to load content, apply layouts and themes, and generate the final HTML output.

## Overview

A `Site` describes:

- **Metadata** like site name, author, description, and base URL  
- **Structure** including the home page, layouts, static pages, and posts  
- **Presentation** through layouts, themes, color schemes, and syntax highlighting  
- **Behavior** like RSS feeds, robots configuration, search, and localization  

Most properties have sensible defaults, so you can start minimal and add features as you need them.

## Defining a Site

To create a site, define a type conforming to `Site` and provide the required properties:

```swift
struct MySite: Site {
  var name = "My Awesome Site"
  var url = URL(static: "https://example.com")
  var homePage = HomePage()
  var layout = MainLayout()
}
```

From there, customize content, themes, feeds, and behavior by overriding additional properties. When doing so, make sure their types match the protocol requirements exactly.

## Properties

### Identity

@{ReferenceWidget:var name: String}
: The display name of your site. Used in titles and metadata.

@{ReferenceWidget:var url: URL}
: The base URL, like `https://www.example.com`.

@{ReferenceWidget:var author: String}
: The site author's name. Defaults to an empty string.

@{ReferenceWidget:var description: String?}
: An optional site-wide description for metadata and feeds.

@{ReferenceWidget:var titleSuffix: String}
: Text appended to every page title, useful for branding.

---

### Localization

@{ReferenceWidget:var locales: [Locale]}
: Supported locales for your site. Multiple locales enable multilingual mode.

@{ReferenceWidget:var colorScheme: SiteColorScheme}  
: Preferred color scheme: light, dark, or automatic.

---

### Pages and Content

@{ReferenceWidget:var homePage: some Page}
: What users see when they visit your root URL.

@{ReferenceWidget:var pages: [any Page]}
: Static pages like About or Contact.

@{ReferenceWidget:var postPages: [any PostPage]}
: Article or blog-style pages generated from content files.

@{ReferenceWidget:var categoryPage: some CategoryPage}
: Page type for rendering category listings. Defaults to an empty implementation, which disables category pages.

@{ReferenceWidget:var errorPage: some ErrorPage}
: Page for HTTP error states like 404s.

@{ReferenceWidget:var searchPage: some SearchPage}
: Page for displaying search results. Providing one enables site-wide search.

---

### Layout and Themes

@{ReferenceWidget:var layout: some Layout}
: Base layout applied to all pages unless overridden.

@{ReferenceWidget:var themes: [any Theme]}
: One or more themes for your site. The first is the default.

@{ReferenceWidget:var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration}
: Controls syntax highlighting for code blocks across your site.

---

### Feeds and Indexing

@{ReferenceWidget:var feedConfiguration: FeedConfiguration?}
: Controls RSS feed generation. Set to `nil` to disable feeds.

@{ReferenceWidget:var robotsConfiguration: some RobotsConfiguration}
: Controls how search engines and crawlers index your site.

---

### Output and Rendering

@{ReferenceWidget:var prettifyHTML: Bool}
: Whether generated HTML is formatted with indentation. Disable if your content includes raw angle brackets that shouldn't be interpreted as HTML.

@{ReferenceWidget:var favicon: URL?}
: Optional URL for your site's favicon.

@{ReferenceWidget:var postProcessor: some PostProcessor}
: Processor for transforming content files into HTML.

## Methods

### Preparing the Site
```swift
mutating func prepare() async throws
```

Override this to perform custom setup before publishing—like downloading data or generating pages dynamically. The default implementation does nothing.

### Publishing the Site
```swift
try await site.publish()
```

Runs the full build: loading content, preparing the environment, rendering pages, and writing output files. Typically called from `main.swift` or your entry point.
