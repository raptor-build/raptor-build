---
title: Project Structure
date: 2025-12-20 23:58
description: Understand Raptor's project structure—Assets, Posts, Sources, localization, Markdown rendering, and how your files become pages.
---

Raptor sites are just Swift packages, but they follow a specific folder structure that makes content management, localization, and site generation straightforward.

## Directory Overview

Here's what you'll find in a typical Raptor project:

- **Assets**  
  Your images, fonts, and other static files. Everything here gets copied straight into the build output.

- **Build**  
  Generated site files. This gets recreated on every build, so don't put anything important here—it'll get wiped out.

- **Posts**  
  Markdown files for blog posts. Use subfolders however you like to keep things organized.

- **Includes** *(optional)*  
  Custom HTML snippets you want to inject into your pages.

- **Sources**  
  All your Swift code—pages, layouts, themes, widgets, site configuration, and if you're building a multilingual site, localized string resources.
  
---

## Markdown Posts

Drop Markdown files in the `Posts` directory and Raptor automatically converts them to pages.

For example:

```treeview
Posts/
└── apps.md
```

Becomes:

```treeview
Build/
└── apps/
    └── index.html
```

Posts support YAML front matter for metadata like title, date, image, layout, and tags. Use subfolders to organize posts by category, year, or whatever makes sense for your site.

---

## Localization

Raptor supports multilingual sites using localized strings and content.

### Localized Strings

Add a `Resources` folder inside `Sources` with a `Localizable.xcstrings` string catalog:

```treeview
Sources/
├── Site.swift
└── Resources/
    └── Localizable.xcstrings
```

`Localizable.xcstrings` uses Apple's string catalog format, so you can define all your translations in one file. Anywhere Raptor accepts text, you can pass a string key instead—Raptor automatically resolves it to the correct translation based on which locale you're rendering.

### Localized Posts

For multilingual posts, organize them using locale-specific subfolders named with RFC 5646 language identifiers:

```treeview
Posts/
├── en-us/
│   ├── welcome.md
│   └── features.md
├── it/
│   ├── welcome.md
│   └── features.md
```

### Localized URLs

The first locale in `Site/locales` is your default and doesn't appear in URLs. All other locales include their identifier in the path:

```bash
example.com/welcome     // default locale
example.com/it/welcome  // Italian
```
