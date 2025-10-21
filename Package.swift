// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "droid",
    products: [
        .library(name: "DroidMaterial", targets: ["DroidMaterial"]),
        .library(name: "Droid", targets: ["Droid"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwifDroid/jni-kit.git", from: "2.1.0"),
        .package(url: "https://github.com/swifdroid/AndroidLogging.git", from: "0.1.0")
    ],
    targets: [
        .target(name: "DroidMaterial", dependencies: [
            .target(name: "Droid")
        ]),
        .target(name: "Droid", dependencies: [
            .product(name: "JNIKit", package: "jni-kit"),
            .target(name: "Manifest"),
            .target(name: "CAndroidLooper", condition: .when(platforms: [.android])),
            .product(name: "AndroidLogging", package: "AndroidLogging", condition: .when(platforms: [.android]))
        ]),
        .target(name: "Manifest"),
        .target(
            name: "CAndroidLooper",
            linkerSettings: [.linkedLibrary("android")]
        ),
        .testTarget(name: "DroidTests", dependencies: ["Droid"]),
    ]
)
