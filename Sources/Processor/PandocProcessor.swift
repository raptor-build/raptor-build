//
// PandocProcessor.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

/// A `PostProcessor` that delegates Markdown rendering to Pandoc.
struct PandocProcessor: PostProcessor {
    /// Languages that may appear in code blocks after processing.
    var syntaxHighlighterLanguages: Set<SyntaxHighlighterLanguage> = [.swift]

    /// Whether the document title should be removed from the HTML body.
    var removeTitleFromBody: Bool

    /// Filesystem path to the Pandoc executable.
    private let pandocPath = "/opt/homebrew/bin/pandoc"

    /// Creates a new Pandoc-backed post processor.
    /// - Parameter removeTitleFromBody:
    ///   Whether to strip the document title from the rendered HTML body.
    init(removeTitleFromBody: Bool = true) {
        self.removeTitleFromBody = removeTitleFromBody
    }

    /// Processes a Markdown string into HTML using Pandoc.
    /// - Parameter markup: Raw Markdown content.
    /// - Returns: A `ProcessedPost` containing the rendered HTML body.
    mutating func process(_ markup: String) throws -> ProcessedPost {
        // Resolve the directory containing this source file.
        // Lua filters are expected to live alongside this file.
        let sourceFileURL = URL(fileURLWithPath: #filePath)
        let filtersDirectory = sourceFileURL.deletingLastPathComponent()

        // Pandoc expects filesystem paths, not percent-encoded URLs.
        let codeFilterPath = filtersDirectory
            .appendingPathComponent("code-block-filter.lua")
            .path(percentEncoded: false)

        let titleFilterPath = filtersDirectory
            .appendingPathComponent("title-filter.lua")
            .path(percentEncoded: false)

        let body = try parse(
            markup,
            codeFilterPath: codeFilterPath,
            titleFilterPath: titleFilterPath
        )

        return .init(title: "", description: "", body: body)
    }

    /// Wraps rendered widget HTML in a raw markup block so it is preserved
    /// exactly as-is by the markup processor.
    /// - Parameter widgetHTML: The rendered HTML output of a post widget.
    /// - Returns: A string containing the widget HTML wrapped in a raw
    ///   markup block that prevents further processing or transformation.
    func delimitRawMarkup(_ widgetHTML: String) -> String {
        """
        ```{=html}
        \(widgetHTML)
        ```
        """
    }

    /// Invokes Pandoc to convert Markdown into HTML.
    /// - Parameters:
    ///   - content: Markdown source text.
    ///   - codeFilterPath: Filesystem path to the code block Lua filter.
    ///   - titleFilterPath: Filesystem path to the title Lua filter.
    /// - Returns: Rendered HTML output.
    private func parse(
        _ content: String,
        codeFilterPath: String,
        titleFilterPath: String
    ) throws -> String {
        try validatePandocInstallation()

        let (inputURL, outputURL) = try writeTempInput(content)

        do {
            try runPandoc(
                inputURL: inputURL,
                outputURL: outputURL,
                codeFilterPath: codeFilterPath,
                titleFilterPath: titleFilterPath
            )

            return try readAndCleanupOutput(
                inputURL: inputURL,
                outputURL: outputURL
            )
        } catch {
            throw PandocError.processingFailed(error.localizedDescription)
        }
    }

    /// Writes Markdown content to a temporary input file.
    /// - Parameter content: Markdown source text.
    /// - Returns: URLs for the input and output temporary files.
    private func writeTempInput(
        _ content: String
    ) throws -> (input: URL, output: URL) {
        let tempDirectory = FileManager.default.temporaryDirectory

        let inputURL = tempDirectory.appendingPathComponent(
            "pandoc-input-\(UUID().uuidString).md"
        )

        let outputURL = tempDirectory.appendingPathComponent(
            "pandoc-output-\(UUID().uuidString).html"
        )

        try content.write(
            to: inputURL,
            atomically: true,
            encoding: .utf8
        )

        return (inputURL, outputURL)
    }

    /// Executes Pandoc with the configured arguments.
    private func runPandoc(
        inputURL: URL,
        outputURL: URL,
        codeFilterPath: String,
        titleFilterPath: String
    ) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: pandocPath)

        let errorPipe = Pipe()
        process.standardError = errorPipe

        var arguments: [String] = [
            inputURL.path,
            "-o",
            outputURL.path,
            "--from=markdown",
            "--to=html5",
            "--wrap=none",
            "--embed-resources",
            "--no-highlight",
            "--lua-filter=\(codeFilterPath)"
        ]

        if removeTitleFromBody {
            arguments.append("--lua-filter=\(titleFilterPath)")
        }

        process.arguments = arguments

        try process.run()
        process.waitUntilExit()

        guard process.terminationStatus == 0 else {
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            let errorMessage =
                String(data: errorData, encoding: .utf8)
                    ?? "Unknown Pandoc error"

            throw PandocError.processingFailed(errorMessage)
        }
    }

    /// Ensures Pandoc is installed and accessible.
    private func validatePandocInstallation() throws {
        guard FileManager.default.fileExists(atPath: pandocPath) else {
            throw PandocError.notInstalled("""
            Pandoc was not found at \(pandocPath).
            Please install Pandoc using `brew install pandoc`,
            or update the configured Pandoc path.
            """)
        }
    }

    /// Reads Pandoc output and removes temporary files.
    /// - Returns: Rendered HTML output.
    private func readAndCleanupOutput(
        inputURL: URL,
        outputURL: URL
    ) throws -> String {
        defer {
            try? FileManager.default.removeItem(at: inputURL)
            try? FileManager.default.removeItem(at: outputURL)
        }

        return try String(
            contentsOf: outputURL,
            encoding: .utf8
        )
    }
}
