---
title: Category Pages
date: 2025-12-20 23:49
description: Create custom pages for organizing posts by tags, dates, authors, and other categories.
---

A `CategoryPage` defines how category-based pages get rendered—pages that group and display posts by tags, dates, authors, or other organizational schemes.

## Overview

When you create a type conforming to `CategoryPage`, Raptor passes you a category type that determines what content to display. Your category page can render different layouts based on the specific category type.

Currently supported categories:

- **`TagCategory`** — A page for a single tag, showing all posts with that tag
- **`AllTagsCategory`** — A page listing all tags and their associated content

Additional category types like date and author are planned in future releases.

---

## Basic Implementation

Here's a simple category page that works with all category types:
```swift
struct MyCategoryPage: CategoryPage {
   var body: some HTML {
       Text(category.name)
           .font(.title1)
       
       List {
           ForEach(category.posts) { post in
               Link(post)
           }
       }
   }
}
```

---

## Customizing by Category Type

Check the category type to access specific properties or customize the layout:
```swift
struct MyCategoryPage: CategoryPage {
   var body: some HTML {
       switch category {
       case let tag as TagCategory:
           Text("Posts tagged with \(tag.name)")
       case is AllTagsCategory:
           Text("All Tags")
       default:
           Text(category.name)
       }
       
       List {
           ForEach(category.posts) { post in
               Link(post)
           }
       }
   }
}
```

This pattern lets you create specialized layouts for different category types while sharing common structure.

---

## Registration

Register your category page with your site:
```swift
struct ExampleSite: Site {
   var categoryPage = MyCategoryPage()
   // ...
}
```

Once configured, Raptor automatically generates pages for each tag used in your posts, plus an index page showing all tags.

---

## Accessing Category Data

Inside a `CategoryPage`, the implicit `category` property provides access to:

@{ReferenceWidget:var name: String}
: The display name of the category.

@{ReferenceWidget:var posts: [Post]}
: All posts belonging to this category.

Different category types may expose additional properties specific to their use case.
