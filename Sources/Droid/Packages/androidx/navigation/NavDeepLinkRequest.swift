//
//  NavDeepLinkRequest.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// A request for a deep link in a NavDestination.
/// 
/// NavDeepLinkRequest are used to check if a NavDeepLink exists
/// for a NavDestination and to navigate to a NavDestination with a matching NavDeepLink.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLinkRequest)
@MainActor
public final class NavDeepLinkRequest: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDeepLinkRequest" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavDeepLinkRequest {
    /// The action from the NavDeepLinkRequest.
    public func action() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getAction", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The mimeType from the NavDeepLinkRequest.
    public func mimeType() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getMimeType", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The uri from the NavDeepLinkRequest.
    public func uri() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getUri", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// A builder for constructing NavDeepLinkRequest instances.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLinkRequest.Builder)
    @MainActor
    public final class Builder: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/NavDeepLinkRequest$Builder" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        /// Build the NavDeepLinkRequest specified by this builder.
        public func build() -> NavDeepLinkRequest? {
            guard
                let returningClazz = JClass.load(NavDeepLinkRequest.className),
                let global = callObjectMethod(name: "build", returningClass: returningClazz)
            else { return nil }
            return .init(global)
        }

        /// Creates a NavDeepLinkRequest.Builder with a set action.
        public static func fromAction(_ action: String) -> Builder? {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.staticObjectMethod(
                    name: "fromAction",
                    args: action,
                    returningClass: clazz
                )
            else { return nil }
            return .init(global)
        }

        /// Creates a NavDeepLinkRequest.Builder with a set mimeType.
        public static func fromMimeType(_ mimeType: String) -> Builder? {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.staticObjectMethod(
                    name: "fromMimeType",
                    args: mimeType,
                    returningClass: clazz
                )
            else { return nil }
            return .init(global)
        }

        /// Creates a NavDeepLinkRequest.Builder with a set uri.
        public static func fromUri(_ uri: NavUri) -> Builder? {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.staticObjectMethod(
                    name: "fromUri",
                    args: uri.signed(as: NavUri.className),
                    returningClass: clazz
                )
            else { return nil }
            return .init(global)
        }

        /// Set the action for the NavDeepLinkRequest.
        public func setAction(_ action: String) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(name: "setAction", args: action, returningClass: clazz)
            return self
        }

        /// Set the mimeType for the NavDeepLinkRequest.
        public func mimeType(_ mimeType: String) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(name: "setMimeType", args: mimeType, returningClass: clazz)
            return self
        }

        /// Set the uri for the NavDeepLinkRequest.
        public func setUri(_ uri: NavUri) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(
                name: "setUri",
                args: uri.signed(as: NavUri.className),
                returningClass: clazz
            )
            return self
        }
    }
}