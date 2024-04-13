// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "SongsList",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "SongsList",
            targets: ["SongsList"])
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Core", path: "../Core"),
        .package(name: "Router", path: "../Router")
    ],
    targets: [
        .target(
            name: "SongsList",
            dependencies: [
                .product(name: "Coordinator", package: "Core"),
                .product(name: "Container", package: "Core"),
                .product(name: "Router", package: "Router"),
                .product(name: "UseCaseProtocol", package: "Domain")
            ]
        ),
//        .testTarget(
//            name: "SongsListTests",
//            dependencies: ["SongsList"]
//        )
    ]
)
