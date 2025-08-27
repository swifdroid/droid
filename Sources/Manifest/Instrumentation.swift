//
//  Instrumentation.swift
//  Manifest
//
//  Created by Mihael Isaev on 29.07.2021.
//

/// Declares an Instrumentation class that enables you to monitor an application's interaction with the system.
///
/// The Instrumentation object is instantiated before any of the application's components.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element)
public class Instrumentation {
    var functionalTest: Bool?
    
    /// Whether or not the Instrumentation class should run as a functional test — "true" if it should, and "false" if not.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#ftest)
    @discardableResult
    public func functionalTest(_ value: Bool = true) -> Self {
        functionalTest = value
        return self
    }
    
    var handleProfiling: Bool?
    
    /// Whether or not the Instrumentation object will turn profiling on and off — "true" if it determines when profiling starts and stops,
    /// and "false" if profiling continues the entire time it is running.
    ///
    /// A value of "true" enables the object to target profiling at a specific set of operations.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#hprof)
    @discardableResult
    public func handleProfiling(_ value: Bool = true) -> Self {
        handleProfiling = value
        return self
    }
    
//    var icon="drawable resource"
//
//    /// An icon that represents the Instrumentation class. This attribute must be set as a reference to a drawable resource.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#icon)
//    @discardableResult
//    public func icon(_ value: ___) -> Self { // "drawable resource"
//        icon = value
//        return self
//    }
    
//    var label="string resource"
//
//    /// A user-readable label for the Instrumentation class. The label can be set as a raw string or a reference to a string resource.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#label)
//    @discardableResult
//    public func label(_ value: ___) -> Self { // "string resource"
//        label = value
//        return self
//    }
    
    var name: String?
    
    /// The name of the Instrumentation subclass.
    ///
    /// This should be a fully qualified class name (such as, "com.example.project.StringInstrumentation").
    ///
    /// However, as a shorthand, if the first character of the name is a period,
    /// it is appended to the package name specified in the `<manifest>` element.
    ///
    /// There is no default. The name must be specified.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#nm)
    @discardableResult
    public func name(_ value: String) -> Self {
        name = value
        return self
    }
    
    var targetPackage: String?
    
    /// The application that the Instrumentation object will run against.
    ///
    /// An application is identified by the package name assigned in its manifest file by the `<manifest>` element.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#trgt)
    @discardableResult
    public func targetPackage(_ value: String) -> Self {
        targetPackage = value
        return self
    }
    
    var targetProcesses: String?
    
    /// The processes that the Instrumentation object will run against.
    ///
    /// A comma-separated list indicates that the instrumentation will run against those specific processes.
    ///
    /// A value of "*" indicates that the instrumentation will run against all processes of the app defined in android:targetPackage.
    ///
    /// If this value isn't provided in the manifest, the instrumentation will run only against the main process of the app defined in android:targetPackage.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#trgtproc)
    @discardableResult
    public func targetProcesses(_ value: String) -> Self {
        targetProcesses = value
        return self
    }
}
