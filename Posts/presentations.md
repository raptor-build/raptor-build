---
title: Presentations
date: 2025-12-20 23:28
description: Present modal dialogs and popovers, control alignment and dismissal behavior, and customize presentation backgrounds.
---

Use presentations to display modals and popovers—temporary UI that appears over your content. They work with standard actions and modifiers for positioning and styling.

---

## Modals

Modals are linked to their triggers by ID, so you can declare them anywhere. Open them using Raptor’s built-in actions like `ShowModal` and `DismissModal`:

```swift
Button("Open modal", action: .showModal("myModal"))
   .modal(id: "myModal", alignment: .center) {
       Section {
           Text("Hello from a modal!")
           Button("Close", action: .dismissModal("myModal"))
       }
       .background(.white)
       .cornerRadius(12)
       .padding(40)
   }
```

@{ModalExample1}

By default, modals block interaction with page content and trap keyboard focus. Users can dismiss them by pressing <kbd>Esc</kbd>. To prevent dismissal, use `interactiveDismissDisabled()`.

You can customize the presentation backdrop independently of the content itself using `presentationBackground(_:)`:

```swift
Button("Open modal", action: .showModal("alert"))
   .modal(id: "alert") {
      AlertView()
          .interactiveDismissDisabled()
          .presentationBackground(.black)
}
```

@{ModalExample2}

---

## Popovers

Unlike a modal, a popover doesn't block page interactions and can be dismissed by clicking outside it:

```swift
Button("Show info", action: .showPopover("myPopover"))
   .popover(id: "myPopover") {
      Section {
          Text("Click outside to dismiss")
             .foregroundStyle(.black)
      }
      .background(.white)
      .cornerRadius(8)
      .padding(20)
   }
```

@{PopoverExample1}

Popovers default to `.bottomTrailing`, but you can specify an alignment. For precise positioning, you can anchor a popover to a specific side of the triggering element:

```swift
Button("Show info", action: .showPopover("more"))
   .popover(id: "more", anchor: .top) {
      Text("Another detail")
   }
```

@{AlertWidget:Anchor-based popovers rely on newer browser features and might not render correctly in all browsers.}
