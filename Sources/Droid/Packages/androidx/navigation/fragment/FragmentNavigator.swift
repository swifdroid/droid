//
//  FragmentNavigator.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Navigator that navigates through fragment transactions.
/// Every destination using this Navigator must set a valid Fragment class
/// name with android:name or Destination.setClassName.
/// 
/// The current Fragment from FragmentNavigator's perspective can be retrieved
/// by calling FragmentManager.getPrimaryNavigationFragment
/// with the FragmentManager passed to this FragmentNavigator.
/// 
/// Note that the default implementation does Fragment transactions
/// asynchronously, so the current Fragment will not be available immediately
/// (i.e., in callbacks to NavController.OnDestinationChangedListener).
/// 
/// FragmentNavigator respects Log.isLoggable for debug logging,
/// allowing you to use adb shell setprop `log.tag.FragmentNavigator VERBOSE`.
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/fragment/FragmentNavigator)
@MainActor
open class FragmentNavigator: Navigator, @unchecked Sendable {
    open override class var className: JClassName { "androidx/navigation/fragment/FragmentNavigator" }
    
    /// Base Droid constructor with existing JNI object
    public required init (_ object: JObject) {
        super.init(object)
    }

    public init? (
        _ context: ActivityContext,
        _ fragmentManager: FragmentManager,
        _ containerId: Int32
    ) {
        guard
            let clazz = JClass.load(FragmentNavigator.className),
            let global = clazz.newObject(args:
                context.signed(as: "android/content/Context"),
                fragmentManager.signed(as: FragmentManager.className),
                containerId
            )
        else { return nil }
        super.init(global)
    }
}

extension FragmentNavigator {
    /// Create a new destination associated with this Navigator.
    // public func createDestination() -> FragmentNavigator.Destination? {
    //     guard
    //         let returningClazz = JClass.load(FragmentNavigator.Destination.className),
    //         let global = callObjectMethod(name: "createDestination", returningClass: returningClazz)
    //     else { return nil }
    //     return .init(global)
    // }

    // TODO: navigate with List<NavBackStackEntry>

    // TODO: implement `on` methods
}

extension FragmentNavigator {
    @MainActor
    public final class Destination: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "androidx/navigation/fragment/FragmentNavigator$Destination" }

        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }
    }
}