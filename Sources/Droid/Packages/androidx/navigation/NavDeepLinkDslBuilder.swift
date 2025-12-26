//
//  NavDeepLinkDslBuilder.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// DSL for constructing a new NavDeepLink
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLinkDslBuilder)
@MainActor
public final class NavDeepLinkDslBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDeepLinkDslBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(NavDeepLinkDslBuilder.className),
            let global = clazz.newObject()
        else { return nil }
        self.object = global
    }
}

extension NavDeepLinkDslBuilder {
    /// Intent action for the deep link
    public func action() -> String? {
        guard
            let clazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getAction", returningClass: clazz)
        else { return nil }
        return JString(global).string()
    }

    /// MimeType for the deep link
    public func mimeType() -> String? {
        guard
            let clazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getMimeType", returningClass: clazz)
        else { return nil }
        return JString(global).string()
    }

    /// The uri pattern of the deep link
    ///
    /// If used with safe args, this will override the `uriPattern`
    /// from KClass that was set during `NavDestinationBuilder` initialization.
    public func uriPattern() -> String? {
        guard
            let clazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getUriPattern", returningClass: clazz)
        else { return nil }
        return JString(global).string()
    }

    /// Intent action for the deep link
    public func setAction(_ action: String) {
        callVoidMethod(name: "setAction", args: action)
    }

    /// MimeType for the deep link
    public func mimeType(_ mimeType: String) {
        callVoidMethod(name: "setMimeType", args: mimeType)
    }

    /// The uri pattern of the deep link
    ///
    /// If used with safe args, this will override the `uriPattern`
    /// from KClass that was set during `NavDestinationBuilder` initialization.
    public func uriPattern(_ uriPattern: String) {
        callVoidMethod(name: "setUriPattern", args: uriPattern)
    }
}