---
title: Lists
date: 2025-12-20 23:34
description: Create ordered and unordered lists, customize markers, generate rows from data, and style list rows with backgrounds, padding, borders, spacing, and corner radius.
---

`List` displays ordered or unordered collections of content, with modifiers designed specifically for styling individual rows.

At its simplest, a `List` can be created with static content:

```swift
List {
   "First item"
   "Second item"
   "Third item"
}
```

@{ListExample1}

This produces an unordered list using the default marker style. You can also generate list rows from a collection using a closure:

```swift
let tasks = ["Design", "Build", "Test", "Deploy"]

List(tasks) { task in
   task
}
```

@{ListExample2}

---

## List Marker Styles

By default, lists are unordered. To switch to an ordered list, use `listMarkerStyle(_:)`:

```swift
List {
   "Step one"
   "Step two"
   "Step three"
}
.listMarkerStyle(.ordered)
```

You can further customize ordered markers via `ListMarkerStyle`, for example `.ordered(.roman)`. Unordered lists support alternate predefined marker shapes or fully custom symbols.

---

## List Row Styling

List rows have their own domain-specific modifiers that control appearance at the row level. These modifiers must be applied to list row content, not to the `List` itself.

- **`listRowBackground(_:)`** — Applies a background color to the entire row
- **`listRowInsets(_:)`** — Controls padding for the entire row, with optional edge specification
- **`listRowSpacing(_:)`** — Sets the space between a row and the next row
- **`listRowBorder(_:width:style:edges:)`** — Adds borders around list rows
- **`listRowCornerRadius(_:)`** — Rounds the corners of individual rows

These modifiers can be combined for rich row styling:

```swift
List {
   Text("Styled row")
       .listRowBackground(.blue.opacity(0.1))
       .listRowInsets(12)
       .listRowCornerRadius(8)
       .listRowBorder(.blue, edges: .bottom)
       .listRowSpacing(8)
}
.listMarkerStyle(.custom("⭐️"))
```

@{ListExample3}
