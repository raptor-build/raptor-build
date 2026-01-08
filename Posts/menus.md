---
title: Menus
date: 2025-12-20 23:36
description: Dropdown menus with buttons, actions, icons, primary actions, tinting, anchors, dismissal behavior, split-button style, and custom dropdown styles.
---

`Menu` represents a button that reveals a dropdown list of actions or content when pressed. Menus are commonly used for secondary actions, settings, and contextual options, and can be placed inline, inside toolbars, or within navigation bars.

---

## Creating a Menu

At its simplest, a `Menu` consists of a label and a list of items, most commonly `Button` and `Link`.

```swift
Menu("Options") {
   Button("Rename", action: .rename())
   Button("Delete", action: .delete())
}
```

Menus respect standard button modifiers for color, shape, and size, and can include system icons:

```swift
Menu("Settings", systemImage: "gear-fill") {
   Button("Profile", action: .openProfile())
   Link("Help", destination: "#")
}
.tint(.blue)
```

@{MenuExample1}

@{AlertWidget:Nested menus are currently not supported. A menu's dropdown may only contain flat content.}

### Dropdown Behavior

You can control where the dropdown appears using `dropdownAnchor(_:)` and how it dismisses using `menuActionDismissBehavior(_:)`:

```swift
Menu("More", systemImage: "three-dots") {
   Button("Settings", action: .openSettings())
   Button("Pin", systemImage: "pin")
}
.menuActionDismissBehavior(.disabled)
.dropdownAnchor(.bottomTrailing)
```

@{MenuExample2}

By default, menus close automatically when an action is triggered. Setting `.menuActionDismissBehavior(.disabled)` keeps the menu open—useful for toggles or multi-step interactions.

---

## Primary Menu Action

A menu can perform a primary action when pressed, creating a split-button where the main area triggers the action and a separate toggle opens the dropdown.

```swift
Menu(
   "Download",
   systemImage: "download",
   primaryAction: .download()
) {
   Button("Download as ZIP", action: .downloadZip())
   Button("Download as PDF", action: .downloadPDF())
}
```

@{MenuExample3}

---

## Custom Menu Dropdown Styles

For reusable and consistent dropdown styling, Raptor provides the `MenuDropdownStyle` protocol. This allows you to define how the dropdown itself—and its items—are rendered.

### Creating a Custom Style

```swift
struct ContextMenuStyle: MenuDropdownStyle {
   func style(content: Content) -> Content {
      content
          .background(.gray.opacity(0.5))
          .border(.primary.opacity(0.15))
          .cornerRadius(0)
          .dropdownItemCornerStyle(.square)
   }
}
```

Then apply it:

```swift
Menu("Options") {
   Button("Edit", action: .edit())
   Button("Delete", action: .delete())
}
.menuDropdownStyle(ContextMenuStyle())
```

@{MenuExample4}
