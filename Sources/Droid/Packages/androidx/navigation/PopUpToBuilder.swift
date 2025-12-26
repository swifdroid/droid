//
//  PopUpToBuilder.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// DSL for customizing `NavOptionsBuilder.popUpTo` operations.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/PopUpToBuilder)
@MainActor
public final class PopUpToBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/PopUpToBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(PopUpToBuilder.className),
            let global = clazz.newObject()
        else { return nil }
        self.object = global
    }
}

extension PopUpToBuilder {
    /// Whether the `popUpTo` destination should be popped from the back stack.
    public func inclusive() -> Bool {
        callBoolMethod(name: "getInclusive") ?? false
    }

    /// Whether the back stack and the state of all destinations
    /// between the current destination and the NavOptionsBuilder.popUpTo ID
    /// should be saved for later restoration via NavOptionsBuilder.restoreState
    /// or the restoreState attribute using
    /// the same NavOptionsBuilder.popUpTo ID (note: this matching ID is true if inclusive is true.
    /// If inclusive is false, this matching ID is the id of the last destination that is popped).
    public func saveState() -> Bool {
        callBoolMethod(name: "getSaveState") ?? false
    }

    /// Whether the popUpTo destination should be popped from the back stack.
    @discardableResult
    public func inclusive(_ inclusive: Bool) -> Self {
        callVoidMethod(name: "setInclusive", args: inclusive)
        return self
    }

    /// Whether the back stack and the state of all destinations
    /// between the current destination and the NavOptionsBuilder.popUpTo ID
    /// should be saved for later restoration via NavOptionsBuilder.restoreState
    /// or the restoreState attribute using the same NavOptionsBuilder.popUpTo ID
    /// (note: this matching ID is true if inclusive is true. If inclusive is false,
    /// this matching ID is the id of the last destination that is popped).
    @discardableResult
    public func saveState(_ saveState: Bool) -> Self {
        callVoidMethod(name: "setSaveState", args: saveState)
        return self
    }
}