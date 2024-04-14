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
            targets: ["NetworkService"])
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
//        .testTarget(
//            name: "SongsListTests",
//            dependencies: ["SongsList"]
//        )
    ]
)
