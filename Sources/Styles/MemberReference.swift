//
// MemberReference.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

public struct MemberReference: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(.clear)
                .plainTextColor(.blue)
                .functionColor(.blue)
                .variableColor(.blue)
                .propertyColor(.blue)
                .parameterColor(.blue)
                .unlabeledParameterColor(.blue)
                .defaultColor(.gray)

        case .light, .any:
            code
                .backgroundColor(.clear)
                .plainTextColor(.blue.weighted(.dark))
                .functionColor(.blue.weighted(.dark))
                .variableColor(.blue.weighted(.dark))
                .propertyColor(.blue.weighted(.dark))
                .parameterColor(.blue.weighted(.dark))
                .unlabeledParameterColor(.blue.weighted(.dark))
                .defaultColor(.gray.weighted(.semiDark))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == MemberReference {
    static var appleInline: Self { MemberReference() }
}
