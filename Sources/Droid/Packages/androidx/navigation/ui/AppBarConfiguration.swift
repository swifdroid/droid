//
//  AppBarConfiguration.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Configuration options for NavigationUI methods
/// that interact with implementations of the app bar pattern.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/ui/AppBarConfiguration)
@MainActor
open class AppBarConfiguration: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "androidx/navigation/ui/AppBarConfiguration" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension AppBarConfiguration {
    // TODO: getFallbackOnNavigateUpListener
    // TODO: getOpenableLayout
    // TODO: getTopLevelDestinations

    /// Determines whether a NavDestination is a top level destination in AppBarConfiguration.
    ///
    /// Returns true if the NavDestination was added directly as a top level destination
    public func isTopLevelDestination(_ destination: NavDestination) -> Bool {
        callBoolMethod(
            name: "isTopLevelDestination",
            args: destination.signed(as: NavDestination.className)
        ) ?? false
    }
}

extension AppBarConfiguration {
    /// The Builder class for constructing new AppBarConfiguration instances.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/ui/AppBarConfiguration.Builder)
    @MainActor
    open class Builder: JObjectable, @unchecked Sendable {
        open class var className: JClassName { "androidx/navigation/ui/AppBarConfiguration$Builder" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        /// Create a new Builder whose only top level destination
        /// is the start destination of the given NavGraph.
        /// The Up button will not be displayed when on the start destination of the graph.
        public init? (_ navGraph: NavGraph) {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.newObject(args: navGraph.signed(as: NavGraph.className))
            else { return nil }
            self.object = global
        }

        /// Create a new Builder with a specific set of top level destinations.
        /// The Up button will not be displayed when on these destinations.
        public convenience init? (_ topLevelDestinationIds: Int32...) {
            self.init(topLevelDestinationIds)
        }
        
        /// Create a new Builder with a specific set of top level destinations.
        /// The Up button will not be displayed when on these destinations.
        public init? (_ topLevelDestinationIds: [Int32]) {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.newObject(args: topLevelDestinationIds)
            else { return nil }
            self.object = global
        }

        /// Create a new Builder using a Menu containing all top level destinations.
        /// It is expected that the menu item id of each item corresponds
        /// with a destination in your navigation graph.
        /// The Up button will not be displayed when on these destinations.
        public init? (_ topLevelMenu: Menu) {
            guard
                let clazz = JClass.load(Builder.className),
                let global = clazz.newObject(args: topLevelMenu.signed(as: Menu.className))
            else { return nil }
            self.object = global
        }

        /// Construct the AppBarConfiguration instance.
        public func build() -> AppBarConfiguration? {
            guard
                let clazz = JClass.load(AppBarConfiguration.className),
                let global = callObjectMethod(name: "build", returningClass: clazz)
            else { return nil }
            return AppBarConfiguration(global)
        }

        // TODO: setFallbackOnNavigateUpListener
        // TODO: setOpenableLayout
    }
}