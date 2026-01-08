---
title: Effects
date: 2025-12-20 23:26
description: Add interactive, state-driven, and environment-aware behavior to your views using hover effects, entry animations, identity effects, and environment-driven effects.
---

Use effects to add motion, interaction, and state-aware behavior to your views. Raptor currently supports four kinds of effects:

---

## Hover Effects

Hover effects apply visual changes when the user hovers over an element:

```swift
LinkGroup(target: post) {
   Text(post.title)
       .font(.title3)

   Text(post.description)
}
.background(.red)
.padding()
.cornerRadius(8)
.hoverEffect { content in
   content.scaleEffect(1.025)
}
```

@{HoverEffectExample1}

The closure receives a configurable content proxy and returns a modified version describing the hover state.

Hover effects support a focused subset of visual modifiers, including:

- `scaleEffect(_:)`
- `rotationEffect(_:)`
- `offset(x:y:)`
- `blur(_:)`
- `brightness(_:)`
- `saturation(_:)`
- `grayscale(_:)`

Like keyframe animations, you can specify a transform anchor to control how scaling or rotation behaves via the modifier’s `anchor` parameter.

---

## Entry Effects

Entry effects describe how a view transitions when it appears on the screen:

```swift
Color.blue
   .frame(width: 200, height: 200)
   .scaleEffect(0.5, anchor: .center)
   .entryEffect(anchor: .bottomLeading) { content in
       content
           .scaleEffect(1)
   }
}
```

@{EntryEffectExample1}

The initial modifiers define the starting state, and the `entryEffect` closure defines the final state once the element enters the screen.

---

## Environment Effects

Environment effects allow views to react dynamically to environment values, such as browser widths, media conditions, or user preferences:

```swift
Color.pink
    .environmentEffect(\.horizontalSizeClass) { content, sizeClass in
        if sizeClass == .compact {
            content.background(.yellow)
        }
    }
```

@{EnvironmentEffectExample1}

---

## Identity Effects

Identity effects allow views to react to identity traits applied to elements at runtime. Identity traits are attributes added, removed, or toggled via actions. Identity effects observe these traits and activate styles when they are present.

### Creating an Identity Trait

To define a custom identity trait, create an empty marker type that conforms to `IdentityTrait`:

```swift
struct BackgroundTrait: IdentityTrait {}
```

Identity traits don't store values—they exist purely as presence/absence markers derived from the trait's type name.

### Defining an Identity Effect


Identity traits are applied using actions, such `AddIdentityTrait`, `RemoveIdentityTrait`, and `ToggleIdentityTrait`:

```swift
HStack(spacing: 25) {
   Button(
      "Toggle Color", 
      action: .toggleIdentityTrait(BackgroundTrait.self, for: "myID")
   )

   Color.clear
      .id("myID")
      .identityEffect(BackgroundTrait.self) { content in
         content.background(.indigo)
      }
}
```

@{IdentityEffectExample1}

The effect activates whenever the associated identity trait is present on the element.
