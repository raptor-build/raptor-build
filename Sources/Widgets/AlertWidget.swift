//
// AlertWidget.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct AlertWidget: PostWidget {
    @WidgetContent(default: "An alert that will be injected...") var content
    var body: some HTML {
        Callout(color: .red, content: content)
    }
}
