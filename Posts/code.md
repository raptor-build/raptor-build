---
title: Code
date: 2025-12-20 23:38
description: Configure syntax highlighting for code blocks, apply themes, show line numbers and invisibles, and manage highlighting behavior with custom post processors.
---

Raptor provides built-in syntax highlighting for code blocks. When you use `CodeBlock` or `Code` with an explicit language—or rely on the `Site`'s default post processor to render Markdown—Raptor automatically tracks and includes the required syntax highlighters at build time.

## Code Blocks

Create code blocks with `CodeBlock`:

```swift
CodeBlock(.swift) {
   """
   let value = compute()
   print(value)
   """
}
```

Override the site's default syntax highlighting behavior using modifiers:

```swift
CodeBlock(.swift) {
   """
   let value = compute()
   print(value)
   """
}
.lineNumberVisibility(.visible)
.whitespaceCharacterVisibility(.visible)
.highlightedLines(2)
.syntaxHighlighterTheme(.monokai)
```

@{CodeExample1}

Available modifiers include:

- **`lineNumberVisibility(_:)`** — Show or hide line numbers
- **`whitespaceCharacterVisibility(_:)`** — Show or hide spaces and line breaks
- **`highlightedLines(_:)`** — Emphasize specific lines or ranges
- **`syntaxHighlighterTheme(_:)`** — Override the syntax highlighting theme for this code block
- **`lineHighlightOffset(_:)`** — Fine-tune vertical alignment of highlighted lines (useful for custom typefaces)

---

## Syntax Highlighting Configuration

Configure syntax highlighting behavior site-wide using `syntaxHighlighterConfiguration`:

```swift
struct MySite: Site {
   var syntaxHighlighterConfiguration = SyntaxHighlighterConfiguration(
       defaultLanguage: .swift,
       lineNumberVisibility: .visible,
       inlineCodeHighlighting: .enabled
   )
}
```

When using Raptor's default post processor, these settings apply automatically. **Custom post processors are responsible for honoring the site's configuration.**

For more on configuring syntax highlighting colors and themes, see [Syntax Highlighting](/syntax-highlighting).

@{AlertWidget: If your site uses the default post processor and includes code blocks with angle brackets (`<`…`>`), the HTML prettifier will interpret these as HTML tags and break the code's formatting. To fix this, either set `prettifyHTML` to `false` in `Site`, or replace `<` and `>` with `&amp;lt;` and `&amp;gt;`.}
