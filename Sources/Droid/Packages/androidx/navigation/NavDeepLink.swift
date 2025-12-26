//
//  NavDeepLink.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavDeepLink encapsulates the parsing and matching of a navigation deep link.
///
/// This should be added to a NavDestination using NavDestination.addDeepLink.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLink)
@MainActor
public final class NavDeepLink: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDeepLink" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavDeepLink {
    /// The action from the NavDeepLink.
    public func action() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getAction", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The mimeType from the NavDeepLink.
    public func mimeType() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getMimeType", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// The uri pattern from the NavDeepLink.
    public func uriPattern() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getUriPattern", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// A builder for constructing NavDeepLink instances.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLink.Builder)
    @MainActor
    public final class Builder: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/NavDeepLink$Builder" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        public func build() -> NavDeepLink? {
            guard
                let returningClazz = JClass.load(NavDeepLink.className),
                let global = object.callObjectMethod(name: "build", returningClass: returningClazz)
            else { return nil }
            return .init(global)
        }

        /// Set the action for the NavDeepLink.
        public func action(_ action: String) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(name: "setAction", args: action, returningClass: clazz)
            return self
        }

        /// Set the mimeType for the NavDeepLink.
        public func mimeType(_ mimeType: String) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(name: "setMimeType", args: mimeType, returningClass: clazz)
            return self
        }

        /// Set the uri pattern for the NavDeepLink.
        public func setUriPattern(_ uriPattern: String) -> Self {
            guard let clazz = JClass.load(Self.className) else { return self }
            _ = object.callObjectMethod(name: "setUriPattern", args: uriPattern, returningClass: clazz)
            return self
        }
    }
}

/// Class used to construct deep links to a particular destination in a NavGraph.
/// 
/// When this deep link is triggered:
/// 
/// The task is cleared.
/// The destination and all of its parents will be on the back stack.
/// Calling `NavController.navigateUp` will navigate to the parent of the destination.
/// The parent of the destination is the start destination of the containing
/// navigation graph. In the cases where the destination is the start
/// destination of its containing navigation graph, the start destination
/// of its grandparent is used.
/// 
/// You can construct an instance directly with `NavDeepLinkBuilder`
/// or build one using an existing `NavController` via `NavController.createDeepLink`.
/// 
/// If the context passed in here is not an Activity, this method
/// will use `android.content.pm.PackageManager.getLaunchIntentForPackage`
/// as the default activity to launch, if available.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDeepLinkBuilder)
@MainActor
public final class NavDeepLinkBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavDeepLinkBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: ActivityContext) {
        guard
            let clazz = JClass.load(NavDeepLinkBuilder.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}

extension NavDeepLinkBuilder {
    /// Add a new destination id to deep link to.
    ///
    /// This builds off any previous calls to this method or calls
    /// to setDestination, building the minimal synthetic back stack
    /// of start destinations between the previous deep link destination
    /// and the newly added deep link destination.
    public func addDestination(_ destId: Int32, _ args: Bundle) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "addDestination", args: destId, args.signed(as: Bundle.className), returningClass: clazz)
        return self
    }

    /// Add a new destination route to deep link to.
    ///
    /// This builds off any previous calls to this method or calls
    /// to setDestination, building the minimal synthetic back stack
    /// of start destinations between the previous deep link destination
    /// and the newly added deep link destination.
    public func addDestination(_ route: String, _ args: Bundle) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "addDestination", args: route, args.signed(as: Bundle.className), returningClass: clazz)
        return self
    }

    // TODO: createPendingIntent
    // TODO: createTaskStackBuilder

    /// Set optional arguments to send onto every destination created by this deep link.
    public func arguments(_ args: Bundle) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "setArguments", args: args.signed(as: Bundle.className), returningClass: clazz)
        return self
    }

    // TODO: setComponentName

    /// Sets the destination id to deep link to. Any destinations
    /// previous added via addDestination are cleared, effectively
    /// resetting this object back to only this single destination.
    public func destination(_ destId: Int32, _ args: Bundle) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "setDestination", args: destId, args.signed(as: Bundle.className), returningClass: clazz)
        return self
    }

    /// Sets the destination id to deep link to. Any destinations
    /// previous added via addDestination are cleared, effectively
    /// resetting this object back to only this single destination.
    public func destination(_ route: String, _ args: Bundle) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "setDestination", args: route, args.signed(as: Bundle.className), returningClass: clazz)
        return self
    }

    /// Sets the graph that contains the deep link destination.
    public func graph(_ graphId: Int32) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "setGraph", args: graphId, returningClass: clazz)
        return self
    }

    /// Sets the graph that contains the deep link destination.
    ///
    /// If you do not have access to a NavController,
    /// you can create a NavigatorProvider and use that
    /// to programmatically construct a navigation graph or use NavInflater.
    public func graph(_ graph: NavGraph) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(name: "setGraph", args: graph.signed(as: NavGraph.className), returningClass: clazz)
        return self
    }
}