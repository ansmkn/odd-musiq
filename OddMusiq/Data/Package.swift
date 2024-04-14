// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        )
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Core", path: "../Core"),
        .package(name: "Services", path: "../Services"),
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                .product(name: "Entities", package: "Domain"),
                .product(name: "Container", package: "Core"),
                .product(name: "RepositoryProtocol", package: "Domain"),
                .product(name: "NetworkService", package: "Services"),
            ]
        ),
        .testTarget(
            name: "RepositoriesTests",
            dependencies: [
                "Repositories"
            ]
        )
    ]
)
