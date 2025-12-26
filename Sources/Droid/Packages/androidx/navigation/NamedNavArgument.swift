//
//  NamedNavArgument.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Construct a named `NavArgument` by using the `navArgument` method.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NamedNavArgument)
@MainActor
public final class NamedNavArgument: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NamedNavArgument" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NamedNavArgument {
    /// Provides destructuring access to this `NamedNavArgument`'s name
    public func component1() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Provides destructuring access to this `NamedNavArgument`'s argument
    public func component2() -> NavArgument? {
        guard
            let returningClazz = JClass.load(NavArgument.className),
            let global = object.callObjectMethod(name: "getArgument", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The NavArgument associated with the name
    public func argument() -> NavArgument? {
        guard
            let returningClazz = JClass.load(NavArgument.className),
            let global = object.callObjectMethod(name: "getArgument", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The name the argument is associated with
    public func name() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }
}