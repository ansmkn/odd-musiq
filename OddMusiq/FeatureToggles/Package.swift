// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "FeatureToggles",
    products: [
        .library(
            name: "FeatureToggles",
            targets: ["FeatureToggles"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "FeatureToggles",
            dependencies: []
        ),
        .testTarget(
            name: "FeatureTogglesTests",
            dependencies: ["FeatureToggles"]
        )
    ]
)
