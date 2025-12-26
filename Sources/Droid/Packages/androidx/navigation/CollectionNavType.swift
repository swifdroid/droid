//
//  CollectionNavType.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// A NavType for Collection such as arrays, lists, maps.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/CollectionNavType)
@MainActor
public final class CollectionNavType: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/CollectionNavType" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? (isNullableAllowed: Bool) {
        guard
            let clazz = JClass.load(CollectionNavType.className),
            let global = clazz.newObject(args: isNullableAllowed)
        else { return nil }
        self.object = global
    }
}

extension CollectionNavType {
    /// Create and return an empty collection of type T
    ///
    /// For example, T of type List should return emptyList().
    // public func emptyCollection<T: JClassNameable>() -> JObject? {
    //     guard
    //         let returningClazz = JClass.load(T.className),
    //         let global = object.callObjectMethod(name: "getEmptyCollection", returningClass: returningClazz)
    //     else { return nil }
    //     return global
    // }
    
    // TODO: serializeAsValues
}