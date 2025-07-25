// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "droid",
    products: [
        .library(name: "DroidMaterial", targets: ["DroidMaterial"]),
        .library(name: "Droid", targets: ["Droid"]),
    ],
    dependencies: [
        .package(path: "/Users/imike/Development/SwifDroid/jni-kit")
//        .package(url: "https://github.com/SwifDroid/jni-kit.git", from: "1.0.0"),
        .package(url: "https://github.com/PADL/AndroidLooper", from: "0.0.1")
    ],
    targets: [
        .target(name: "DroidMaterial", dependencies: [
            .target(name: "Droid")
        ]),
        .target(name: "Droid", dependencies: [
            .product(name: "JNIKit", package: "jni-kit"),
            .target(name: "Manifest"),
            .product(name: "AndroidLooper", package: "AndroidLooper", condition: .when(platforms: [.android]))
        ]),
        .target(name: "Manifest"),
        .testTarget(name: "DroidTests", dependencies: ["Droid"]),
    ]
)
