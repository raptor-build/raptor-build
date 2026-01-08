---
title: Getting Started
date: 2025-12-20 23:59
description: Learn how to install Raptor, create and build your first site, preview it locally, and understand the workflow for developing static websites in Swift.
---

Raptor is a static site generator for Swift developers who'd rather write Swift than wrangle HTML and CSS. Think SwiftUI-style syntax, but purpose-built for creating websites that look great everywhere.

Raptor doesn't try to convert SwiftUI code to HTML or just wrap HTML tags in Swift. Instead, it gives you an expressive API that feels familiar if you know SwiftUI, but works specifically for building static sites—even if you've never touched web development before.

## What You'll Need

Raptor uses modern Swift features and requires up-to-date tooling:

- **Swift:** 6.2 or newer
- **Xcode:** 26 or newer
- **macOS:** 15.6 (Sequoia) or newer

---

## Installing the Command-Line Tool

The easiest way to get started is with Raptor's command-line tool. It handles everything from creating new projects to building and previewing your site.

Here's how to install it:

1. Clone the repository:
   ```bash
   git clone https://github.com/raptor-build/raptor
   ```
2. Move into the project:
   ```bash
   cd raptor
   ```
3. Build the tool:
   ```bash
   make
   ```
4. Install it system-wide:
   ```bash
   make install
   ```
   
   Or install it to a custom location:

   ```bash
   make install PREFIX_DIR=/my/install/path
   ```

   If you run into permission issues, try this instead:

   ```bash
   sudo make install
   ```

---

## Creating Your First Site

Once the CLI is installed, spinning up a new site takes one command:
```bash
raptor new ExampleSite
```

This creates a complete Swift package based on the [Raptor Starter Template](https://github.com/raptor-build/raptor-starter){target="_blank"}, with everything configured and ready to go. To open it in Xcode:

```bash
cd ExampleSite
open Package.swift
```

## Building Your Site

When you're ready to generate your site, just run:

```bash
raptor build
```

Raptor creates a `Build` directory containing all the HTML, CSS, JavaScript, and assets needed to publish your site.

## Previewing Your Work

Don't double-click the HTML files in Finder to preview your site. That opens them directly in your browser, which means they can't find resources like stylesheets and scripts—so everything looks broken.

Instead, use Raptor's built-in preview server:

```bash
raptor run --preview
```

This launches a local web server and opens your site in your browser. Now you can work in Xcode, rebuild with <kbd>Cmd+R</kbd>, and refresh your browser to see your changes instantly.

---

## Learning by Example

The [raptor-build/raptor-build](https://github.com/raptor-build/raptor-build){target="_blank"} repository is packed with examples showing real-world layouts, components, and modifiers. If you're looking for model code to learn from or adapt for your own projects, that's the place to start.

## License

Raptor is licensed under the GNU General Public License v3+ (GPLv3+). You're free to build and publish any kind of website—personal, commercial, whatever—and all the code your site generates is completely yours. Raptor itself can be used as a dependency in GPLv3-compatible open-source projects, with separate licensing available for proprietary applications.
