//
//  AppGradleDependencies.swift
//  
//
//  Created by Mihael Isaev on 20.07.2025.
//

public final class AppGradleDependencies {
    init () {}

    var dependencies: Set<String> = []

    public func append(_ dependencies: [String]) {
        for dep in dependencies {
            self.dependencies.insert(dep)
        }
    }

    public func implementation(_ `package`: String) -> Self {
        append([Dependency.implementation(`package`).value])
        return self
    }

    public static func implementation(_ `package`: String) -> Self {
        let deps = Self()
        deps.append([Dependency.implementation(`package`).value])
        return deps
    }

    public func debugImplementation(_ `package`: String) -> Self {
        append([Dependency.debugImplementation(`package`).value])
        return self
    }

    public static func debugImplementation(_ `package`: String) -> Self {
        let deps = Self()
        deps.append([Dependency.debugImplementation(`package`).value])
        return deps
    }

    public func testImplementation(_ `package`: String) -> Self {
        append([Dependency.testImplementation(`package`).value])
        return self
    }

    public static func testImplementation(_ `package`: String) -> Self {
        let deps = Self()
        deps.append([Dependency.testImplementation(`package`).value])
        return deps
    }

    public func androidTestImplementation(_ `package`: String) -> Self {
        append([Dependency.androidTestImplementation(`package`).value])
        return self
    }

    public static func androidTestImplementation(_ `package`: String) -> Self {
        let deps = Self()
        deps.append([Dependency.androidTestImplementation(`package`).value])
        return deps
    }

    public struct Dependency: CustomStringConvertible, ExpressibleByStringLiteral {
        let value: String
        
        public init(stringLiteral value: String) {
            self.value = value
        }
        
        public var description: String { value }

        static func implementation(_ `package`: String) -> Dependency {
            return .init(stringLiteral: "implementation(\(`package`))")
        }

        static func debugImplementation(_ `package`: String) -> Dependency {
            return .init(stringLiteral: "debugImplementation(\(`package`))")
        }

        static func testImplementation(_ `package`: String) -> Dependency {
            return .init(stringLiteral: "testImplementation(\(`package`))")
        }

        static func androidTestImplementation(_ `package`: String) -> Dependency {
            return .init(stringLiteral: "androidTestImplementation(\(`package`))")
        }
    }

    func merge(with another: AppGradleDependencies) {
        for dep in another.dependencies {
            dependencies.insert(dep)
        }
    }
}

public struct AppGradleDependency: Sendable, ExpressibleByStringLiteral, CustomStringConvertible {
    let value: String

    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public var description: String { value }

    /// Add a custom dependency.
    public static func implementation(_ `package`: String) -> Self {
        .init(stringLiteral: #"implementation("\(`package`)")"#)
    }

    /// Add a custom debug dependency.
    public static func debugImplementation(_ `package`: String) -> Self {
        .init(stringLiteral: #"debugImplementation("\(`package`)")"#)
    }

    /// Add a custom release dependency.
    public static func releaseImplementation(_ `package`: String) -> Self {
        .init(stringLiteral: #"releaseImplementation("\(`package`)")"#)
    }

    /// Add a custom test dependency.
    public static func testImplementation(_ `package`: String) -> Self {
        .init(stringLiteral: #"testImplementation("\(`package`)")"#)
    }

    /// Add a custom android test dependency.
    public static func androidTestImplementation(_ `package`: String) -> Self {
        .init(stringLiteral: #"androidTestImplementation("\(`package`)")"#)
    }

    public static let appCompat: Self = #"implementation("androidx.appcompat:appcompat:1.7.1")"#
    public static let composeBOM: Self = #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    public static let flexbox: Self = #"implementation("com.google.android.flexbox:flexbox:3.0.0")"#
    public static let constraintlayout: Self = #"implementation("androidx.constraintlayout:constraintlayout:2.2.1")"#
    public static let constraintlayoutCore: Self = #"implementation("androidx.constraintlayout:constraintlayout-core:1.1.1")"#
    public static let coordinatorlayout: Self = #"implementation("androidx.coordinatorlayout:coordinatorlayout:1.3.0")"#
    public static let recyclerview: Self = #"implementation "androidx.recyclerview:recyclerview:1.3.2""#
    public static let material: Self = #"implementation("com.google.android.material:material:1.14.0-alpha06")"#
}