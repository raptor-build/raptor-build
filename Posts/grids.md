---
title: Grids
date: 2025-12-20 23:40
description: Build responsive, two-dimensional layouts using Grid and GridRow with flexible columns, adaptive spacing, alignment control, and explicit column sizing.
---

A `Grid` arranges content into rows and columns. You can either:

- Let the grid infer its column count automatically, or
- Explicitly define column sizes using `columns: [GridItemSize]`

Group content into rows using `GridRow`, or place items directly in the grid to span the full width:

```swift
Grid {
   GridRow {
       Color.blue
       Color.red
   }

   Color.yellow
}
```

@{GridExample1}

---

## Grid Rows

The grid uses the row with the most items to determine its column count. Use `gridCellColumns()` to span multiple cells—otherwise, rows with fewer items get blank spaces.

```swift
Grid {
   GridRow {
       Color.red
       Color.blue
       Color.yellow
   }

   GridRow {
       Color.green
       Color.orange
           .gridCellColumns(2)
   }

   GridRow {
       Color.pink
       Color.teal
   }
}
```

@{GridExample2}

---

## Explicit Column Sizes

For precise layout control, define column sizes explicitly using `columns: [GridItemSize]`:

```swift
Grid(columns: [.flexible, .fixed(200), .flexible]) {
   Color.teal
   Color.pink
   Color.yellow
}
```

@{GridExample3}

Each entry in the `columns` array maps directly to a CSS grid column definition.

### Available Column Sizes

- **`.automatic`** — Sizes itself based on its content
- **`.fixed(_:)`** — Constrained to an exact, non-flexible width
- **`.flexible`** — Expands to fill available space
- **`.flexible(minimum:)`** — Expands but never shrinks below the specified minimum width

---

## Flexible Layouts

Grids become responsive by combining flexible columns with standard CSS grid wrapping behavior.

A flexible column expands to fill available space, and when horizontal space becomes constrained, items naturally wrap into additional rows:

```swift
Grid(columns: [.flexible(minimum: .px(180))]) {
   ForEach(cards) { card in
       CardView(card)
   }
}
```

In this configuration, items grow to fill available horizontal space and wrap into new rows automatically when the container becomes too narrow.

You can also generate grid content dynamically from collections:

```swift
Grid(cards, columns: [.flexible(minimum: .180)]) { card in
   CardView(card)
}
```

## Alignment and Spacing

Grids support both alignment and spacing customization at initialization. Alignment controls how items are positioned within their grid cells:

```swift
Grid(alignment: .leading) {
   GridRow {
      Color.blue
         .frame(width: 50, height: 50)
      Color.yellow
         .frame(width: 50, height: 50)
   }
}
```

@{GridExample4}

Spacing defines the gap between rows and columns using pixel or semantic values:

```swift
Grid(spacing: .xSmall) {
   GridRow {
      Color.orange
      Color.indigo
   }
}
```

@{GridExample5}
