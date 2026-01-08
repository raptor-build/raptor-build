//
// GridExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct GridExample1: PostWidget {
    var body: some HTML {
        Grid {
            GridRow {
                Color.blue
                Color.red
            }

            Color.yellow
        }
        .frame(height: 100)
    }
}

struct GridExample2: PostWidget {
    var body: some HTML {
        Grid {
           GridRow {
               Color.red
               Color.blue
               Color.yellow
           }

           GridRow {
               Color.green
               Color.orange
                   .gridCellColumns(2)
           }

           GridRow {
               Color.pink
               Color.teal
           }
        }
        .frame(height: 150)
    }
}

struct GridExample3: PostWidget {
    var body: some HTML {
        Grid(columns: [.flexible, .fixed(200), .flexible]) {
            Color.teal
            Color.pink
            Color.yellow
        }
        .frame(height: 150)
    }
}

struct GridExample4: PostWidget {
    var body: some HTML {
        Grid(alignment: .center) {
           GridRow {
               Color.blue
                   .frame(width: 50, height: 50)
               Color.yellow
                   .frame(width: 50, height: 50)
           }
        }
        .frame(height: 50)
    }
}

struct GridExample5: PostWidget {
    var body: some HTML {
        Grid(spacing: .xSmall) {
           GridRow {
               Color.orange
               Color.indigo
           }
        }
        .frame(height: 50)
    }
}
