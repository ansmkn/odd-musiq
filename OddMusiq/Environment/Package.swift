// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Environment",
    products: [
        .library(
            name: "Environment",
            targets: ["Environment"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "Environment",
            dependencies: []
        ),
        .testTarget(
            name: "EnvironmentTests",
            dependencies: ["Environment"]
        )
    ]
)
