//
//  NavDirections.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// An interface that describes a navigation operation: action's id and arguments
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavDirections)
@MainActor
open class NavDirections: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "androidx/navigation/NavDirections" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavDirections {
    /// An action id to navigate with.
    public func actionId() -> Int32 {
        object.callIntMethod(name: "getActionId") ?? 0
    }

    /// Arguments to pass to the destination
    public func arguments() -> Bundle {
        guard
            let bundleClazz = JClass.load(Bundle.className),
            let bundleObject = object.callObjectMethod(name: "getArguments", returningClass: bundleClazz)
        else {
            fatalError("Failed to get Bundle from NavDirections")
        }
        return Bundle(bundleObject)
    }
}