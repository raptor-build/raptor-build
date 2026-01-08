//
// PresentationExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct ModalExample1: PostWidget {
    var body: some HTML {
        VStack {
            Button("Open modal", action: .showModal("myModal"))
                .modal(id: "myModal", alignment: .center) {
                    Section {
                        Text("Hello from a modal!")
                        Button("Close", action: .dismissModal("myModal"))
                    }
                    .background(.white)
                    .cornerRadius(12)
                    .padding(40)
                }
        }
    }
}

struct ModalExample2: PostWidget {
    var body: some HTML {
        VStack {
            Button("Open modal", action: .showModal("myModal2"))
                .modal(id: "myModal2", alignment: .center) {
                    Section {
                        Text("Hello from a modal!")
                        Button("Close", action: .dismissModal("myModal2"))
                    }
                    .background(.white)
                    .cornerRadius(12)
                    .padding(40)
                    .presentationBackground(.black)
                    .interactiveDismissDisabled()
                }
        }
    }
}

struct PopoverExample1: PostWidget {
    var body: some HTML {
        VStack {
            Button("Show info", action: .showPopover("myPopover"))
                .popover(id: "myPopover") {
                    Section {
                        Text("Click outside to dismiss")
                            .foregroundStyle(.black)
                    }
                    .background(.white)
                    .cornerRadius(8)
                    .padding(20)
                }
        }
        .opaqueMarkupGroup()
    }
}
