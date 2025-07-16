//
//  Manifest.swift
//  Manifest
//
//  Created by Mihael Isaev on 28.07.2021.
//

import FoundationEssentials

public final class Manifest {
    var targetSandboxVersion: UInt?
    var installLocation: InstallLocation?
    
    public init () {}
    
    public func merge(with manifest: Manifest) {
        if let v = manifest.targetSandboxVersion {
            self.targetSandboxVersion = v
        }
        if let v = manifest.installLocation {
            self.installLocation = v
        }
    }
    
    /// The target sandbox for this app to use.
    ///
    /// The higher the sandbox version number, the higher the level of security.
    /// Its default value is `1``, you can also set it to `2`.
    //  Setting this attribute to `2` switches the app to a different SELinux sandbox.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#targetSandboxVersion)
    @discardableResult
    public func targetSandboxVersion(_ value: UInt) -> Self {
        targetSandboxVersion = value
        return self
    }
    
    public enum InstallLocation: String, Codable {
        case internalOnly
        case auto
        case preferExternal
    }
    
    /// The default install location for the app.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#install)
    @discardableResult
    public func installLocation(_ value: InstallLocation) -> Self {
        installLocation = value
        return self
    }
    
    var application: Application?
    
    @discardableResult
    public func application(_ value: Application) -> Self {
        application = value
        return self
    }
    
    var compatibleScreens: [Screen] = []
    
    /// Specifies each screen configuration with which the application is compatible.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
    @discardableResult
    public func compatibleScreens(_ screens: Screen...) -> Self {
        compatibleScreens(screens)
    }
    
    /// Specifies each screen configuration with which the application is compatible.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/compatible-screens-element)
    @discardableResult
    public func compatibleScreens(_ screens: [Screen]) -> Self {
        compatibleScreens = screens
        return self
    }
    
    var instrumentation: Instrumentation?
    
    /// Declares an `Instrumentation` class that enables you to monitor an application's interaction with the system.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element)
    @discardableResult
    public func instrumentation(_ value: Instrumentation) -> Self {
        instrumentation = value
        return self
    }
    
    var permissions: [Permission] = []
    
    /// Declares a security permission that can be used to limit access to specific components or features of this or other applications.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element)
    @discardableResult
    public func permission(_ value: Permission) -> Self {
        permissions.append(value)
        return self
    }
    
    var permissionGroups: [PermissionGroup] = []
    
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func ___(_ value: ___) -> Self {
//
//        return self
//    }
}
