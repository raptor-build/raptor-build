//
// TableExamples.swift
// RaptorBuild
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

struct TableExample1: PostWidget {
    var body: some HTML {
        Table {
           TableRow {
               "Ada Lovelace"
               "12 Algorithm Way"
               "London"
               "UK"
           }

           TableRow {
               "Grace Hopper"
               "1 Compiler Lane"
               "Arlington"
               "Virginia"
           }

           TableRow {
               "Alan Turing"
               "43 Enigma Road"
               "Manchester"
               "UK"
           }
        }
    }
}

struct TableExample2: PostWidget {
    private struct Developer: Identifiable, Hashable, Sendable {
        let id = UUID()
        let name: String
        let email: String
        let team: String
        let location: String
    }

    private let developers: [Developer] = [
        Developer(
            name: "Alex Morgan",
            email: "alex.morgan@company.com",
            team: "Platform",
            location: "San Francisco"
        ),
        Developer(
            name: "Jamie Chen",
            email: "jamie.chen@company.com",
            team: "Design Systems",
            location: "New York"
        ),
        Developer(
            name: "Riley Patel",
            email: "riley.patel@company.com",
            team: "Infrastructure",
            location: "London"
        ),
        Developer(
            name: "Taylor Brooks",
            email: "taylor.brooks@company.com",
            team: "Developer Experience",
            location: "Remote"
        )
    ]

    var body: some HTML {
        Table(developers) { developer in
           TableRow {
               developer.name
               developer.email
               developer.team
               developer.location
           }
        } header: {
           "Name"
           "Email"
           "Team"
           "Location"
        }
    }
}

struct TableExample3: PostWidget {
    private struct ProjectMember: Identifiable {
        let id = UUID()
        let name: String
        let role: String
        let primaryLanguage: String
        let yearsExperience: String
    }

    private let projectMembers: [ProjectMember] = [
        .init(name: "Alex Morgan", role: "Engineer", primaryLanguage: "Swift", yearsExperience: "6"),
        .init(name: "Jamie Chen", role: "Designer", primaryLanguage: "TypeScript", yearsExperience: "5"),
        .init(name: "Riley Patel", role: "SRE", primaryLanguage: "Go", yearsExperience: "8")
    ]

    var body: some HTML {
        Table(projectMembers) { member in
            TableRow {
                member.name
                member.role
                member.primaryLanguage
                member.yearsExperience
            }
        } header: {
            "Name"
            "Role"
            "Language"
            "Experience"
        }
        .tableStyle(.stripedRows)
        .tableRowSeparator(.hidden)
    }
}

struct TableExample4: PostWidget {
    private struct Location: Identifiable {
        let id = UUID()
        let city: String
        let country: String
        let region: String
    }

    private let locations: [Location] = [
        .init(city: "San Francisco", country: "USA", region: "North America"),
        .init(city: "London", country: "UK", region: "Europe"),
        .init(city: "Tokyo", country: "Japan", region: "Asia"),
        .init(city: "Sydney", country: "Australia", region: "Oceania")
    ]

    var body: some HTML {
        Table(locations, filterTitle: "Filter locations") { location in
            TableRow {
                location.city
                location.country
                location.region
            }
        }
    }
}

struct TableExample5: PostWidget {
    var body: some HTML {
        Table {
            TableRow {
                "Server Status"
                "Operational"
            }
            .tableRowSeparatorTint(.accent)

            TableRow {
                "Backup Status"
                "Running"
            }
            .tableRowSeparatorTint(.gray)
        }
    }
}

struct TableExample6: PostWidget {
    private let labeledAlignments: [(String, Alignment)] = [
        ("Top Leading", .topLeading),
        ("Top", .top),
        ("Top Trailing", .topTrailing),
        ("Leading", .leading),
        ("Center", .center),
        ("Trailing", .trailing),
        ("Bottom Leading", .bottomLeading),
        ("Bottom", .bottom),
        ("Bottom Trailing", .bottomTrailing)
    ]
    var body: some HTML {
        Table {
            TableRow {
                ForEach(labeledAlignments) { label, alignment in
                    TableColumn {
                        Text(label)
                    }
                    .alignment(alignment)
                }
            }
        }
        .frame(height: 100)
    }
}

struct TableExample7: PostWidget {
    var body: some HTML {
        Table {
            TableRow {
                "Q1"
                "Q2"
                "Q3"
            }
            .multilineTextAlignment(.center)

            TableRow {
                TableColumn {
                    "Annual summary covering all quarters."
                }
                .tableCellColumns(3)
                .alignment(.center)
            }
        }
        .tableStyle(.stripedRows)
    }
}
