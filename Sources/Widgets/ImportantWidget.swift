//
// ImportantWidget.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ImportantWidget: PostWidget {
    @WidgetContent(default: "An alert that will be injected...") private var content
    var body: some HTML {
        Callout(color: .pink, content: content)
    }
}
