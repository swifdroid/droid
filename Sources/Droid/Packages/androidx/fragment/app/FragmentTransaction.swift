//
//  FragmentTransaction.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentTransaction)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class FragmentTransaction: JObjectable, Sendable {
    public class var className: JClassName { .init(stringLiteral: "androidx/fragment/app/FragmentTransaction") }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension FragmentTransaction {
    public enum Transit: Int32 {
        case enterMask = 4096
        case exitMask = 8192
        case fragmentClose = 8194
        case fragmentFade = 4099
        case fragmentMatchActivityClose = 8197
        case fragmentMatchActivityOpen = 4100
        case fragmentOpen = 4097
        case none = 0
        case unset = -1
    }

    /// Calls `add` with a `null` tag.
    @discardableResult
    public func add(
        containerViewId: Int32,
        fragment: Fragment
    ) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "add", args: containerViewId, fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Calls `add` with a 0 `containerViewId`.
    @discardableResult
    public func add(
        fragment: Fragment,
        tag: String
    ) -> FragmentTransaction! {
        guard
            let str = JString(from: tag),
            let global = object.callObjectMethod(name: "add", args: fragment.signed(as: Fragment.className), str.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Add a fragment to the activity state.
    /// 
    /// This fragment may optionally also have its view (if `Fragment.onCreateView` returns non-null) into a container view of the activity.
    @discardableResult
    public func add(
        container: ViewGroup,
        fragment: Fragment,
        tag: String
    ) -> FragmentTransaction! {
        guard
            let str = JString(from: tag),
            let container = container.instance,
            let global = object.callObjectMethod(name: "add", args: container.object.signed(as: ViewGroup.className), fragment.signed(as: Fragment.className), str.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Calls `add` with a `null` tag.
    // @discardableResult
    // public func add(
    //     containerViewId: Int32,
    //     fragmentClass: JClass,
    //     args: Bundle
    // ) -> FragmentTransaction! {
    //     guard
    //         let global = object.callObjectMethod(name: "add", args: containerViewId, fragmentClass., args.signed(as: Bundle.className), returning: .object(FragmentTransaction.className))
    //     else { return nil }
    //     return .init(global)
    // }

    /// Add a fragment to the activity state.
    /// 
    /// This fragment may optionally also have its view (if `Fragment.onCreateView` returns non-null) into a container view of the activity.
    @discardableResult
    public func add(
        containerViewId: Int32,
        fragment: Fragment,
        tag: String
    ) -> FragmentTransaction! {
        guard
            let str = JString(from: tag),
            let global = object.callObjectMethod(name: "add", args: containerViewId, fragment.signed(as: Fragment.className), str.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Used with custom Transitions to map a View from a removed or hidden Fragment
    /// to a View from a shown or added Fragment. sharedElement must have a unique transitionName in the View hierarchy.
    @discardableResult
    public func addSharedElement(
        sharedElement: View,
        name: String
    ) -> FragmentTransaction! {
        guard
            let name = JString(from: name),
            let sharedElement = sharedElement.instance,
            let global = object.callObjectMethod(name: "addSharedElement", args: sharedElement.signed(as: View.className), name.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Add this transaction to the back stack.
    /// This means that the transaction will be remembered after it is committed,
    /// and will reverse its operation when later popped off the stack.
    /// 
    /// `setReorderingAllowed` must be set to true in the same transaction as `addToBackStack()`
    /// to allow the pop of that transaction to be reordered.
    @discardableResult
    public func addToBackStack(
        name: String
    ) -> FragmentTransaction! {
        guard
            let name = JString(from: name),
            let global = object.callObjectMethod(name: "addToBackStack", args: name.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Re-attach a fragment after it had previously been detached from the UI with detach.
    /// 
    /// This causes its view hierarchy to be re-created, attached to the UI, and displayed.
    @discardableResult
    public func attach(
        fragment: Fragment
    ) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "attach", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Schedules a commit of this transaction.
    /// 
    /// The commit does not happen immediately; it will be scheduled as work on the main thread to be done the next time that thread is ready.
    /// 
    /// A transaction can only be committed with this method prior to its containing activity saving its state.
    /// If the commit is attempted after that point, an exception will be thrown.
    /// This is because the state after the commit can be lost if the activity needs to be restored from its state.
    /// 
    /// See [commitAllowingStateLoss](https://developer.android.com/reference/androidx/fragment/app/FragmentTransaction#commitAllowingStateLoss())
    /// for situations where it may be okay to lose the commit.
    @discardableResult
    public func commit() -> Int! {
        guard let value = object.callIntMethod(name: "commit") else { return nil }
        return Int(value)
    }

    /// Like `commit` but allows the commit to be executed after an activity's state is saved.
    /// This is dangerous because the commit can be lost if the activity needs to later be restored from its state,
    /// so this should only be used for cases where it is okay for the UI state to change unexpectedly on the user.
    @discardableResult
    public func commitAllowingStateLoss() -> Int! {
        guard let value = object.callIntMethod(name: "commitAllowingStateLoss") else { return nil }
        return Int(value)
    }

    /// Commits this transaction synchronously.
    /// 
    /// Any added fragments will be initialized and brought completely to the lifecycle state of their host
    /// and any removed fragments will be torn down accordingly before this call returns.
    /// Committing a transaction in this way allows fragments to be added as dedicated,
    /// encapsulated components that monitor the lifecycle state of their host while providing
    /// firmer ordering guarantees around when those fragments are fully initialized and ready.
    /// Fragments that manage views will have those views created and attached.
    /// 
    /// Calling `commitNow` is preferable to calling commit followed by `executePendingTransactions` as the latter
    /// will have the side effect of attempting to commit all currently pending transactions whether that is the desired behavior or not.
    /// 
    /// Transactions committed in this way may not be added to the `FragmentManager`'s back stack,
    /// as doing so would break other expected ordering guarantees for other asynchronously committed transactions.
    /// This method will throw `IllegalStateException` if the transaction previously requested to be added to the back stack with `addToBackStack`.
    /// 
    /// A transaction can only be committed with this method prior to its containing activity saving its state.
    /// If the commit is attempted after that point, an exception will be thrown.
    /// This is because the state after the commit can be lost if the activity needs to be restored from its state.
    /// 
    /// See [commitAllowingStateLoss](https://developer.android.com/reference/androidx/fragment/app/FragmentTransaction#commitAllowingStateLoss()
    ///  for situations where it may be okay to lose the commit.
    public func commitNow() {
        object.callVoidMethod(name: "commitNow")
    }

    /// Like `commitNow` but allows the commit to be executed after an activity's state is saved.
    /// 
    /// This is dangerous because the commit can be lost if the activity needs to later be restored from its state,
    // so this should only be used for cases where it is okay for the UI state to change unexpectedly on the user.
    public func commitNowAllowingStateLoss() {
        object.callVoidMethod(name: "commitNowAllowingStateLoss")
    }

    /// Detach the given fragment from the UI.
    /// 
    /// This is the same state as when it is put on the back stack:
    /// the fragment is removed from the UI, however its state is still being actively managed by the fragment manager.
    /// When going into this state its view hierarchy is destroyed.
    public func detach(_ fragment: Fragment) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "detach", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Disallow calls to `addToBackStack`.
    /// 
    /// Any future calls to `addToBackStack` will throw `IllegalStateException`.
    /// If `addToBackStack` has already been called, this method will throw `IllegalStateException`.
    public func disallowAddToBackStack() -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "disallowAddToBackStack", returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Hides an existing fragment.
    /// 
    /// This is only relevant for fragments whose views have been added to a container, as this will cause the view to be hidden.
    public func hide(_ fragment: Fragment) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "hide", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Returns true if this `FragmentTransaction` is allowed to be added to the back stack.
    /// 
    /// If this method would return false, `addToBackStack` will throw `IllegalStateException`.
    public func isAddToBackStackAllowed() -> Bool {
        object.callBoolMethod(name: "isAddToBackStackAllowed") ?? false
    }

    /// Returns `true` if this transaction contains no operations, `false` otherwise.
    public func isEmpty() -> Bool {
        object.callBoolMethod(name: "isEmpty") ?? false
    }

    /// Remove an existing fragment.
    /// 
    /// If it was added to a container, its view is also removed from that container.
    public func remove(_ fragment: Fragment) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "remove", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Calls `replace` with a `null` tag.
    @discardableResult
    public func replace(
        containerViewId: Int32,
        fragment: Fragment
    ) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "replace", args: containerViewId, fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Replace an existing fragment that was added to a container.
    /// 
    /// This is essentially the same as calling remove for all currently added fragments
    /// that were added with the same `containerViewId` and then add with the same arguments given here.
    @discardableResult
    public func replace(
        containerViewId: Int32,
        fragment: Fragment,
        tag: String
    ) -> FragmentTransaction! {
        guard
            let tag = JString(from: tag),
            let global = object.callObjectMethod(name: "replace", args: containerViewId, fragment.signed(as: Fragment.className), tag.signedAsString(), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Set specific animation resources to run for the fragments that are entering and exiting in this transaction.
    /// 
    /// These animations will not be played when popping the back stack.
    public func setCustomAnimations(_ enter: Int32, _ exit: Int32) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "setCustomAnimations", args: enter, exit, returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Set specific animation resources to run for the fragments that are entering and exiting in this transaction.
    /// 
    /// The `popEnter` and `popExit` animations will be played for enter/exit operations specifically when popping the back stack.
    public func setCustomAnimations(_ enter: Int32, _ exit: Int32, _ popEnter: Int32, _ popExit: Int32) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "setCustomAnimations", args: enter, exit, popEnter, popExit, returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    // TODO: setMaxLifecycle (implement passing Lifecycle.State via JNI)

    /// Set a currently active fragment in this `FragmentManager` as the primary navigation fragment.
    /// 
    /// The primary navigation fragment's child `FragmentManager` will be called first
    /// to process delegated navigation actions such as `popBackStack` if no `ID` or transaction name is provided to pop to.
    /// Navigation operations outside of the fragment system may choose to delegate those actions
    /// to the primary navigation fragment as returned by `getPrimaryNavigationFragment`.
    /// 
    /// The fragment provided must currently be added to the `FragmentManager` to be set as a primary navigation fragment,
    /// or previously added as part of this transaction.
    public func setPrimaryNavigationFragment(_ fragment: Fragment) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "setPrimaryNavigationFragment", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Sets whether or not to allow optimizing operations within and across transactions.
    /// This will remove redundant operations, eliminating operations that cancel.
    /// For example, if two transactions are executed together, one that adds a fragment **A** and the next
    /// replaces it with fragment **B**, the operations will cancel and only fragment **B** will be added.
    /// That means that fragment **A** may not go through the creation/destruction lifecycle.
    /// 
    /// The side effect of removing redundant operations is that fragments may have state changes out of the expected order.
    /// For example, one transaction adds fragment **A**, a second adds fragment **B**, then a third removes fragment **A**.
    /// Without removing the redundant operations, fragment **B** could expect that while it is being created, fragment **A**
    /// will also exist because fragment **A** will be removed after fragment **B** was added.
    // With removing redundant operations, fragment **B** cannot expect fragment **A** to exist when it has been created because fragment **A**'s add/remove will be optimized out.
    /// 
    /// It can also reorder the state changes of Fragments to allow for better Transitions.
    /// Added Fragments may have `onCreate` called before replaced Fragments have `onDestroy` called.
    /// 
    /// `postponeEnterTransition` requires `setReorderingAllowed(true)`.
    /// 
    /// The default is `false`.
    public func setReorderingAllowed(_ reorderingAllowed: Bool) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "setReorderingAllowed", args: reorderingAllowed, returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Select a standard transition animation for this transaction.
    public func setTransition(_ transition: Transit) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "setTransition", args: transition.rawValue, returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }

    /// Shows a previously hidden fragment.
    /// 
    /// This is only relevant for fragments whose views have been added to a container, as this will cause the view to be shown.
    public func show(_ fragment: Fragment) -> FragmentTransaction! {
        guard
            let global = object.callObjectMethod(name: "show", args: fragment.signed(as: Fragment.className), returning: .object(FragmentTransaction.className))
        else { return nil }
        return .init(global)
    }
}