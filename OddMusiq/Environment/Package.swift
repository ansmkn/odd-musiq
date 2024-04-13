// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Environment",
    products: [
        .library(
            name: "Environment",
            targets: ["Environment"]),
        .library(
            name: "FeatureToggles",
            targets: ["FeatureToggles"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "Environment",
            dependencies: []
        ),
        .target(
            name: "FeatureToggles",
            dependencies: ["Environment"]
        ),
        .testTarget(
            name: "EnvironmentTests",
            dependencies: ["Environment"]
        )
    ]
)
