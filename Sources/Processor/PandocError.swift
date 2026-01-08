//
// PandocError.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Errors that can occur when processing with Pandoc
public enum PandocError: Error {
    case notInstalled(String)
    case processingFailed(String)
    case invalidOutput
}

extension PandocError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notInstalled(let message):
            "Pandoc is not installed: \(message)"
        case .processingFailed(let message):
            "Pandoc processing failed: \(message)"
        case .invalidOutput:
            "Pandoc produced invalid output"
        }
    }
}
