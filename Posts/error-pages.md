---
title: Error Pages
date: 2025-12-20 23:53
description: Create custom error pages, register HTTP errors handled by your site, and define your own HTTPError types for precise error handling.
---

Use the `ErrorPage` protocol to create custom error pages that appear when requests fail.

Error pages integrate with your site's layout system and support conditional rendering based on the specific error type.

## Overview

An error page is displayed when your site encounters an HTTP error. Unlike standard pages, error pages are driven by the error context rather than a fixed route or content source.

To define a custom error page, create a type conforming to `ErrorPage` and provide a body describing how the error should be presented:

```swift
struct MyErrorPage: ErrorPage {
   var body: some HTML {
       Text("Something went wrong...")
   }
}
```

---

## Registering Handled Errors

Your site declares which HTTP errors it supports using the `handledErrors` property.

Raptor includes `PageNotFoundError` (404) by default. Override `handledErrors` to support additional or custom error types. Only errors listed here are routed to your custom `ErrorPage`—all others fall back to default browser handling.

```swift
struct MySite: Site {
   var errorPage = MyErrorPage()

   var handledErrors: [any HTTPError] {
       PageNotFoundError()
   }
}
```

This lets your site explicitly control which error conditions it knows how to render, while keeping error presentation logic isolated in the error page itself.

---

## Accessing the Error

Inside an `ErrorPage`, you can access the current error through the `error` property. This value conforms to `HTTPError` and provides a title and description suitable for display.

```swift
struct MyErrorPage: ErrorPage {
   var body: some HTML {
       Text(error.title)
           .font(.title1)

       Text(error.description)
   }
}
```

You can also inspect the concrete error type to customize the UI for specific failure cases:

```swift
struct MyErrorPage: ErrorPage {
   var body: some HTML {
       Text(error.title)
           .font(.title1)

       switch error {
       case is PageNotFoundError:
           Text("The page you're looking for could not be found.")
       default:
           Text("This page failed to load because of an unexpected error.")
       }
   }
}
```

---

## Creating Custom HTTP Errors

Define your own custom error types by conforming to the `HTTPError` protocol. This lets your site handle additional status codes or domain-specific failure cases.

```swift
struct MaintenanceError: HTTPError {
   let statusCode = 503
   let title = "Service Unavailable"
   let description = "The site is temporarily down for maintenance."
}
```

Once defined, register your custom error with your site:

```swift
var handledErrors: [any HTTPError] {
   PageNotFoundError()
   MaintenanceError()
}
```

Your `ErrorPage` will now be invoked whenever one of these errors is encountered.

---

## Title and Description

By default, an error page inherits its title and description from the underlying error:

@{ReferenceWidget:var title: String}
: The title of the error page.

@{ReferenceWidget:var description: String}
: The description of the error page.

You can override these properties if you need custom metadata for SEO or analytics purposes, but in most cases the defaults are sufficient.

---

## Layout Integration

Error pages participate fully in your site's layout system. The active layout is applied automatically unless overridden, allowing error pages to visually match the rest of your site.

---

## HTTPError Protocol Reference

```swift
protocol HTTPError: Sendable
```

A type that represents an HTTP status code error that can be displayed as an error page.

@{ReferenceWidget:var statusCode: Int}
: The status code of the HTTP error.

@{ReferenceWidget:var title: String}
: The title of the error.

@{ReferenceWidget:var description: String}
: The description of the error.

Raptor currently ships with a built-in `PageNotFoundError` (404). Additional HTTP error types may be introduced in future releases.
