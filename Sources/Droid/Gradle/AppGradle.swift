//
//  AppGradle.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

public class AppGradle {
    public class ProjectAppGradle: AppGradle {}
    public class ModuleAppGradle: AppGradle {}
    
    required init () {}
    
    /// Merges two gradle files
    func merge(with gradle: AppGradle) {
        for variable in gradle.variables {
            variables.insert(variable)
        }
        for `import` in gradle.imports {
            imports.insert(`import`)
        }
        for apply in gradle.applies {
            if !applies.contains(apply) {
                applies.append(apply)
            }
        }
        if let newPlugins = gradle.plugins {
            if let plugins = plugins {
                plugins.merge(with: newPlugins)
            } else {
                plugins = newPlugins
            }
        }
        if let newBuildScript = gradle.buildScript {
            if let buildScript = buildScript {
                buildScript.merge(with: newBuildScript)
            } else {
                buildScript = newBuildScript
            }
        }
        if let newAllProjects = gradle.allProjects {
            if let allProjects = allProjects {
                allProjects.merge(with: newAllProjects)
            } else {
                allProjects = newAllProjects
            }
        }
        if let newAndroid = gradle.android {
            if let android = android {
                android.merge(with: newAndroid)
            } else {
                android = newAndroid
            }
        }
        for dependency in gradle.dependencies {
            dependencies.remove(dependency)
            dependencies.insert(dependency)
        }
        for repository in gradle.repositories {
            repositories.insert(repository)
        }
        for c in gradle.custom {
            custom.insert(c)
        }
    }
    
    // MARK: Variable
    
    var variables: Set<Variable> = []
    
    public func variable(_ key: String, _ value: String) -> Self {
        let variable = Variable(key, value)
        variables.remove(variable)
        variables.insert(variable)
        return self
    }
    
    public static func variable(_ key: String, _ value: String) -> Self {
        Self().variable(key, value)
    }
    
    public func variable(_ key: String, _ value: Int) -> Self {
        let variable = Variable(key, value)
        variables.remove(variable)
        variables.insert(variable)
        return self
    }
    
    public static func variable(_ key: String, _ value: Int) -> Self {
        Self().variable(key, value)
    }
    
    // MARK: Imports
    
    var imports: Set<String> = []
    
    public func `import`(_ name: String) -> Self {
        imports.remove(name)
        imports.insert(name)
        return self
    }
    
    public static func `import`(_ name: String) -> Self {
        Self().import(name)
    }
    
    // MARK: Applies
    
    var applies: [String] = []
    
    public func applyPlugin(_ value: String) -> Self {
        let value = "apply plugin: '\(value)'"
        if !applies.contains(value) {
            applies.append(value)
        }
        return self
    }
    
    public static func applyPlugin(_ value: String) -> Self {
        Self().applyPlugin(value)
    }
    
    // MARK: Build Script
    
    var buildScript: BuildScript?
    
    public func buildScript(_ handler: () -> BuildScript) -> Self {
        buildScript = handler()
        return self
    }
    
    public static func buildScript(_ handler: () -> BuildScript) -> Self {
        Self().buildScript(handler)
    }
    
    // MARK: All Projects
    
    var allProjects: AllProjects?
    
    public func allProjects(_ handler: () -> AllProjects) -> Self {
        allProjects = handler()
        return self
    }
    
    public static func allProjects(_ handler: () -> AllProjects) -> Self {
        Self().allProjects(handler)
    }
    
    // MARK: Plugins
    
    var plugins: Plugins?
    
    public func plugins(_ handler: () -> Plugins) -> Self {
        plugins = handler()
        return self
    }
    
    public static func plugins(_ handler: () -> Plugins) -> Self {
        Self().plugins(handler)
    }
    
    // MARK: Android
    
    var android: Android?
    
    public func android(_ handler: () -> Android) -> Self {
        android = handler()
        return self
    }
    
    public static func android(_ handler: () -> Android) -> Self {
        Self().android(handler)
    }
    
    // MARK: Dependencies
    
    var dependencies: Set<Dependency> = []
    
    public func dependency(_ dependency: Dependency) -> Self {
        dependencies.remove(dependency)
        dependencies.insert(dependency)
        return self
    }
    
    public static func dependency(_ dependency: Dependency) -> Self {
        Self().dependency(dependency)
    }
    
    // MARK: Repositories
    
    var repositories: Set<String> = []
    
    public func repository(_ repository: Repository) -> Self {
        repositories.insert(repository.name)
        return self
    }
    
    public static func repository(_ repository: Repository) -> Self {
        Self().repository(repository)
    }
    
    // MARK: Custom
    
    var custom: Set<String> = []
    
    public func custom(_ value: String) -> Self {
        custom.insert(value)
        return self
    }
    
    public static func custom(_ value: String) -> Self {
        Self().custom(value)
    }
    
    // MARK: Render
    
    public func render() -> String {
        let indentation: Indentation = .init(0)
        var lines: [String] = ["// managed by SwifDroid"]
        
        if imports.count > 0 {
            for `import` in imports {
                lines.append("import \(`import`)")
            }
            lines.append("")
        }
        
        if variables.count > 0 {
            for variable in variables {
                lines.append(indentation.tab().string + "ext.\(variable.key) = \(variable.value)")
                lines.append("")
            }
        }
        
        if applies.count > 0 {
            for value in applies {
                lines.append(value)
            }
            lines.append("")
        }
        
        if let buildScript = buildScript {
            lines.append(buildScript.render())
            lines.append("")
        }
        
        if let allProjects = allProjects {
            lines.append(allProjects.render())
            lines.append("")
        }
        
        if let android = android {
            lines.append(android.render(indentation))
            lines.append("")
        }
        
        if dependencies.count > 0 {
            lines.append("dependencies {")
            for dependency in dependencies {
                lines.append(indentation.tab().string + dependency.description)
            }
            lines.append("}")
        }
        
        if repositories.count > 0 {
            lines.append("repositories {")
            for repository in repositories {
                lines.append(indentation.tab().string + repository)
            }
            lines.append("}")
        }
        
        for (i, c) in custom.enumerated() {
            lines.append(c)
            if i > 0, i < custom.count - 1 {
                lines.append("")
            }
        }
        
        return lines.joined(separator: "\n")
    }
}

extension AppGradle {
    public struct Variable: Equatable, Hashable {
        let key, value: String
        
        public init (_ key: String, _ value: String) {
            self.key = key
            self.value = "'\(value)'"
        }
        
        public init (_ key: String, _ value: Int) {
            self.key = key
            self.value = "\(value)"
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }
    }
    
    public struct Repository: ExpressibleByStringLiteral {
        let name: String
        
        public init(stringLiteral value: String) {
            self.name = value
        }
        
        public static var gradlePluginPortal: Self { "gradlePluginPortal()" }
        public static var jcenter: Self { "jcenter()" }
        public static var mavenCentral: Self { "mavenCentral()" }
        public static var mavenLocal: Self { "mavenLocal()" }
        public static var google: Self { "google()" }
    }
    
    public struct Dependency: CustomStringConvertible, Hashable {
        let type, key, value: String
        
        init(_ type: String, key: String, value: String) {
            self.type = type
            self.key = key
            self.value = value
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(type)
            hasher.combine(key)
        }
        
        public static func classpath(_ org: String, _ repo: String, _ version: String) -> Self {
            Self.init("classpath", key: "\(org):\(repo):", value: "\(version)")
        }
        
        public static func implementation(fileTreeDir dir: String, include: [String]) -> Self {
            Self.init("implementation", key: "fileTree(dir: '\(dir)', ", value: "include: [\(include.map { "'\($0)'" }.joined(separator: ", ") )])")
        }
        
        public static func implementation(_ org: String, _ repo: String, _ version: String) -> Self {
            Self.init("implementation", key: "\(org):\(repo):", value: "\(version)")
        }
        
        public static func testImplementation(_ org: String, _ repo: String, _ version: String) -> Self {
            Self.init("testImplementation", key: "\(org):\(repo):", value: "\(version)")
        }
        
        public static func androidTestImplementation(_ org: String, _ repo: String, _ version: String) -> Self {
            Self.init("androidTestImplementation", key: "\(org):\(repo):", value: "\(version)")
        }
        
        public var description: String { "\(type) \"\(key)\(value)\"" }
    }
}

extension AppGradle {
    public final class BuildScript {
        required init () {}
        
        func merge(with bs: BuildScript) {
            for repository in bs.repositories {
                repositories.insert(repository)
            }
            for dependency in bs.dependencies {
                dependencies.insert(dependency)
            }
        }
        
        var repositories: Set<String> = []
        
        public func repository(_ repository: Repository) -> Self {
            repositories.remove(repository.name)
            repositories.insert(repository.name)
            return self
        }
        
        public static func repository(_ repository: Repository) -> Self {
            Self().repository(repository)
        }
        
        var dependencies: Set<String> = []
        
        public func dependency(_ dependency: Dependency) -> Self {
            dependencies.remove(dependency.description)
            dependencies.insert(dependency.description)
            return self
        }
        
        public static func dependency(_ dependency: Dependency) -> Self {
            Self().dependency(dependency)
        }
        
        func render(_ indentation: Indentation = Indentation(0)) -> String {
            var lines: [String] = [indentation + "buildscript {"]
            
            if repositories.count > 0 {
                lines.append(indentation.tab().string + "repositories {")
                for repository in repositories {
                    lines.append(indentation.tab().tab() + repository)
                }
                lines.append(indentation.tab().string + "}")
            }
            
            if dependencies.count > 0 {
                lines.append(indentation.tab().string + "dependencies {")
                for dependency in dependencies {
                    lines.append(indentation.tab().tab() + dependency)
                }
                lines.append(indentation.tab().string + "}")
            }
            
            lines.append(indentation + "}")
            
            return lines.joined(separator: "\n")
        }
    }
}

extension AppGradle {
    public final class AllProjects {
        required init () {}
        
        func merge(with ap: AllProjects) {
            for repository in ap.repositories {
                repositories.insert(repository)
            }
        }
        
        var repositories: Set<String> = []
        
        public func repository(_ repository: Repository) -> Self {
            repositories.remove(repository.name)
            repositories.insert(repository.name)
            return self
        }
        
        public static func repository(_ repository: Repository) -> Self {
            Self().repository(repository)
        }
        
        func render(_ indentation: Indentation = Indentation(0)) -> String {
            var lines: [String] = [indentation + "buildscript {"]
            
            if repositories.count > 0 {
                lines.append(indentation.tab().string + "repositories {")
                for repository in repositories {
                    lines.append(indentation.tab().tab() + repository)
                }
                lines.append(indentation.tab().string + "}")
            }
            
            lines.append(indentation + "}")
            
            return lines.joined(separator: "\n")
        }
    }
}

extension AppGradle {
    public final class Plugins {
        struct Plugin: Hashable, Equatable {
            let id: String
            let version: String
            let apply: Bool
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
            
            static func == (lhs: Self, rhs: Self) -> Bool {
                lhs.id == rhs.id
            }
        }
        
        public init () {}
        
        var plugins: Set<Plugin> = []
        
        func plugin(id: String, version: String, apply: Bool) -> Self {
            plugins.insert(.init(id: id, version: version, apply: apply))
            return self
        }
        
        static func plugin(id: String, version: String, apply: Bool) -> Self {
            Self().plugin(id: id, version: version, apply: apply)
        }
        
        fileprivate func merge(with a: Plugins) {
            for plugin in a.plugins {
                plugins.insert(plugin)
            }
        }
    }
    
    public final class Android {
        public init () {}
        
        static let applicationIdPlaceholder = "__APPLICATION_ID__"
        static let ndkVersionPlaceholder = "__NDK_VERSION__"
        static let compileSdkVersionPlaceholder = "__COMPILE_SDK_VERSION__"
        
        func merge(with a: Android) {
            if let v = a.ndkVersion {
                ndkVersion = v
            }
            if let v = a.compileSdkVersion {
                compileSdkVersion = v
            }
            if let newDefaultConfig = a.defaultConfig {
                if let defaultConfig = defaultConfig {
                    defaultConfig.merge(with: newDefaultConfig)
                } else {
                    defaultConfig = newDefaultConfig
                }
            }
            for v in a.signingConfigs {
                signingConfigs.insert(v)
            }
            for v in a.buildTypes {
                buildTypes.insert(v)
            }
            if let newCompileOptions = compileOptions {
                if let compileOptions = compileOptions {
                    compileOptions.merge(with: newCompileOptions)
                } else {
                    compileOptions = newCompileOptions
                }
            }
            if let newKotlinOptions = kotlinOptions {
                if let kotlinOptions = kotlinOptions {
                    kotlinOptions.merge(with: newKotlinOptions)
                } else {
                    kotlinOptions = newKotlinOptions
                }
            }
            if let newBuildFeatures = buildFeatures {
                if let buildFeatures = buildFeatures {
                    buildFeatures.merge(with: newBuildFeatures)
                } else {
                    buildFeatures = newBuildFeatures
                }
            }
            for v in a.splits {
                splits.insert(v)
            }
        }
        
        var ndkVersion: String?
        
        public func ndkVersion(_ value: String) -> Self {
            if value.count > 0 {
                ndkVersion = value
            }
            return self
        }
        
        public static func ndkVersion(_ value: String) -> Self {
            Self().ndkVersion(value)
        }
        
        var compileSdkVersion: String?
        
        public func compileSdkVersion(_ value: Int) -> Self {
            if value > 0 {
                compileSdkVersion = "\(value)"
            }
            return self
        }
        
        public static func compileSdkVersion(_ value: Int) -> Self {
            Self().compileSdkVersion(value)
        }
        
        // MARK: Compile Options
        
        var compileOptions: CompileOptions?
        
        public func compileOptions(_ handler: () -> CompileOptions) -> Self {
            compileOptions = handler()
            return self
        }
        
        public static func compileOptions(_ handler: () -> CompileOptions) -> Self {
            Self().compileOptions(handler)
        }
        
        public final class CompileOptions {
            public init () {}
            
            var sourceCompatibility: String?
            
            public func sourceCompatibility(_ value: String) -> Self {
                if value.count > 0 {
                    sourceCompatibility = value
                }
                return self
            }
            
            public static func sourceCompatibility(_ value: String) -> Self {
                Self().sourceCompatibility(value)
            }
            
            var targetCompatibility: String?
            
            public func targetCompatibility(_ value: String) -> Self {
                if value.count > 0 {
                    targetCompatibility = value
                }
                return self
            }
            
            public static func targetCompatibility(_ value: String) -> Self {
                Self().targetCompatibility(value)
            }
            
            fileprivate func merge(with a: CompileOptions) {
                sourceCompatibility = a.sourceCompatibility
                targetCompatibility = a.targetCompatibility
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "compileOptions {"]
                
                if let sourceCompatibility = sourceCompatibility {
                    lines.append(indentation.tab().string + "sourceCompatibility \"\(sourceCompatibility)\"")
                }
                if let targetCompatibility = targetCompatibility {
                    lines.append(indentation.tab().string + "targetCompatibility \"\(targetCompatibility)\"")
                }
                
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
        }
        
        // MARK: Kotlin Options
        
        var kotlinOptions: KotlinOptions?
        
        public func kotlinOptions(_ handler: () -> KotlinOptions) -> Self {
            kotlinOptions = handler()
            return self
        }
        
        public static func kotlinOptions(_ handler: () -> KotlinOptions) -> Self {
            Self().kotlinOptions(handler)
        }
        
        public final class KotlinOptions {
            public init () {}
            
            var jvmTarget: String?
            
            public func jvmTarget(_ value: String) -> Self {
                if value.count > 0 {
                    jvmTarget = value
                }
                return self
            }
            
            public static func jvmTarget(_ value: String) -> Self {
                Self().jvmTarget(value)
            }
            
            fileprivate func merge(with a: KotlinOptions) {
                jvmTarget = a.jvmTarget
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "kotlinOptions {"]
                
                if let jvmTarget = jvmTarget {
                    lines.append(indentation.tab().string + "jvmTarget \"\(jvmTarget)\"")
                }
                
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
        }
        
        // MARK: Build Features
        
        var buildFeatures: BuildFeatures?
        
        public func buildFeatures(_ handler: () -> BuildFeatures) -> Self {
            buildFeatures = handler()
            return self
        }
        
        public static func buildFeatures(_ handler: () -> BuildFeatures) -> Self {
            Self().buildFeatures(handler)
        }
        
        public final class BuildFeatures {
            public init () {}
            
            var viewBinding: Bool?
            
            public func viewBinding(_ value: Bool) -> Self {
                viewBinding = value
                return self
            }
            
            public static func viewBinding(_ value: Bool) -> Self {
                Self().viewBinding(value)
            }
            
            fileprivate func merge(with a: BuildFeatures) {
                viewBinding = a.viewBinding
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "buildFeatures {"]
                
                if let viewBinding = viewBinding {
                    lines.append(indentation.tab().string + "viewBinding \"\(viewBinding ? "true" : "false")\"")
                }
                
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
        }
        
        public final class DefaultConfig {
            required init () {}
            
            static let applicationIdPlaceholder = "__APPLICATION_ID__"
            static let minSdkVersionPlaceholder = "__MIN_SDK_VERSION__"
            static let targetSdkVersionPlaceholder = "__TARGET_SDK_VERSION__"
            static let versionCodePlaceholder = "__VERSION_CODE__"
            static let versionNamePlaceholder = "__VERSION_NAME__"
            
            func merge(with dc: DefaultConfig) {
                if let v = dc.applicationId {
                    applicationId = v
                }
                if let v = dc.minSdkVersion {
                    minSdkVersion = v
                }
                if let v = dc.targetSdkVersion {
                    targetSdkVersion = v
                }
                if let v = dc.versionCode {
                    versionCode = v
                }
                if let v = dc.versionName {
                    versionName = v
                }
                for v in dc.custom {
                    custom.insert(v)
                }
            }
            
            var applicationId: String?
            
            public func applicationId(_ value: String) -> Self {
                if value.count > 0 {
                    applicationId = value
                }
                return self
            }
            
            public static func applicationId(_ value: String) -> Self {
                Self().applicationId(value)
            }
            
            var minSdkVersion: String?
            
            public func minSdkVersion(_ value: Int) -> Self {
                if value > 0 {
                    minSdkVersion = "\(value)"
                }
                return self
            }
            
            public static func minSdkVersion(_ value: Int) -> Self {
                Self().minSdkVersion(value)
            }
            
            var targetSdkVersion: String?
            
            public func targetSdkVersion(_ value: Int) -> Self {
                if value > 0 {
                    targetSdkVersion = "\(value)"
                }
                return self
            }
            
            public static func targetSdkVersion(_ value: Int) -> Self {
                Self().targetSdkVersion(value)
            }
            
            var versionCode: String?
            
            public func versionCode(_ value: Int) -> Self {
                if value > 0 {
                    versionCode = "\(value)"
                }
                return self
            }
            
            public static func versionCode(_ value: Int) -> Self {
                Self().versionCode(value)
            }
            
            var versionName: String?
            
            public func versionName(_ value: String) -> Self {
                if value.count > 0 {
                    versionName = value
                }
                return self
            }
            
            public static func versionName(_ value: String) -> Self {
                Self().versionName(value)
            }
            
            public func testInstrumentationRunner(_ value: String) -> Self {
                let value = "testInstrumentationRunner \"\(value)\""
                custom.remove(value)
                custom.insert(value)
                return self
            }
            
            public static func testInstrumentationRunner(_ value: String) -> Self {
                Self().testInstrumentationRunner(value)
            }
            
            var custom: Set<String> = []
            
            public func custom(_ value: String) -> Self {
                custom.remove(value)
                custom.insert(value)
                return self
            }
            
            public static func custom(_ value: String) -> Self {
                Self().custom(value)
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = []
                
                lines.append(indentation + "defaultConfig {")
                
                lines.append(indentation.tab().string + "applicationId \"\(applicationId ?? Self.applicationIdPlaceholder)\"")
                lines.append(indentation.tab().string + "minSdkVersion \(minSdkVersion ?? Self.minSdkVersionPlaceholder)")
                lines.append(indentation.tab().string + "targetSdkVersion \(targetSdkVersion ?? Self.targetSdkVersionPlaceholder)")
                lines.append(indentation.tab().string + "versionCode \(versionCode ?? Self.versionCodePlaceholder)")
                lines.append(indentation.tab().string + "versionName \"\(versionName ?? Self.versionNamePlaceholder)\"")
                
                for (i, c) in custom.enumerated() {
                    lines.append(indentation.tab().string + c)
                    if i > 0, i < custom.count - 1 {
                        lines.append("")
                    }
                }
                
                lines.append(indentation + "}")
                
                return lines.joined(separator: "\n")
            }
        }
        
        var defaultConfig: DefaultConfig?
        
        public func defaultConfig(_ handler: () -> DefaultConfig) -> Self {
            defaultConfig = handler()
            return self
        }
        
        public static func defaultConfig(_ handler: () -> DefaultConfig) -> Self {
            Self().defaultConfig(handler)
        }
        
        public struct SigningConfig: Equatable, Hashable {
            let name, storeFile, storePassword, keyAlias, keyPassword: String
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "\(name) {"]
                lines.append(indentation.tab().string + "storeFile file(\"\(storeFile)\")")
                lines.append(indentation.tab().string + "storePassword \"\(storePassword)\"")
                lines.append(indentation.tab().string + "keyAlias \"\(keyAlias)\"")
                lines.append(indentation.tab().string + "keyPassword \"\(keyPassword)\"")
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(name)
            }
        }
        
        var signingConfigs: Set<SigningConfig> = []
        
        func signingConfigPlaceholder() -> Self {
            let config = SigningConfig(
                name: "mySigning",
                storeFile: "__STORE_FILE__",
                storePassword: "__STORE_PASSWORD__",
                keyAlias: "__KEY_ALIAS__",
                keyPassword: "__KEY_PASSWORD__"
            )
            signingConfigs.remove(config)
            signingConfigs.insert(config)
            return self
        }
        
        public func signingConfig(name: String, storeFile: String, storePassword: String, keyAlias: String, keyPassword: String) -> Self {
            let config = SigningConfig(name: name, storeFile: storeFile, storePassword: storePassword, keyAlias: keyAlias, keyPassword: keyPassword)
            signingConfigs.remove(config)
            signingConfigs.insert(config)
            return self
        }
        
        public static func signingConfig(name: String, storeFile: String, storePassword: String, keyAlias: String, keyPassword: String) -> Self {
            Self().signingConfig(name: name, storeFile: storeFile, storePassword: storePassword, keyAlias: keyAlias, keyPassword: keyPassword)
        }
        
        public struct BuildType: Hashable {
            let name: String
            let minifyEnabled: Bool
            let proguardFiles: String = "getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'"
            let signingConfig: String?
            
            public static func release(minifyEnabled: Bool, signingConfig: String) -> Self {
                .init(name: "release", minifyEnabled: minifyEnabled, signingConfig: "signingConfigs.\(signingConfig)")
            }
            
            public static func debug(minifyEnabled: Bool, signingConfig: String? = nil) -> Self {
                .init(name: "debug", minifyEnabled: minifyEnabled, signingConfig: nil)
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "\(name) {"]
                lines.append(indentation.tab().string + "minifyEnabled \(minifyEnabled ? "true" : "false")")
                lines.append(indentation.tab().string + "proguardFiles \(proguardFiles)")
                if let signingConfig = signingConfig {
                    lines.append(indentation.tab().string + "signingConfig \(signingConfig)")
                }
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(name)
            }
        }
        
        var buildTypes: Set<BuildType> = []
        
        public func buildType(_ value: BuildType) -> Self {
            buildTypes.remove(value)
            buildTypes.insert(value)
            return self
        }
        
        public static func buildType(_ value: BuildType) -> Self {
            Self().buildType(value)
        }
        
        public struct Split: Hashable {
            let name: String
            let enable: Bool
            let reset: Bool
            let include: [String]
            let exclude: [String]
            let custom: [String]
            
            /// Configures multiple APKs based on ABI.
            public static func abi(enable: Bool = true, reset: Bool, include: [String] = [], exclude: [String] = [], universalApk: Bool = false) -> Self {
                .init(name: "abi", enable: enable, reset: reset, include: include, exclude: exclude, custom: ["universalApk \(universalApk ? "true" : "false")"])
            }
            
            /// Configures multiple APKs based on screen density.
            public static func density(enable: Bool = true, reset: Bool, include: [String] = [], exclude: [String] = [], compatibleScreens: [String]) -> Self {
                .init(name: "density", enable: enable, reset: false, include: include, exclude: exclude, custom: ["compatibleScreens \(compatibleScreens.map { "'\($0)'" }.joined(separator: ", "))"])
            }
            
            func render(_ indentation: Indentation) -> String {
                var lines: [String] = [indentation + "\(name) {"]
                lines.append(indentation.tab().string + "enable \(enable ? "true" : "false")")
                if reset {
                    lines.append(indentation.tab().string + "reset()")
                }
                if include.count > 0 {
                    lines.append(indentation.tab().string + "include \(include.map { "'\($0)'" }.joined(separator: ", "))")
                }
                if exclude.count > 0 {
                    lines.append(indentation.tab().string + "exclude \(exclude.map { "'\($0)'" }.joined(separator: ", "))")
                }
                for (i, c) in custom.enumerated() {
                    lines.append(indentation.tab().string + c)
                    if i > 0, i < custom.count - 1 {
                        lines.append("")
                    }
                }
                lines.append(indentation + "}")
                return lines.joined(separator: "\n")
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(name)
            }
        }
        
        var splits: Set<Split> = []
        
        public func split(_ value: Split) -> Self {
            splits.remove(value)
            splits.insert(value)
            return self
        }
        
        public static func split(_ value: Split) -> Self {
            Self().split(value)
        }
        
        func render(_ indentation: Indentation) -> String {
            var lines: [String] = [indentation + "android {"]
            
            lines.append(indentation.tab().string + "namespace \"\(Self.applicationIdPlaceholder)\"")
            lines.append(indentation.tab().string + "ndkVersion \"\(ndkVersion ?? Self.ndkVersionPlaceholder)\"")
            lines.append(indentation.tab().string + "compileSdkVersion \(compileSdkVersion ?? Self.compileSdkVersionPlaceholder)")
            
            if let defaultConfig = defaultConfig {
                lines.append(defaultConfig.render(indentation.tab()))
            }
            
            if signingConfigs.count > 0 {
                lines.append(indentation.tab().string + "signingConfigs {")
                for signingConfig in signingConfigs {
                    lines.append(signingConfig.render(indentation.tab().tab()))
                }
                lines.append(indentation.tab().string + "}")
            }
            
            if buildTypes.count > 0 {
                lines.append(indentation.tab().string + "buildTypes {")
                for buildType in buildTypes {
                    lines.append(buildType.render(indentation.tab().tab()))
                }
                lines.append(indentation.tab().string + "}")
            }
            
            if let compileOptions = compileOptions {
                lines.append(compileOptions.render(indentation.tab()))
            }
            
            if let kotlinOptions = kotlinOptions {
                lines.append(kotlinOptions.render(indentation.tab()))
            }
            
            if let buildFeatures = buildFeatures {
                lines.append(buildFeatures.render(indentation.tab()))
            }
            
            if splits.count > 0 {
                lines.append(indentation.tab().string + "splits {")
                for split in splits {
                    lines.append(split.render(indentation.tab().tab()))
                }
                lines.append(indentation.tab().string + "}")
            }
            
            lines.append(indentation + "}")
            return lines.joined(separator: "\n")
        }
    }
}
