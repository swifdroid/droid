//
//  ActionOnlyNavDirections.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// An implementation of `NavDirections` without any arguments.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/ActionOnlyNavDirections)
public final class ActionOnlyNavDirections: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/ActionOnlyNavDirections" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension ActionOnlyNavDirections {
    /// An action id to navigate with.
    public func actionId() -> Int32 {
        callIntMethod(name: "getActionId") ?? 0
    }

    /// The arguments to be passed to the destination of this navigation.
    public func arguments() -> Bundle? {
        guard
            let returningClazz = JClass.load(Bundle.className),
            let global = object.callObjectMethod(name: "getArguments", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }
}