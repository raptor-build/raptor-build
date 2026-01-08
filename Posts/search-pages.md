---
title: Search
date: 2025-12-20 23:52
description: Build site-wide search with SearchPage—display results, handle queries, and integrate search input with SearchField.
---

`SearchPage` defines the interface for search results on your site. To enable search, create a type conforming to `SearchPage` and assign it to your site's `searchPage` property.

## Implementing a Search Page

Inside a `SearchPage`, two values are provided automatically:

@{ReferenceWidget:var searchText: String}
: The raw search query entered by the user.

@{ReferenceWidget:var searchResults: [SearchResult]}
: Pages that match the query.

Use these to customize how search results are presented:

```swift
struct MySearchPage: SearchPage {
   var body: some HTML {
       Section {
           if searchResults.isEmpty {
               Text("No results were found for \(searchText)")
           } else {
               Text("Results for \(searchText)")

               ForEach(searchResults) { result in
                   Section {
                       result.title
                           .font(.title2)
                       result.description
                   }
                   .background(.accent)
                   .padding()
                   .margin(.top)
               }
           }
       }
   }
}
```

Check `searchResults.isEmpty` to present a custom view when no matches are found.

---

## Search Term Highlighting

Occurrences of the search term are automatically highlighted in result titles and descriptions. The highlight color is derived from your site's accent color. Disable this with `searchResultHighlightingDisabled()`.

---

## Search Results Eligibility

For a page to appear in search results, it must provide a description. This description is used for both indexing and displaying contextual information in results.

On multilingual sites, searches are scoped to the active locale—only pages and posts belonging to the current locale appear in results.

### Pages

For regular pages, define a `description` property:

```swift
struct Home: Page {
   var title = "Hello, world!"
   var description = "This text contains a description with all the keywords for the page."
}
```

### Posts

For posts, include a `description` field in the YAML front matter:

```yaml
---
author: J.P. Toro
title: Posts
date: 2025-12-20 15:30
published: true
description: Learn how Raptor handles Markdown posts, YAML front matter, PostPage layouts, tags, categories, and multilingual static site generation.
---
```

Pages without a description are excluded from search results.

---

## SearchField

Use `SearchField` to present a search input and trigger navigation to the active `SearchPage`. Customize its appearance using standard control modifiers like `controlShape(_:)` and `buttonStyle(_:)`.
