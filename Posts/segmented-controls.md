---
title: Segmented Controls
date: 2025-12-20 23:35
description: Segmented controls for mutually exclusive options with buttons, default selection, persisted state, view modes, filters, and toggles.
---

`SegmentedControl` is a compact control used to present a small set of mutually exclusive options. It's commonly used for toggles like view modes, filters, or color schemes where only one option should be active at a time.

Conceptually, it works the same way as segmented controls in native UI frameworks: a horizontal group of buttons where selecting one deselects the others.

---

## Creating a Segmented Control

A segmented control is created by providing a collection of buttons:

```swift
SegmentedControl {
   InlineForEach(ColorScheme.allCases) { scheme in
      Button(
         scheme.name,
         action: .switchColorScheme(scheme)
      )
   }
}
```

@{AlertWidget:Use only buttons inside a `SegmentedControl`. Other inline elements won't cause compiler errors, but will lack styling and ignore interactions.}

You can mark one segment as selected by default using `defaultSelection()`:

```swift
SegmentedControl {
   Button("General") {
       ShowElement("general")
       HideElement("advanced", "info")
   }

   Button("Advanced") {
       ShowElement("advanced")
       HideElement("general", "info")
   }

   Button("Info") {
       ShowElement("info")
       HideElement("general", "advanced")
   }
   .defaultSelection()
}
```

@{SegmentedControlExample1}

Only one segment should be marked as the default.

---

## Persisting Selection

By default, segmented controls reset their selection when the page reloads. You can persist the selected segment across reloads by applying `selectionPersisted()`:

```swift
SegmentedControl {
   InlineForEach(ColorScheme.allCases) { scheme in
       Button(
           scheme.name,
           action: .switchColorScheme(scheme)
       )
   }
}
.selectionPersisted()
```

@{SegmentedControlExample2}

This stores the selected segment locally and restores it on subsequent visits.
