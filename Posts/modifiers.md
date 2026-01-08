---
title: Modifiers
date: 2025-12-20 23:30
description: Modifiers for styling and transforming HTML elements, custom HTMLModifier types, composable chains, reusable transformations, and extensions.
---

Modifiers let you transform, style, or augment HTML elements in a composable way. They take an existing element and return a new one with additional behavior or appearance applied.

You use modifiers constantly—things like `.font()`, `.margin()`, `.background()`, `.hoverEffect()`, and `.frame()` are all modifiers. They can be chained, reordered, and applied consistently across many element types.

```swift
Text("Hello")
   .font(.title3)
   .margin(.bottom, 10)
   .foregroundStyle(.secondary)
```

---

## Creating Custom Modifiers

For simple cases, you can define a modifier as an extension on `HTML`. This is often enough when the modifier is small and self-contained:

```swift
extension HTML {
   func redBackground() -> some HTML {
       self.background(.red)
   }
}
```

When a modifier has its own state, logic, or needs to be reused across many elements, you can define it as a custom `HTMLModifier`. This helps keep your code organized and makes intent clearer:

```swift
struct AlertModifier: HTMLModifier {
   func body(content: Content) -> some HTML {
       content
           .foregroundStyle(.yellow)
           .background(.red)
   }
}
```

Expose these modifiers through an extension on `HTML`:

```swift
extension HTML {
   func alert() -> some HTML {
       modifier(AlertModifier())
   }
}
```

Then use it like any other modifier:

```swift
Text("Don't forget!")
   .alert()
```
