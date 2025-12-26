//
//  NavArgument.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavArgument denotes an argument that is supported by a NavDestination.
///
/// A NavArgument has a type and optionally a default value,
/// that are used to read/write it in a SavedState. It can also be nullable if the type supports it.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavArgument)
@MainActor
public final class NavArgument: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavArgument" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavArgument {
    /// The default value of this argument or null if it doesn't have a default value.
    ///
    /// Use `isDefaultValuePresent` to distinguish between null and absence of a value.
    public func defaultValue() -> JObject? {
        guard
            let returningClazz = JClass.load("java/lang/Object"),
            let global = object.callObjectMethod(name: "getDefaultValue", returningClass: returningClazz)
        else { return nil }
        return global
    }

    /// The type of this NavArgument.
    public func type() -> NavType? {
        guard
            let returningClazz = JClass.load(NavType.className),
            let global = object.callObjectMethod(name: "getType", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Used to distinguish between a default value of null
    /// and an argument without an explicit default value.
    ///
    /// Parameters:
    ///  - returns: true if this argument has a default value (even if that value is set to null), false otherwise
    public func isDefaultValuePresent() -> Bool {
        callBoolMethod(name: "isDefaultValuePresent") ?? false
    }

    /// Whether this argument allows passing a null value.
    public func isNullable() -> Bool {
        callBoolMethod(name: "isNullable") ?? false
    }
}

extension NavArgument {
    /// A builder for constructing NavArgument instances.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/navigation/NavArgument.Builder)
    @MainActor
    public final class Builder: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/NavArgument$Builder" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        public init? () {
            guard
                let clazz = JClass.load(NavActionBuilder.className),
                let global = clazz.newObject()
            else { return nil }
            self.object = global
        }

        /// Build the NavArgument specified by this builder.
        ///
        /// If the type is not set, the builder will infer the type
        /// from the default argument value.
        /// If there is no default value, the type will be unspecified.
        public func build() -> NavArgument? {
            guard
                let returningClazz = JClass.load(NavArgument.className),
                let global = callObjectMethod(name: "build", returningClass: returningClazz)
            else { return nil }
            return .init(global)
        }

        // TODO: setDefaultValue

        /// Specify if the argument is nullable.
        ///
        /// The NavType you set for this argument must allow nullable values.
        public func isNullable(_ isNullable: Bool) -> Self {
            guard
                let returningClazz = JClass.load(Self.className)
            else { return self }
            _ = callObjectMethod(name: "setIsNullable", args: isNullable, returningClass: returningClazz)
            return self
        }

        // TODO: setType
    }
}