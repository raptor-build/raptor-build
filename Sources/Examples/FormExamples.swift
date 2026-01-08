//
// FormExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct FormExample1: PostWidget {
    var body: some HTML {
        Form {
            TextField("One-Time Password")
            Button("Sign In", role: .submit, action: SubmitAction())
        }
    }
}

struct FormExample2: PostWidget {
    var body: some HTML {
        Form {
            TextField("Email")
            TextField("Password")
        }
        .labelStyle(.leading)
    }
}

struct FormExample3: PostWidget {
    var body: some HTML {
        SubscribeForm(.buttondown(""))
    }
}

struct FormExample4: PostWidget {
    var body: some HTML {
        GridForm {
            GridRow {
                TextField("Email")
                TextField("Password")
                    .textContentType(.password)
                Button("Sign In", action: SignInAction())
            }
        }
        .labelStyle(.hidden)
    }
}

struct FormExample5: PostWidget {
    var body: some HTML {
        SubscribeForm(.buttondown(""))
            .formStyle(.stacked)
            .emailFieldLabel("Your email")
            .subscribeButtonLabel("Join Newsletter")
    }
}
