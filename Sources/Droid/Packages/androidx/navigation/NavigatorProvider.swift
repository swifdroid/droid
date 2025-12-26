//
//  NavigatorProvider.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// A NavigationProvider stores a set of Navigators that are valid ways to navigate to a destination.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavigatorProvider)
@MainActor
public final class NavigatorProvider: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavigatorProvider" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(NavigatorProvider.className),
            let global = clazz.newObject()
        else { return nil }
        self.object = global
    }
}

extension NavigatorProvider {
    /// Register a navigator using the name provided by the Navigator.Name annotation.
    /// destinations may refer to any registered navigator by name for inflation.
    /// If a navigator by this name is already registered, this new navigator will replace it.
    public func addNavigator(_ navigator: Navigator) -> Navigator? {
        guard
            let clazz = JClass.load(Navigator.className),
            let global = callObjectMethod(
                name: "addNavigator",
                args: navigator.signed(as: Navigator.className),
                returningClass: clazz
            )
        else { return nil }
        return Navigator(global)
    }

    /// Register a navigator using the name provided by the Navigator.Name annotation.
    /// destinations may refer to any registered navigator by name for inflation.
    /// If a navigator by this name is already registered, this new navigator will replace it.
    public func addNavigator(_ name: String, _ navigator: Navigator) -> Navigator? {
        guard
            let clazz = JClass.load(Navigator.className),
            let global = callObjectMethod(
                name: "addNavigator",
                args: name, navigator.signed(as: Navigator.className),
                returningClass: clazz
            )
        else { return nil }
        return Navigator(global)
    }

    /// Retrieves a registered Navigator by name.
    public func navigator(_ name: String) -> Navigator? {
        guard
            let clazz = JClass.load(Navigator.className),
            let global = callObjectMethod(
                name: "getNavigator",
                args: name,
                returningClass: clazz
            )
        else { return nil }
        return Navigator(global)
    }

    /// Retrieves a registered Navigator by name.
    public func navigator<T>(_ class: T.Type) -> T? where T: Navigatorable {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let lookupClazz = JClass.load(`class`.className),
            let returningClazz = JClass.load(Navigator.className),
            let global = callObjectMethod(
                name: "getNavigator",
                args: lookupClazz.ref.box(env)?.object().signed(as: "java/lang/Class"),
                returningClass: returningClazz
            )
        else { return nil }
        return T.init(global)
        #else
        return nil
        #endif
    }

    /// Retrieves a registered Navigator by name.
    public func navigator(_ receiver: NavigatorProvider, _ name: String) -> Navigator? {
        guard
            let clazz = JClass.load(Navigator.className),
            let global = callObjectMethod(
                name: "getNavigator",
                args: receiver.signed(as: NavigatorProvider.className), name,
                returningClass: clazz
            )
        else { return nil }
        return Navigator(global)
    }

    /// Register a navigator using the name provided by the Navigator.Name annotation.
    public func plusAssign(_ receiver: NavigatorProvider, _ navigator: Navigator) {
        callVoidMethod(
            name: "plusAssign",
            args: receiver.signed(as: NavigatorProvider.className),
                navigator.signed(as: Navigator.className)
        )
    }

    /// Register a Navigator by name.
    /// If a navigator by this name is already registered,
    /// this new navigator will replace it.
    public func set(_ receiver: NavigatorProvider, _ name: String, _ navigator: Navigator) {
        callVoidMethod(
            name: "set",
            args: receiver.signed(as: NavigatorProvider.className),
                navigator.signed(as: Navigator.className)
        )
    }
}