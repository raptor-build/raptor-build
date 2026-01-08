---
title: Forms
date: 2025-12-20 23:39
description: Build accessible, composable forms using Form, GridForm, and specialized types like SubscribeForm.
---

Raptor provides several types for building forms. `Form` is the basic container for collecting user input:

```swift
Form {
   TextField("One-Time Password")
   Button("Sign In", role: .submit, action: SubmitAction())
}
```

@{FormExample1}

### Label Styling

Control label positioning across all form controls using `labelStyle(_:)`:

```swift
Form {
   TextField("Email")
   TextField("Password")
}
.labelStyle(.leading)
```

@{FormExample2}

Available styles include:

- **`.top`** — Labels appear above inputs (default)
- **`.leading`** — Labels appear beside inputs (when supported)
- **`.hidden`** — Labels remain in HTML for accessibility but are visually hidden

Controls can override this individually if needed.

---

## GridForm

`GridForm` is a form built on `Grid` for column-aligned layouts:

```swift
GridForm {
   GridRow {
      TextField("Email")
      TextField("Password")
         .textContentType(.password)
      Button("Sign In", action: SignInAction())
   }
}
.labelStyle(.hidden)
```

@{FormExample4}

For more details on grid layouts, see [Grids](/grids).

---

## SubscribeForm

`SubscribeForm` is a ready-made form for collecting email subscriptions and integrating with newsletter services:
```swift
SubscribeForm(.buttondown("myID"))
```

@{FormExample3}

Use it when you're integrating with providers like Mailchimp or SendFox and want correct semantics, accessibility, and anti-bot handling out of the box.

Control the layout with `formStyle(_:)` and customize text with `emailFieldLabel(_:)` and `subscribeButtonLabel(_:)`:

```swift
SubscribeForm(.mailchimp)
    .formStyle(.stacked)
    .emailFieldLabel("Your email")
    .subscribeButtonLabel("Join Newsletter")
```

@{FormExample5}

`SubscribeForm` automatically configures form attributes for the selected provider, includes honeypot fields for spam prevention, injects required provider scripts, and uses accessible labels even when visually hidden.
