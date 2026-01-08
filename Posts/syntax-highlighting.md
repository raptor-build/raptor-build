---
title: Syntax Highlighting
date: 2025-12-20 23:47
description: Customize code block syntax highlighting with built-in themes, custom configurations, and per-language token colors.
---

Syntax highlighting styles code blocks in your posts and pages. Raptor includes built-in themes and lets you create custom themes for precise control over token colors.

## Using Built-In Themes

Raptor includes several built-in themes like `.xcode`, `.github`, `.monokai`, and more. Apply one in your site's theme:

```swift
struct MyTheme: Theme {
   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       site
           .syntaxHighlighterTheme(.xcode)
           .inlineCodeTheme(.github)
   }
}
```

Use `inlineCodeTheme(_:)` to apply a different theme to inline code than code blocks.

---

## Creating Custom Themes

Create a custom syntax-highlighting theme by conforming to the `SyntaxHighlighterTheme` protocol:

```swift
struct MyCodeTheme: SyntaxHighlighterTheme {
   func theme(code: Content, colorScheme: ColorScheme) -> Content {
       if colorScheme == .dark {
           code
               .backgroundColor(.black)
               .keywordColor(.purple)
               .stringColor(.red)
               .commentColor(.secondary)
       } else {
           code
               .backgroundColor(.white)
               .keywordColor(.blue)
               .stringColor(.orange)
               .commentColor(.gray)
       }
   }
}
```

Then use it in your theme:

```swift
site.syntaxHighlighterTheme(MyCodeTheme())
```

---

## Token Colors

Customize colors for specific token types:

```swift
code
   .keywordColor(.purple)        // if, func, return
   .typeColor(.blue)             // String, View, URL
   .functionColor(.cyan)         // Function and method names
   .variableColor(.primary)      // Variable names
   .stringColor(.red)            // String literals
   .numberColor(.orange)         // Numeric literals
   .commentColor(.secondary)     // Comments
   .operatorColor(.primary)      // +, ==, ->
   .annotationColor(.purple)     // @available, @MainActor
```

Available token types include:

- **Identifiers**  
`typeColor()`, `functionColor()`, `variableColor()`, `propertyColor()`, `parameterColor()`, `unlabeledParameterColor()`

- **Literals**  
`stringColor()`, `numberColor()`, `stringDelimiterColor()`, `interpolationDelimiterColor()`

- **Syntax**  
`keywordColor()`, `operatorColor()`, `punctuationColor()`

- **Metadata**  
`commentColor()`, `annotationColor()`, `directiveColor()`, `errorColor()`

Use `defaultColor()` as a fallback for token types without explicit colors.

---

## Forcing Light or Dark

By default, syntax highlighting responds to the active color scheme. Force a specific appearance using `light()` or `dark()`:

```swift
// Always use dark colors, regardless of color scheme
site.syntaxHighlighterTheme(.xcode.dark())
```

This is useful when you want code blocks to maintain consistent styling regardless of the user's theme preference.

---

## Syntax Highlighter Configuration

Control default syntax highlighting behavior using `SyntaxHighlighterConfiguration`. Set it on your site using the `syntaxHighlighterConfiguration` property.

### Properties

@{ReferenceWidget:var defaultLanguage: SyntaxHighlighterLanguage?}
: Language used when none is specified in code blocks.

@{ReferenceWidget:var lineNumberVisibility: Visibility}
: Whether line numbers appear by default.

@{ReferenceWidget:var lineWrapping: CodeBlockLineWrapping}
: How long lines are wrapped or truncated.

@{ReferenceWidget:var whitespaceCharacterVisibility: WhitespaceCharacterVisibility}
: Whether spaces and line breaks are rendered.

@{ReferenceWidget:var inlineCodeHighlighting: InlineCodeHighlightingMode}
: Whether inline code uses syntax highlighting.

When using Raptor's default post processor, these settings apply automatically. Custom post processors are responsible for implementing these preferences.

---

## Inline Code

In addition to using a `SyntaxHighlighterTheme` to style inline code site-wide, you can also create a `Style` implementation and applying it in your site's theme:

```swift
struct InlineCode: Style {
   func style(content: Content, environment: EnvironmentConditions) -> Content {
       content
           .font(.custom("IO"))
           .background(.backgroundColor)
           .cornerRadius(4)
           .padding(.horizontal, 4)
           .padding(.vertical, 2)
   }
}
```

Then apply it in your theme:

```swift
struct MyTheme: Theme {
   func theme(site: Content, colorScheme: ColorScheme) -> Content {
       site.inlineCodeStyle(InlineCode())
   }
}
```
