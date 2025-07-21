// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "droid",
    products: [
        .library(name: "DroidMaterial", targets: ["DroidMaterial"]),
        .library(name: "Droid", targets: ["Droid"]),
        .library(name: "DroidFoundation", targets: ["DroidFoundation"]),
    ],
    dependencies: [
        .package(path: "/Users/imike/Development/SwifDroid/manifest"),
        .package(path: "/Users/imike/Development/SwifDroid/jni-kit")
//        .package(url: "https://github.com/SwifDroid/manifest.git", from: "0.0.1"),
//        .package(url: "https://github.com/SwifDroid/jni-kit.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "DroidMaterial", dependencies: [
            .target(name: "Droid")
        ]),
        .target(name: "Droid", dependencies: [
            .product(name: "JNIKit", package: "jni-kit"),
            .product(name: "Manifest", package: "manifest")
        ]),
        .testTarget(name: "DroidTests", dependencies: ["Droid"]),
    ]
)
