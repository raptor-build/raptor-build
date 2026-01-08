---
title: Disclosures
date: 2025-12-20 23:37
description: Create accessible, expandable content using Disclosure, with native HTML semantics, coordinated grouping, and fully customizable label styles.
---

A `Disclosure` represents a single expandable section of content, commonly used to build accordions, FAQs, and progressive disclosure interfaces.

At its simplest, a disclosure consists of a label and some hidden content:

```swift
Disclosure("What is Raptor?") {
   Text("Raptor is a Swift static site generator.")
}
.border(.secondaryBackground)
.padding()
.cornerRadius(8)
```

@{DisclosureExample1}

Control whether it starts open with `isExpanded`, or customize the indicator with `disclosureLabelIndicator(_:)`:

```swift
Disclosure("Getting Started", isExpanded: true) {
    Text("This section is open by default.")
}
.disclosureLabelIndicator(.chevron)
```

---

## Custom Labels

For more control over the label content, provide a custom label:

```swift
Disclosure {
    SettingsView()
} label: {
    InlineText("Advanced Settings")
        .fontWeight(.bold)
}
```

@{DisclosureExample2}

This is useful for incorporating icons, formatted text, or composite labels.

---

## Coordinated Disclosure Groups (Accordions)

Group disclosures so that opening one closes the others, creating classic accordion behavior.

Use the `matchedTransitionEffect(id:)` modifier:

```swift
Disclosure("General", isExpanded: true) {
    Text("General settings")
}
.matchedTransitionEffect(id: "settings")

Disclosure("Account") {
    Text("Account settings")
}
.matchedTransitionEffect(id: "settings")
```

@{DisclosureExample3}

---

## Styling Disclosure Labels

Disclosure labels are styled using the `DisclosureLabelStyle` protocol, which responds to different interaction states:

- **`.closed`** — Default resting state
- **`.opened`** — When content is visible
- **`.hovered`** — Pointer hover state
- **`.focused`** — Keyboard focus state

@{ImportantWidget:Styles applied to the `closed` state persist through other states unless explicitly overridden.}

### Creating a Custom `DisclosureLabelStyle`

Define how the label looks in each interaction phase:

```swift
struct MyDisclosureStyle: DisclosureLabelStyle {
   func style(content: Content, phase: Phase) -> Content {
       switch phase {
       case .hovered:
           content
              .background(.pink)
       case .opened:
           content
              .background(.red)
       case .closed:
           content
              .cornerRadius(8)
              .disclosureLabelIndicator(.ellipsis)
       }
   }
}

```

Then apply it:

```swift
Disclosure {
   Text("Raptor is a Swift static site generator.")
       .padding(.horizontal, 25)
       .padding(.top, 15)
} label: {
   InlineText("What is Raptor?")
       .fontWeight(.medium)
       .padding(.horizontal, 25)
       .padding(.vertical, 15)
}
.disclosureLabelStyle(MyDisclosureStyle())
```

@{DisclosureExample4}

**Note:** When animating disclosures, use padding instead of margins on the content section. Margins can cause height measurements to change during animation, leading to hitches. Padding produces stable height calculations and smooth transitions.
