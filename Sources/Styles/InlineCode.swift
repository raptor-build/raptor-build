//
// InlineCode.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct InlineCode: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        if environment.colorScheme == .dark {
            content
                .background(Color(red: 150, green: 150, blue: 150, opacity: 20%))
        } else {
            content
                .font(.custom("MDIO"))
                .background(Color(red: 150, green: 150, blue: 150, opacity: 14%))
                .cornerRadius(4)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
        }
    }
}
