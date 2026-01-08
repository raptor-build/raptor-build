---
title: Integrating Vapor
date: 2025-12-20 23:25
description: Run your site on Vapor for server-side rendering, dynamic routing, per-request state, sessions, and server-driven interactions.
---

Raptor can run directly on [Vapor](https://vapor.codes){target="_blank"}, enabling server-side rendering, dynamic data, sessions, and interactive server actions. First, import `RaptorVapor`:

```swift
import RaptorVapor
```

This unlocks all Vapor-specific integrations, including routing, property wrappers, and server actions.

## Mounting a Site

Raptor handles all page routing automatically when mounted into a Vapor app. Once mounted, pages and posts are rendered server-side, and URLs are resolved automatically.

```swift
@main
struct Server {
    static func main() async throws {
        let app = try await Application.make(.detect)

        app.sessions.use(.database)
        app.middleware.use(app.sessions.middleware)

        try await app.mount(MySite())

        try await app.execute()
        try await app.asyncShutdown()
    }
}
```

## Accessing Server Data in Views

Raptor provides several property wrappers that expose server-side state directly inside your views.

All wrappers follow the same pattern:
1. Define a key
2. Register or set values in Vapor
3. Read them declaratively in your page

## Defining Storage Keys

Each storage mechanism uses a strongly typed key with a default value.

```swift
struct VisitCountKey: SessionStorageKey {
   static let defaultValue = 0
}

struct BannerMessageKey: AppStorageKey {
   static let defaultValue = ""
}

struct RequestIDKey: RequestedValueKey {
   static let defaultValue = "unknown"
}
```

## App-Wide Storage

Use `@AppStorage` for global, application-level state that is shared across all users and requests. This is useful for site-wide banners, feature toggles, announcements, or CMS-driven content.

```swift
@AppStorage(BannerMessageKey.self)
private var bannerMessage
```

### Updating App-Wide Values

App storage values are typically updated from administrative routes, background jobs, or CMS integrations.

```swift
app.post("admin", "banner") { request in
    request.appStorage.set(
        BannerMessageKey.self,
        to: "Scheduled maintenance tonight at 10 PM."
    )

    return "Banner message updated"
}
```

Once set, app storage values are available to all rendered pages automatically.

```swift
struct MainLayout: Layout {
   @AppStorage(BannerMessageKey.self)
   private var bannerMessage

   var body: some Document {
      Banner {
         if bannerMessage.isEmpty == false {
            Text(bannerMessage)
               .font(.callout)
         }
      }
   }
}
```

Because app storage is global, changes take effect immediately for all users without requiring redeploys or rebuilds.

## Session Storage

Use `@SessionStorage` to persist values across multiple requests for the same user. Session storage is ideal for tracking visit counts, onboarding state, feature flags, or other user-specific data that should survive page reloads.

```swift
@SessionStorage(VisitCountKey.self)
private var visitCount
```

### Updating Session Values

Session values are typically updated inside route handlers or middleware, before rendering a page.

```swift
app.get("increment") { request in
   let current = request.sessionStorage.get(VisitCountKey.self)

   request.sessionStorage.set(
      VisitCountKey.self,
      to: current + 1
   )

   return request.redirect(to: "/")
}
```

Once stored, session values are automatically available to pages rendered for that session.

```swift
struct Home: Page {
   @SessionStorage(VisitCountKey.self)
   private var visitCount

   var body: some HTML {
      Section {
         Text("Welcome back!")
         Text("Visits this session: \(visitCount)")
      }
   }
}
```

This allows you to keep request handling and view rendering cleanly separated, while still sharing state safely across user interactions.

## Request-Scoped Values

Use `@RequestedValue` for data that should exist only for the lifetime of a single HTTP request. These values are ideal for request IDs, authentication context, tracing metadata, or other per-request information.

```swift
@RequestedValue(RequestIDKey.self)
private var requestID
```

### Setting Request Values

Request-scoped values are typically set in **middleware**, ensuring they are available to all pages rendered during that request.

```swift
app.middleware.use { request, next in
   request.requestedValues.set(
      RequestIDKey.self,
      to: request.id
   )
   return next.respond(to: request)
}
```

Once set, the value can be accessed from any page rendered for that request using `@RequestedValue`.

```swift
struct Home: Page {
   @RequestedValue(RequestIDKey.self)
   private var requestID

   var body: some HTML {
      Text("Request ID: \(requestID)")
   }
}
```

This approach keeps routing declarative, avoids page-specific endpoints, and ensures request metadata flows cleanly into your views without manual wiring.

## Rendering Pages from Requests

When running on Vapor, pages are rendered by calling `render(_:)` on the current request. This executes the full server-side rendering pipeline and returns a complete HTML response.

```swift
app.get { request in
   try request.render(Home())
}
```

Calling `render(_:)` automatically resolves the site’s layout, infers the active locale from the request URL, and produces a fully rendered HTML `Response`. 

You can also render individual posts directly:

```swift
app.get("preview") { request in
   @Environment(\.posts) var posts

   guard let post = posts.first else {
      throw Abort(.notFound)
   }

   return try request.render(post)
}
```

The correct post page and layout are resolved automatically based on your site configuration.

## Server Actions

Server actions allow client-side interactions (such as button presses) to trigger server-side logic without writing JavaScript.

### Defining a Server Action

```swift
struct IncrementCounter: ServerAction {
   static let endpoint = "increment-counter"

   func handle(_ request: Request) throws -> ServerActionResult {
      let count = request.sessionStorage.get(VisitCountKey.self)
      request.sessionStorage.set(
         VisitCountKey.self,
         to: count + 1
      )
      return .reload
   }
}
```

Each action:
- Decodes from JSON
- Executes server-side
- Returns a declarative result (reload, redirect, update, etc.)

### Triggering Actions from Views

Server actions can be attached directly to buttons.

```swift
Button("Increment", action: IncrementCounter())
```

When executed, the button performs a secure POST request to the action’s endpoint.
