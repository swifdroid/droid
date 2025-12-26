//
//  NavBackStackEntry.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Representation of an entry in the back stack of a `NavController`.
///
/// The Lifecycle, ViewModelStore, and SavedStateRegistry provided via this object
/// are valid for the lifetime of this destination on the back stack:
/// when this destination is popped off the back stack,
/// the lifecycle will be destroyed, state will no longer be saved,
/// and ViewModels will be cleared.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavBackStackEntry)
@MainActor
public final class NavBackStackEntry: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavBackStackEntry" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavBackStackEntry {
    // TODO: getArguments

    // TODO: getDefaultViewModelCreationExtras

    // TODO: getDefaultViewModelProviderFactory

    /// The destination associated with this entry.
    public func destination() -> NavDestination? {
        guard
            let returningClazz = JClass.load(NavDestination.className),
            let global = object.callObjectMethod(name: "getDestination", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// The unique ID that serves as the identity of this entry.
    public func id() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = object.callObjectMethod(name: "getId", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    // TODO: getLifecycle

    // TODO: getSavedStateHandle

    // TODO: getSavedStateRegistry

    // TODO: getViewModelStore
}