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
        .package(name: "Environment", path: "../Environment")
    ],
    targets: [
        .target(
            name: "FeatureToggles",
            dependencies: [
                .product(name: "Environment", package: "Environment"),
            ]
        ),
        .testTarget(
            name: "FeatureTogglesTests",
            dependencies: ["FeatureToggles"]
        )
    ]
)
