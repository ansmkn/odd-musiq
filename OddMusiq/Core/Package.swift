// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(
            name: "Container",
            targets: ["Container"]),
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]),
        .library(
            name: "Router",
            targets: ["Router"]),
        .library(name: "ContainerTestUtils", targets: ["ContainerTestUtils"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "Container",
            dependencies: []
        ),
        .target(
            name: "Coordinator",
            dependencies: []
        ),
        .target(
            name: "Router",
            dependencies: []
        ),
        .target(
            name: "ContainerTestUtils",
            dependencies: ["Container"]
        ),
        .testTarget(
            name: "ContainerTests",
            dependencies: ["Container", "ContainerTestUtils"]
        )
    ]
)
