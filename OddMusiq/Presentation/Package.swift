// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15), .macOS(.v10_15)],
    products: [
        .library(
            name: "SongsList",
            targets: ["SongsList"])
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Core", path: "../Core")
    ],
    targets: [
        .target(
            name: "SongsList",
            dependencies: [
                .product(name: "UseCaseProtocol", package: "Domain"),
                .product(name: "Container", package: "Core"),
                .product(name: "Coordinator", package: "Core")
            ]
        ),
        .testTarget(
            name: "SongsListTests",
            dependencies: ["SongsList"]
        )
    ]
)
