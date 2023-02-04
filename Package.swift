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
            "CAndroidLog",
            .target(name: "CDroidJNI"),//, condition: .when(platforms: [.android])),
            .product(name: "Manifest", package: "manifest")
        ]),
        .testTarget(name: "DroidTests", dependencies: ["Droid"]),
        .target(name: "CDroidJNI"),
        
//        .target(name: "CDroidJNI", publicHeadersPath: "/Users/imike/.droidy/android-ndk-r21e/sysroot/usr/include/")
        .systemLibrary(name: "CAndroidLog"),
    ]
)
