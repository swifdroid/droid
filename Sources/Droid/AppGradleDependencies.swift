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
