//
//  NavType.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// NavType denotes the type that can be used in a NavArgument.
/// 
/// There are built-in NavTypes for primitive types, such as int, long, boolean, float, and strings, parcelable, and serializable classes (including Enums), as well as arrays of each supported type.
/// 
/// You should only use one of the static NavType instances and subclasses defined in this class.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavType)
@MainActor
public final class NavType: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavType" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (isNullableAllowed: Bool) {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.newObject(args: isNullableAllowed)
        else { return nil }
        self.object = global
    }
}

// MARK: Static Methods

extension NavType {
    public static var BoolArrayType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "BoolArrayType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var BoolType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "BoolType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var FloatArrayType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "FloatArrayType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var FloatType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "FloatType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var IntArrayType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "IntArrayType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var IntType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "IntType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var LongArrayType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "LongArrayType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var LongType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "LongType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var StringArrayType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "StringArrayType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    public static var StringType: NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectField(name: "StringType", returningClass: clazz)
        else { return nil }
        return NavType(global)
    }

    /// Parse an argType string into a NavType.
    public static func fromArgType(_ type: String, _ packageName: String) -> NavType? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = clazz.staticObjectMethod(
                name: "fromArgType",
                args: type, packageName,
                returningClass: clazz
            )
        else { return nil }
        return NavType(global)
    }
}

// MARK: Instance Methods

extension NavType {
    public func get(_ bundle: Bundle, _ key: String) -> JObject? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = callObjectMethod(name: "get", args: bundle.signed(as: Bundle.className), key, returningClass: clazz)
        else { return nil }
        return global
    }

    /// The name of this type.
    public func name() -> String? {
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let global = callObjectMethod(name: "getName", returningClass: stringClazz)
        else { return nil }
        return JString(global).string()
    }

    /// Check if an argument with this type can hold a null value.
    public func isNullableAllowed() -> Bool {
        callBoolMethod(name: "isNullableAllowed") ?? false
    }

    /// Parse a value of this type from a String.
    public func parseValue(_ value: String) -> JObject? {
        guard
            let clazz = JClass.load(NavType.className),
            let global = callObjectMethod(name: "parseValue", args: value, returningClass: clazz)
        else { return nil }
        return global
    }
}