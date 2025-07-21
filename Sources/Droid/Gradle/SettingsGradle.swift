//
//  SettingsGradle.swift
//  
//
//  Created by Mihael Isaev on 05.06.2023.
//

public class SettingsGradle {
    required init () {}
    
    /// Merges two gradle files
    func merge(with a: SettingsGradle) {
        if let newPluginManagement = a.pluginManagement {
            if self.pluginManagement != nil {
                self.pluginManagement?.merge(with: newPluginManagement)
            } else {
                self.pluginManagement = newPluginManagement
            }
        }
        if let newDependencyResolutionManagement = a.dependencyResolutionManagement {
            if self.dependencyResolutionManagement != nil {
                self.dependencyResolutionManagement?.merge(with: newDependencyResolutionManagement)
            } else {
                self.dependencyResolutionManagement = newDependencyResolutionManagement
            }
        }
        for c in a.custom {
            custom.insert(c)
        }
    }
    
    // MARK: PluginManagement
    
    var pluginManagement: PluginManagement?
    
    public func pluginManagement(_ handler: () -> PluginManagement) -> Self {
        pluginManagement = handler()
        return self
    }
    
    public static func pluginManagement(_ handler: () -> PluginManagement) -> Self {
        Self().pluginManagement(handler)
    }
    
    // MARK: DependencyResolutionManagement
    
    var dependencyResolutionManagement: DependencyResolutionManagement?
    
    public func dependencyResolutionManagement(_ handler: () -> DependencyResolutionManagement) -> Self {
        dependencyResolutionManagement = handler()
        return self
    }
    
    public static func dependencyResolutionManagement(_ handler: () -> DependencyResolutionManagement) -> Self {
        Self().dependencyResolutionManagement(handler)
    }
    
    // MARK: Includes
    
    var includes: Set<String> = []
    
    public func includes(_ value: String) -> Self {
        includes.insert(value)
        return self
    }
    
    public static func includes(_ value: String) -> Self {
        Self().includes(value)
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
        
        if let pluginManagement = pluginManagement {
            lines.append(pluginManagement.render(indentation.tab()))
        }
        
        if let dependencyResolutionManagement = dependencyResolutionManagement {
            lines.append(dependencyResolutionManagement.render(indentation.tab()))
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

extension SettingsGradle {
    public final class PluginManagement {
        public init () {}
        
        func merge(with a: PluginManagement) {
            for repository in a.repositories {
                repositories.insert(repository)
            }
        }
        
        // MARK: Repositories
        
        var repositories: Set<String> = []
        
        public func repository(_ repository: GradleRepository) -> Self {
            repositories.insert(repository.name)
            return self
        }
        
        public static func repository(_ repository: GradleRepository) -> Self {
            Self().repository(repository)
        }
        
        func render(_ indentation: Indentation) -> String {
            var lines: [String] = [indentation + "pluginManagement {"]
            
            if repositories.count > 0 {
                lines.append(indentation.tab().string + "repositories {")
                for repository in repositories {
                    lines.append(indentation.tab().tab().string + repository)
                }
                lines.append(indentation.tab().string + "}")
            }
            
            lines.append(indentation + "}")
            return lines.joined(separator: "\n")
        }
    }
}

extension SettingsGradle {
    public final class DependencyResolutionManagement {
        public init () {}
        
        func merge(with a: DependencyResolutionManagement) {
            for repository in a.repositories {
                repositories.insert(repository)
            }
            if let mode = a.repositoriesMode {
                repositoriesMode = mode
            }
        }
        
        // MARK: Repositories Mode
        
        public enum RepositoriesMode: String {
            case FAIL_ON_PROJECT_REPOS, PREFER_PROJECT, PREFER_SETTINGS
        }
        
        var repositoriesMode: RepositoriesMode?
        
        public func repositoriesMode(_ mode: RepositoriesMode) -> Self {
            repositoriesMode = mode
            return self
        }
        
        public static func repositoriesMode(_ mode: RepositoriesMode) -> Self {
            Self().repositoriesMode(mode)
        }
        
        // MARK: Repositories
        
        var repositories: Set<String> = []
        
        public func repository(_ repository: GradleRepository) -> Self {
            repositories.insert(repository.name)
            return self
        }
        
        public static func repository(_ repository: GradleRepository) -> Self {
            Self().repository(repository)
        }
        
        func render(_ indentation: Indentation) -> String {
            var lines: [String] = [indentation + "dependencyResolutionManagement {"]
            
            if let mode = repositoriesMode {
                lines.append(indentation.tab().string + "repositoriesMode.set(RepositoriesMode.\(mode.rawValue)")
            }
            
            if repositories.count > 0 {
                lines.append(indentation.tab().string + "repositories {")
                for repository in repositories {
                    lines.append(indentation.tab().tab().string + repository)
                }
                lines.append(indentation.tab().string + "}")
            }
            
            lines.append(indentation + "}")
            return lines.joined(separator: "\n")
        }
    }
}
