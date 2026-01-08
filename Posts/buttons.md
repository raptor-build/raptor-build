---
title: Buttons
date: 2025-12-20 23:43
description: Create interactive buttons with actions, tinting, sizing, shapes, control sizes, multiple actions, and reusable button styles.
---

The most common way to create a `Button` is with a text label and a single action:

```swift
Button("Download", action: .navigate(to: "/download"))
```

To trigger more than one action, use the action-builder initializer:

```swift
Button("Submit", role: .submit) {
   SubmitAction()
   ResetFormAction()
}
```

### Custom Actions

Define your own actions by conforming to the `Action` protocol. Actions compile directly to JavaScript and execute client-side:

```swift
struct LogAction: Action {
   func compile() -> String {
       "console.log('Button pressed')"
   }
}
```

Once defined, custom actions work anywhere a button accepts an action:

```swift
Button("Log", action: LogAction())
```

---

## Button Icons

Buttons can also include system icons. Control where icons appear relative to the button label via `buttonIconPlacement(_:)`:

```swift
HStack(spacing: 10) {
   ForEach(ButtonIconPlacement.allCases) { placement in
      Button("Settings", systemImage: "gear-fill", action: OpenSettings())
         .buttonIconPlacement(placement)
   }
}
```

@{ButtonExample2}

---

## Modifiers

Buttons support various modifiers to customize their appearance and behavior, including:

**`tint(_:)`** — Control button color

**`buttonSizing(_:)`** — Control how the button occupies space (`.fitted` or `.flexible`)

**`buttonShape(_:)`** — Set corner radius and shape (`.roundedRect`, `.capsule`, `.rect`, `.circle`)

**`controlSize(_:)`** — Adjust padding, font size, and overall scale

---

## Primitive Button Styles

For quick styling without creating custom `ButtonStyle` types, use primitive button styles:

```swift
let styles = PrimitiveButtonStyle.allCases
let sizes = ControlSize.allCases
let shapes = ButtonShape.allCases
let colors = [Color.blue, .indigo, .purple, .pink, .red]

ForEach(styles.indices) { index in
   let style = styles[index]
   let size = sizes[index % sizes.count]
   let shape = shapes[index % shapes.count]
   let color = colors[index % tints.count]

   Button("Tap!", action: SubmitAction())
      .buttonStyle(style)
      .controlSize(size)
      .buttonShape(shape)
      .tint(colors[index % tints.count])
      .margin(.trailing, 20)
}
```

@{ButtonExample1}

**Available styles:**

- `.plain` — No background or border, appears as regular text
- `.borderless` — Like plain but with accent color and tap feedback
- `.bordered` — Border with transparent background
- `.filled` — Solid background with border
- `.filledProminent` — Enhanced filled style with larger padding, bold font, and shadow for primary actions

For more complex, state-aware styling needs, create a custom `ButtonStyle` instead (see below).

---

## Button Styles

For reusable, state-aware styling, use the `ButtonStyle` protocol:

```swift
struct PrimaryButtonStyle: ButtonStyle {
   func style(content: Content, phase: Phase) -> Content {
       switch phase {
       case .initial:
           content
               .background(.red)
               .foregroundStyle(.white)
               .cornerRadius(12)
       case .hovered:
           content.background(.pink)
       case .pressed:
           content.background(.orange)
       case .disabled:
           content.background(.gray)
       }
   }
}
```

To apply it:

```swift
Button("Submit", action: .submit())
   .buttonStyle(PrimaryButtonStyle())
```

@{ButtonExample3}
