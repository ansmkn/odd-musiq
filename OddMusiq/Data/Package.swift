// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        )
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain")
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                .product(name: "Entities", package: "Domain"),
                .product(name: "RepositoryProtocol", package: "Domain")
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
