//
//  ActivityNavigator.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// ActivityNavigator implements cross-activity navigation.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/ActivityNavigator)
@MainActor
public final class ActivityNavigator: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/ActivityNavigator" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: ActivityContext) {
        guard
            let clazz = JClass.load(ActivityNavigator.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }
}

extension ActivityNavigator {
    /// Apply any pop animations in the Intent of the given `Activity` to a pending transition.
    ///
    /// This should be used in place of `Activity.overridePendingTransition`
    /// to get the appropriate pop animations.
    ///
    /// Parameters:
    ///   - activity: An activity started from the `ActivityNavigator`.
    public func applyPopAnimationsToPendingTransition(_ activity: Activity) {
        guard let context = activity.context else { return }
        callVoidMethod(
            name: "applyPopAnimationsToPendingTransition",
            args: context.signed(as: "android/app/Activity")
        )
    }

    // TODO: createDestination
}

extension ActivityNavigator {
    /// NavDestination for activity navigation
    ///
    /// Construct a new activity destination.
    /// This destination is not valid until you set the `Intent`
    /// via `setIntent` or one or more of the other set method.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/ActivityNavigator.Destination)
    public final class Destination: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/ActivityNavigator$Destination" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }
    }

    /// The action used to start the Activity, if any.
    public func action() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let stringObject = object.callObjectMethod(name: "getAction", returningClass: stringClazz),
            let stringValue = JString(stringObject).string()
        else { return nil }
        return stringValue
    }

    // TODO: getComponent

    /// The data URI used to start the Activity, if any.
    public func data() -> Uri? {
        guard
            let uriClazz = JClass.load(Uri.className),
            let uriObject = object.callObjectMethod(name: "getData", returningClass: uriClazz)
        else { return nil }
        return Uri(uriObject)
    }

    /// The dynamic data URI pattern, if any.
    public func dataPattern() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let stringObject = object.callObjectMethod(name: "getDataPattern", returningClass: stringClazz),
            let stringValue = JString(stringObject).string()
        else { return nil }
        return stringValue
    }

    /// The Intent associated with this destination.
    public func intent() -> Intent? {
        guard
            let intentClazz = JClass.load(Intent.className),
            let intentObject = object.callObjectMethod(name: "getIntent", returningClass: intentClazz)
        else { return nil }
        return Intent(intentObject)
    }

    /// The explicit application package name associated with this destination, if any.
    public func targetPackage() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let stringObject = object.callObjectMethod(name: "getTargetPackage", returningClass: stringClazz),
            let stringValue = JString(stringObject).string()
        else { return nil }
        return stringValue
    }

    /// Sets the action sent when navigating to this destination.
    public func action(_ action: String) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(
            name: "setAction",
            args: action,
            returningClass: clazz
        )
        return self
    }

    // TODO: setComponentName

    /// Sets a static data URI that is sent when navigating to this destination.
    /// 
    /// To use a dynamic URI that changes based on the arguments passed
    /// in when navigating, use `setDataPattern`, which will take precedence
    /// when arguments are present.
    public func data(_ data: Uri) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(
            name: "setData",
            args: data.signed(as: Uri.className),
            returningClass: clazz
        )
        return self
    }

    /// Sets a dynamic data URI pattern that is sent
    /// when navigating to this destination.
    /// 
    /// If a non-null arguments Bundle is present
    /// when navigating, any segments in the form `{argName}`
    /// will be replaced with a URI encoded string from the arguments.
    public func dataPattern(_ dataPattern: String) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(
            name: "setDataPattern",
            args: dataPattern,
            returningClass: clazz
        )
        return self
    }

    /// Set the Intent to start when navigating to this destination.
    public func intent(_ intent: Intent) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(
            name: "setIntent",
            args: intent.signed(as: Intent.className),
            returningClass: clazz
        )
        return self
    }

    /// Set an explicit application package name that limits the components
    /// this destination will navigate to.
    public func targetPackage(_ targetPackage: String) -> Self {
        guard let clazz = JClass.load(Self.className) else { return self }
        _ = callObjectMethod(
            name: "setTargetPackage",
            args: targetPackage,
            returningClass: clazz
        )
        return self
    }

    /// Extras that can be passed to `ActivityNavigator` to customize
    /// what `ActivityOptionsCompat` and flags are passed through to the call
    /// to `ActivityCompat.startActivity`.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/ActivityNavigator.Extras)
    public final class Extras: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/ActivityNavigator$Extras" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        // TODO: getActivityOptions

        /// The `Intent.FLAG_ACTIVITY_` flags that should be added to the `Intent`.
        public func flags() -> Int32 {
            callIntMethod(name: "getFlags") ?? 0
        }

        /// Builder for constructing new Extras instances.
        ///
        /// The resulting instances are immutable.
        ///
        /// [Learn more](https://developer.android.com/reference/androidx/navigation/ActivityNavigator.Extras.Builder)
        public final class Builder: JObjectable, @unchecked Sendable {
            public class var className: JClassName { "androidx/navigation/ActivityNavigator$Extras$Builder" }

            /// JNI Object
            public let object: JObject
            
            /// Base Droid constructor with existing JNI object
            public init (_ object: JObject) {
                self.object = object
            }

            public init? () {
                guard
                    let clazz = JClass.load(Self.className),
                    let global = clazz.newObject()
                else { return nil }
                self.object = global
            }

            /// Adds one or more `Intent.FLAG_ACTIVITY_` flags
            public func addFlags(_ flags: Int32) -> Self {
                guard let clazz = JClass.load(Self.className) else { return self }
                _ = callObjectMethod(
                    name: "addFlags",
                    args: flags,
                    returningClass: clazz
                )
                return self
            }

            /// Constructs the final Extras instance.
            public func build() -> Extras? {
                guard
                    let extrasClazz = JClass.load(Extras.className),
                    let extrasObject = callObjectMethod(
                        name: "build",
                        returningClass: extrasClazz
                    )
                else { return nil }
                return Extras(extrasObject)
            }

            // TODO: setActivityOptions
        }
    }
}

/// DSL for constructing a new ActivityNavigator.Destination
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/ActivityNavigatorDestinationBuilder)
@MainActor
public final class ActivityNavigatorDestinationBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/ActivityNavigatorDestinationBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: ActivityNavigatorDestinationBuilder constructors
}

extension ActivityNavigatorDestinationBuilder {
    // TODO: ActivityNavigatorDestinationBuilder methods
}