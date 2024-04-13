// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Router",
            targets: ["Router"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Router",
            dependencies: [
            ]
        ),
//        .testTarget(
//            name: "SongsListTests",
//            dependencies: ["SongsList"]
//        )
    ]
)
