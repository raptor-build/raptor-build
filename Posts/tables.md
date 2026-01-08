---
title: Tables
date: 2025-12-20 23:32
description: Structured tables with rows, columns, headers, filtering, striped styles, captions, alignment, column spanning, and separator tinting.
---

`Table` lets you present structured, tabular data with support for headers, filtering, striped styles, captions, and fine-grained row and column alignment.

---

## Creating a Table

A table is composed of rows and columns, declared using builders. Each row represents a horizontal slice of data, and each column represents one cell within that row.

At its simplest, a table can be defined entirely inline:
```swift
Table {
   TableRow {
       "Ada Lovelace"
       "12 Algorithm Way"
       "London"
       "UK"
   }

   TableRow {
       "Grace Hopper"
       "1 Compiler Lane"
       "Arlington"
       "Virginia"
   }

   TableRow {
       "Alan Turing"
       "43 Enigma Road"
       "Manchester"
       "UK"
   }
}
```

@{TableExample1}

Rather than hardcoding rows, you can generate them from a collection using a closure. To clarify what each column represents, provide a header builder:

```swift
Table(developers) { developer in
   TableRow {
       developer.name
       developer.email
       developer.team
       developer.location
   }
} header: {
   "Name"
   "Email"
   "Team"
   "Location"
}
```

@{TableExample2}

---

## Table Styles

Apply striped rows or columns using `tableStyle(_:)` to improve readability:

```swift
Table(projectMembers) { member in
   TableRow {
       member.name
       member.role
       member.primaryLanguage
       member.yearsExperience
   }
} header: {
   "Name"
   "Role"
   "Language"
   "Experience"
}
.tableStyle(.stripedRows)
.tableRowSeparator(.hidden)
```

@{TableExample3}

Available styles include `.stripedRows` and `.stripedColumns`. Both optionally support rounded corners depending on your style configuration.

---

## Filtering

To allow users to filter table rows, provide a `filterTitle` when creating the table:

```swift
Table(locations, filterTitle: "Filter locations") { location in
   TableRow {
       location.city
       location.country
       location.region
   }
}
```

@{TableExample4}

This automatically inserts a search field above the table and filters rows based on visible text content.

---

## Row Separators

You can customize the color of the separator that follows an individual row using `tableRowSeparatorTint(_:)`:

```swift
Table {
   TableRow {
       "Server Status"
       "Operational"
   }
   .tableRowSeparatorTint(.accent)

   TableRow {
       "Backup Status"
       "Running"
   }
}
```

@{TableExample5}

---

## Alignment and Spanning

### Alignment

Rows align to the top-leading edge by default. To change alignment for individual columns, wrap content in `TableColumn` and apply a modifier:

```swift
Table {
   TableRow {
       ForEach(Alignment.allCases) { alignment in
           TableColumn {
               String(describing: alignment)
           }
           .alignment(alignment)
       }
   }
}
```

@{TableExample6}

### Column Spanning

Columns can span multiple slots using `tableCellColumns(_:)`:

```swift
Table {
   TableRow {
       "Q1"
       "Q2"
       "Q3"
   }
   .multilineTextAlignment(.center)

   TableRow {
       TableColumn {
           "Annual summary covering all quarters."
       }
       .tableCellColumns(3)
       .alignment(.center)
   }
}
.tableStyle(.stripedRows)
```

@{TableExample7}

---

## Captions and Accessibility

Tables can include an optional caption, which is displayed visually and announced by screen readers:

```swift
Table {
   // rows
}
.caption("Deployment environment overview")
```
