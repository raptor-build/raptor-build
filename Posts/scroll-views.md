---
title: Scroll Views
date: 2025-12-20 23:33
description: Scrollable containers with horizontal or vertical scrolling, snap alignment, autoplay, infinite marquee scrolling, and programmatic scroll actions.
---

`ScrollView` is a scrollable container that arranges its children along a single axis. It supports horizontal or vertical scrolling, scroll snapping behaviors, scripted autoplay, infinite scrolling, and programmatic scrolling via actions. 

`ScrollView` is ideal for carousels, showcases, horizontally scrolling lists, and content previews.

---

## Creating a Scroll View

A `ScrollView` requires an explicit `id` and a scroll axis:

```swift
ScrollView(id: "features") {
   Color.blue
   Color.red
   Color.yellow
}
.scrollViewItemSizing(.flexible)
```

@{ScrollViewExample1}

By default, scrolling is horizontal with continuous (non-snapping) behavior. You can switch between horizontal and vertical scrolling using `ScrollAxis`:

```swift
ScrollView(.vertical, id: "features") {
   Color.blue
      .frame(height: 150)
   Color.red
      .frame(height: 150)
   Color.yellow
      .frame(height: 150)
}
```

@{ScrollViewExample2}

`ScrollView` supports multiple scroll snapping strategies via `scrollBehavior(_:)`:

```swift
ScrollView(id: "features") {
   Color.blue
      .frame(width: 500)
   Color.red
      .frame(width: 500)
   Color.yellow
      .frame(width: 500)
}
.scrollBehavior(.viewAligned(.center))
```

@{ScrollViewExample3}

Available behaviors include `.continuous` (no snapping, default) and `.viewAligned(_)` (snap items to leading, center, or trailing).

You can enable automatic scrolling between child views using `autoAdvance(every:loops:)`:

```swift
ScrollView(id: "features") {
   Color.blue
      .frame(width: 500)
   Color.red
      .frame(width: 500)
   Color.yellow
      .frame(width: 500)
}
.scrollBehavior(.viewAligned(.center))
.autoAdvance(every: 4.0, loops: true)
```

@{ScrollViewExample4}

This enables script-driven scrolling that advances at a fixed interval, can loop or stop at the end, and respects the configured scroll axis.

For marquee-style or showcase content, `ScrollView` supports seamless infinite scrolling that pauses on hover:

```swift
ScrollView(.horizontal, id: "logos") {
   Color.blue
      .frame(width: 500)
   Color.red
      .frame(width: 500)
   Color.yellow
      .frame(width: 500)
}
.continuousScroll(duration: 15)
```

@{ScrollViewExample5}

---

## Programmatic Scrolling

`ScrollView` can be controlled programmatically using actions, making it easy to build custom controls such as next/previous buttons, pagination dots, or synced navigation. All scroll actions target a `ScrollView` by its `id`.

### Scroll to a Specific Slide

Use `ScrollTo(index:id:)` to scroll to a specific child by index (0-based):

```swift
Button("Go to second item", action: .scroll(to: 1, id: "features"))
```

This smoothly scrolls the targeted slide into view and centers it along the scroll axis.

### Scroll Forward and Backward

Use `ScrollForward(id:)` and `ScrollBackward(id:)` to navigate between items:

```swift
ScrollView(id: "myScrollView") {
   Color.blue
   Color.red
   Color.yellow
}
.scrollViewItemSizing(.flexible)

HStack {
   Button("Last", action: .scrollBackward(in: "myScrollView"))
   Spacer()
   Button("Next", action: .scrollForward(in: "myScrollView"))
}
```

@{ScrollViewExample6}
