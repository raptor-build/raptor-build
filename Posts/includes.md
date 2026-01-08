---
title: Includes
date: 2025-12-20 23:31
description: Reusable HTML fragments, external resources, JSON decoding, shared markup, structured data loading, and dynamic content rendering.
---

Use `Include` to reuse HTML fragments and load external resources into your pages. This lets you keep shared markup and data separate from your page definitions while still integrating them seamlessly into your site.

### Importing HTML Includes

You can import arbitrary HTML files from an **Includes** directory. Any file placed in this directory can be embedded directly into a page using the `Include` type.

---

## Loading External Resources

You can load arbitrary files from a Resources directory, commonly used for JSON, configuration files, or other structured data. **Note:** This is separate from the `Sources/Resources` directory used for localized strings.

To work with resources, add the following environment value to your page:

```swift
@Environment(\.decode) private var decode
```

The `decode` environment provides three related APIs for locating, loading, and decoding resources.

### Locating a Resource URL

Use `decode.url(forResource:)` to retrieve the full file URL for a resource in the Resources directory:

```swift
let configURL = decode.url(forResource: "config.json")
```

This is useful when you need direct access to the file location.

### Loading Raw Data

Use `decode.data(forResource:)` to load a resource into a `Data` instance:

```swift
let imageData = decode.data(forResource: "banner.png")
```

This method internally resolves the resource URL before loading its contents.

### Decoding JSON Data

Use `decode(_:as:)` to load and decode a JSON file into a `Decodable` type in one step:

```swift
if let members = decode("team.json", as: [TeamMember].self) {
   ForEach(members) { member in
       Card {
           Text(member.name)
           Text(member.role)
       }
   }
}
```

In this example, JSON data stored in `Resources/team.json` is decoded into an array of `TeamMember` objects and rendered dynamically.
