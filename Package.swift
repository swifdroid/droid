// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "droid",
    products: [
        .library(name: "DroidX", targets: ["DroidX"]),
        .library(name: "DroidMaterial", targets: ["DroidMaterial"]),
        .library(name: "Droid", targets: ["Droid"]),
        .library(name: "DroidFoundation", targets: ["DroidFoundation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwifDroid/manifest.git", from: "0.0.1"),
        .package(url: "https://github.com/SwifDroid/jni-kit.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "DroidX", dependencies: [
            .target(name: "Droid")
        ]),
        .target(name: "DroidMaterial", dependencies: [
            .target(name: "Droid")
        ]),
        .target(name: "Droid", dependencies: [
            .target(name: "DroidFoundation")
        ]),
        .target(name: "DroidFoundation", dependencies: [
            .product(name: "JNIKit", package: "jni-kit"),
            .product(name: "Manifest", package: "manifest")
        ]),
        .testTarget(name: "DroidTests", dependencies: ["Droid"]),
    ]
)
