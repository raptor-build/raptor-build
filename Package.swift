// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "RaptorBuild",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(
            url: "https://github.com/raptor-build/raptor.git",
            branch: "main"
        )
    ],
    targets: [
        .executableTarget(
            name: "RaptorBuild",
            dependencies: [
                .product(name: "Raptor", package: "Raptor")
            ],
            resources: [.process("Resources")]
        )
    ]
)
