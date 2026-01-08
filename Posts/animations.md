---
title: Animations
date: 2025-12-20 23:27
description: Animate elements with transition modifiers, keyframe animations, hover and tap triggers, viewport entry animations, timing curves, and transform anchors.
---

Raptor provides a lightweight animation system for UI feedback, transitions, and expressive motion. Animations are applied using modifiers, keeping them composable and easy to reason about.

---

## Simple Animations

For most use cases, you only need a basic transition. The animation modifier configures how property changes animate—controlling timing, duration, and speed for transitions like color, opacity, transform, or size:

```swift
Disclosure("What is this?") {
   Text("Click above to reveal this text!")
}
.animation(.bouncy.speed(0.5))
```

@{AnimationExample1}

Raptor enables animations by default. To opt out, simply pass `nil` to `animation(_:)`.

```swift
Disclosure("What is this?") {
   Text("Click above to reveal this text!")
}
.animation(nil)
```

@{AnimationExample2}

---

## Keyframe Animations

For more advanced motion—such as entrances, multi-step transforms, or expressive UI effects—use keyframe-based animations.

Keyframe animations are defined over a timeline from `0%` to `100%`. You describe how the element should look at each point, and the animation runs automatically:
```swift
Image(systemName: "balloon")
   .keyframeAnimator(trigger: .tap) { content, percent in
      if percent == 0% {
          content
              .scaleEffect(1 + percent.value * 0.5)
              .opacity(1)
      } else if percent == 100% {
          content
              .scaleEffect(2)
              .opacity(0)
      }
   }
```

@{AnimationExample3}

The animation runs when the specified trigger occurs.

Animations can be activated by user interaction or lifecycle events using triggers:

- `.hover` — when the pointer enters the element
- `.tap` — when the element is clicked or tapped
- `.entry` — when the element enters the viewport

This makes animations feel responsive and context-aware without manual event handling.

You can fine-tune animation behavior using `AnimationOption`s:

```swift
let animationOptions: [AnimationOption] = [
   .duration(2),
   .timingCurve(.bouncy),
   .repeatCount(.infinity),
   .lifecycle(.automatic),
   .direction(.forward.reversing())
]

Image(systemName: "balloon")
   .keyframeAnimator(
      trigger: .hover, 
      options: animationOptions
   ) { content, percent in
       if percent == 0% {
           content
               .scaleEffect(1)
               .foregroundStyle(.red)
       } else if percent == 100% {
           content
               .scaleEffect(2)
               .foregroundStyle(.blue)
       }
   }
```

@{AnimationExample4}

Options control duration, timing curves, delays, repetition, direction, and playback speed.

Some animations require a specific transform origin. You can provide an anchor point to control how transforms are applied:

```swift
Color.blue
    .frame(width: 50, height: 50)
    .keyframeAnimator(
        trigger: .entry,
        anchor: .topLeading
    ) { content, percent in
        if percent == 0% {
            content
                .scaleEffect(1)
        } else if percent == 100% {
            content
                .scaleEffect(3)
        }
    }
```

@{AnimationExample5}
