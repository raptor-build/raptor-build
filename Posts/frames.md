---
title: Frames & Overlays
date: 2025-12-20 23:29
description: Control element sizing with fixed, container-relative, and screen-relative frames, plus overlays for layered content.
---

Raptor provides a family of frame modifiers for controlling the size and alignment of elements.

At a high level, frames control size (not position), and framed elements remain in the normal document flow. To break out of flow or layer content, use overlays instead.

---

## Fixed Frames

Use `frame(...)` to size an element using pixel values:

```swift
Text("200x100")
   .frame(width: 200, height: 100)
```

Available parameters:

```swift
.frame(
   minWidth: Int?,
   width: Int?,
   maxWidth: Int?,
   minHeight: Int?,
   height: Int?,
   maxHeight: Int?,
   alignment: Alignment?
)
```

When `alignment` is `nil`, the size constraints are applied directly to the element. When `alignment` is provided, Raptor creates an invisible frame with the given dimensions and aligns the element inside it:

```swift
Section {
   Text("Aligned")
      .border(.accent)
      .frame(width: 200, height: 200, alignment: .center)
}
.fixedSize()
.border(.blue, style: .dotted)
```

@{FrameExample1}

---

## Container-Relative Frames

To size an element relative to its parent container, use `containerRelativeFrame(_:alignment:)`. These dimensions are expressed as percentages of the containing element:

```swift
Text("Half width")
    .background(.red)
    .padding()
    .containerRelativeFrame(width: 50%)
```

@{FrameExample2}

You can also fill an entire axis:

```swift
Text("Full width")
   .background(.blue)
   .padding()
   .containerRelativeFrame(.horizontal)
```

@{FrameExample3}

This expands the element to 100% of the container along the specified axis. The element remains in the document flow—it doesn't escape its parent or overlay other content.

---

## Screen-Relative Frames

To size elements relative to the viewport, use `screenRelativeFrame(_:alignment:)`:

```swift
Section {
   Text("Centered")
}
.screenRelativeFrame(width: 50%, height: 50%)
```

Like all frame modifiers, screen-relative frames do not remove the element from document flow. The element gains viewport-relative dimensions but doesn't automatically overlay or pin itself to the screen edges.

To break just an element’s background out of its container and expand it edge to edge, use `backgroundExtensionEffect()`.

```swift
Text("Edge to edge")
   .background(.gray)
   .backgroundExtensionEffect()
```

@{FrameExample4}

---

## Overlays

Frames only affect size and alignment—they don't change stacking, positioning, or layout flow. If you need content to visually escape the layout or layer above other elements, use overlays instead.

### Element Overlays

Use `overlay` to place content on top of an element, aligned to its bounds:

```swift
Color.red
   .frame(width: 100, height: 100)
   .overlay(alignment: .bottomTrailing) {
      Text("Caption")
         .padding(8)
         .background(.black.opacity(0.6))
   }
```

@{OverlayExample1}

Overlays are positioned absolutely relative to the element, but the element itself remains in flow.

### Full-Screen Overlays

Use `fullScreenOverlay(alignment:content:)` to place content fixed to the viewport, independent of layout:

```swift
Text("Find me at the bottom right!")
   .fullScreenOverlay {
      Image(systemName: "emoji-smile")
         .background(.black)
         .foregroundStyle(.white)
}
```

@{OverlayExample2}

This is the correct tool for banners, loaders, and other floating UI.
