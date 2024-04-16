// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(
            name: "Router",
            targets: ["Router"]),
        .library(
            name: "NetworkService",
            targets: ["NetworkService"]),
        .library(
            name: "PresistenceService",
            targets: ["PresistenceService"]),
        .library(
            name: "PlayerService",
            targets: ["PlayerService"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Router",
            dependencies: [
            ]
        ),
        .target(
            name: "NetworkService",
            dependencies: []
        ),
        .target(
            name: "PresistenceService",
            dependencies: []
        ),
        .target(
            name: "PlayerService",
            dependencies: []
        )
//        .testTarget(
//            name: "SongsListTests",
//            dependencies: ["SongsList"]
//        )
    ]
)
