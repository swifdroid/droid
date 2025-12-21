//
//  FragmentManager.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentManager)
@MainActor
public final class FragmentManager: JObjectable, Contextable, Sendable {
    public class var className: JClassName { .init(stringLiteral: "androidx/fragment/app/FragmentManager") }

    public let object: JObject
    public private(set) weak var context: ActivityContext?

    public init (_ object: JObject, _ context: Contextable) {
        self.object = object
        self.context = context.context
    }
}

extension FragmentManager {
    /// Flag for popBackStack and popBackStack:
    /// 
    /// If set, and the name or ID of a back stack entry has been supplied,
    /// then all matching entries will be consumed until one that doesn't match is found or the bottom of the stack is reached.
    ///
    /// Otherwise, all entries up to but not including that entry will be removed.
    public static let popBackStackInclusive: Int32 = 1

    // TODO: addFragmentOnAttachListener
    // TODO: addOnBackStackChangedListener

    /// Start a series of edit operations on the Fragments associated with this FragmentManager.
    /// 
    /// Note: A fragment transaction can only be created/committed prior to an activity saving its state.
    /// If you try to commit a transaction after `FragmentActivity.onSaveInstanceState()`
    /// (and prior to a following `FragmentActivity.onStart` or `FragmentActivity.onResume()`), you will get an error.
    /// This is because the framework takes care of saving your current fragments in the state, and if changes are made after the state is saved then they will be lost.
    public func beginTransaction() -> FragmentTransaction! {
        guard
            let returningClazz = JClass.load(FragmentTransaction.className),
            let global = object.callObjectMethod(name: "beginTransaction", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    /// Clears the back stack previously saved via `saveBackStack`.
    ///
    /// This will result in all of the transactions that made up that back stack to be thrown away,
    /// thus destroying any fragments that were added through those transactions.
    ///
    /// All state of those fragments will be cleared as part of this process.
    /// If no state was previously saved with the given name, this operation does nothing.
    /// 
    /// This function is asynchronous – it enqueues the request to clear, but the action will not be performed until the application returns to its event loop.
    public func clearBackStack(name: String) {
        guard let str = JString(from: name) else { return }
        object.callVoidMethod(name: "clearBackStack", args: str.signedAsString())
    }

    /// Clears the stored result for the given requestKey.
    ///
    /// This clears any result that was previously set via `setFragmentResult`
    /// that hasn't yet been delivered to a `FragmentResultListener`.
    public func clearFragmentResult(requestKey: String) {
        guard let str = JString(from: requestKey) else { return }
        object.callVoidMethod(name: "clearFragmentResult", args: str.signedAsString())
    }

    /// Clears the stored `FragmentResultListener` for the given requestKey.
    ///
    /// This clears any `FragmentResultListener` that was previously set via `setFragmentResultListener`.
    public func clearFragmentResultListener(requestKey: String) {
        guard let str = JString(from: requestKey) else { return }
        object.callVoidMethod(name: "clearFragmentResult", args: str.signedAsString())
    }

    // TODO: dump?

    /// Control whether the framework's internal fragment manager debugging logs are turned on.
    ///
    /// If enabled, you will see output in logcat as the framework performs fragment operations.
    public func enableDebugLogging(_ enabled: Bool = true) {
        object.callVoidMethod(name: "enableDebugLogging", args: enabled)
    }

    /// Control whether `FragmentManager` uses the new state predictive back feature
    /// that allows seeing the previous `Fragment` when using gesture back.
    /// 
    /// This should only be changed before any fragment transactions are done
    /// (i.e., in your Application class or prior to `super.onCreate()` in every activity).
    public func enablePredictiveBack(_ enabled: Bool = true) {
        object.callVoidMethod(name: "enablePredictiveBack", args: enabled)
    }

    /// After a `FragmentTransaction` is committed with `FragmentTransaction.commit()`,
    ///  it is scheduled to be executed asynchronously on the process's main thread.
    /// If you want to immediately executing any such pending operations, you can call this function 
    /// (only from the main thread) to do so. Note that all callbacks and other related behavior will be done
    /// from within this call, so be careful about where this is called from.
    /// 
    /// If you are committing a single transaction that does not modify the fragment back stack, strongly consider using commitNow instead.
    /// This can help avoid unwanted side effects when other code in your app has pending committed transactions that expect different timing.
    /// 
    /// This also forces the start of any postponed Transactions where postponeEnterTransition has been called.
    public func executePendingTransactions() {
        object.callVoidMethod(name: "executePendingTransactions")
    }

    // TODO: findFragment?
    // TODO: findFragmentByTag?

    /// Finds a fragment that was identified by the given id either when inflated from XML
    /// or as the container ID when added in a transaction. This first searches through
    /// fragments that are currently added to the manager's activity;
    /// if no such fragment is found, then all fragments currently on the back stack associated
    /// with this ID are searched.
    public func findFragmentById(_ id: Int32) -> Fragment? {
        guard
            let returningClazz = JClass.load(Fragment.className),
            let global = object.callObjectMethod(name: "findFragmentById", args: id, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Recurse up the view hierarchy, looking for a FragmentManager
    public func findFragmentManager() -> FragmentManager? {
        guard
            let returningClazz = JClass.load(FragmentManager.className),
            let global = object.callObjectMethod(name: "findFragmentManager", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    // TODO: getBackStackEntryAt?

    /// Return the number of entries currently in the back stack.
    public func backStackEntryCount() -> Int {
        Int(object.callIntMethod(name: "getBackStackEntryCount") ?? 0)
    }

    // TODO: getFragment?

    /// Gets the current `FragmentFactory` used to instantiate new `Fragment` instances.
    /// 
    /// If no factory has been explicitly set on this `FragmentManager` via `setFragmentFactory`,
    /// the `FragmentFactory` of the parent `FragmentManager` will be returned.
    public func fragmentFactory() -> FragmentFactory! {
        guard
            let returningClazz = JClass.load(FragmentFactory.className),
            let global = object.callObjectMethod(name: "getFragmentFactory", returningClass: returningClazz)
        else { return nil }
        return .init(global, self)
    }

    // TODO: getFragments

    /// Return the currently active primary navigation fragment for this `FragmentManager`.
    /// The primary navigation fragment is set by fragment transactions using `setPrimaryNavigationFragment`.
    /// 
    /// The primary navigation fragment's child `FragmentManager` will be called first to process delegated navigation actions
    /// such as `popBackStack` if no `ID` or transaction name is provided to pop to.
    public func primaryNavigationFragment() -> Fragment? {
        guard
            let returningClazz = JClass.load(Fragment.className),
            let global = object.callObjectMethod(name: "getPrimaryNavigationFragment", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getStrictModePolicy?

    /// Returns true if the final `Activity.onDestroy()` call has been made
    /// on the `FragmentManager`'s Activity, so this instance is now dead.
    public func isDestroyed() -> Bool {
        object.callBoolMethod(name: "isDestroyed") ?? false
    }

    /// Returns true if the `FragmentManager`'s state has already been saved by its host.
    /// Any operations that would change saved state should not be performed if this method returns true.
    /// For example, any `popBackStack()` method, such as `popBackStackImmediate`
    /// or any `FragmentTransaction` using `commit` instead of `commitAllowingStateLoss`
    /// will change the state and will result in an error.
    public func isStateSaved() -> Bool {
        object.callBoolMethod(name: "isStateSaved") ?? false
    }

    // TODO: onContainerAvailable

    /// Pop the top state off the back stack.
    /// 
    /// This function is asynchronous – it enqueues the request to pop,
    /// but the action will not be performed until the application returns to its event loop.
    public func popBackStack() {
        object.callVoidMethod(name: "popBackStack")
    }

    /// Pop all back stack states up to the one with the given identifier.
    ///
    /// This function is asynchronous – it enqueues the request to pop,
    /// but the action will not be performed until the application returns to its event loop.
    public func popBackStack(id: Int, flags: Int) {
        object.callVoidMethod(name: "popBackStack", args: Int32(id), Int32(flags))
    }

    /// Pop the last fragment transition from the manager's fragment back stack.
    ///
    /// This function is asynchronous – it enqueues the request to pop,
    /// but the action will not be performed until the application returns to its event loop.
    public func popBackStack(name: String, flags: Int) {
        guard let str = JString(from: name) else { return }
        object.callVoidMethod(name: "popBackStack", args: str.signedAsString(), Int32(flags))
    }

    /// Immediately pop the last fragment transition from the manager's fragment back stack.
    public func popBackStackImmediate() -> Bool {
        object.callBoolMethod(name: "popBackStackImmediate") ?? false
    }

    /// Immediately pop the last fragment transition from the manager's fragment back stack.
    public func popBackStackImmediate(id: Int, flags: Int) {
        object.callVoidMethod(name: "popBackStackImmediate", args: Int32(id), Int32(flags))
    }

    /// Immediately pop the last fragment transition from the manager's fragment back stack.
    public func popBackStackImmediate(name: String, flags: Int) {
        guard let str = JString(from: name) else { return }
        object.callVoidMethod(name: "popBackStackImmediate", args: str.signedAsString(), Int32(flags))
    }

    // TODO: putFragment
    // TODO: registerFragmentLifecycleCallbacks
    // TODO: removeFragmentOnAttachListener
    // TODO: removeOnBackStackChangedListener

    /// Restores the back stack previously saved via `saveBackStack`.
    /// This will result in all of the transactions that made up that back stack to be re-executed,
    /// thus re-adding any fragments that were added through those transactions.
    /// All state of those fragments will be restored as part of this process.
    /// If no state was previously saved with the given name, this operation does nothing.
    /// 
    /// This function is asynchronous – it enqueues the request to restore,
    /// but the action will not be performed until the application returns to its event loop.
    public func restoreBackStack(name: String) {
        guard let str = JString(from: name) else { return }
        object.callVoidMethod(name: "restoreBackStack", args: str.signedAsString())
    }

    /// Save the back stack. While this functions similarly to `popBackStack`,
    /// it does not throw away the state of any fragments that were added through those transactions.
    /// Instead, the back stack that is saved by this method can later be restored with its state in tact.
    /// 
    /// This function is asynchronous – it enqueues the request to pop, but the action will not be performed
    /// until the application returns to its event loop.
    public func saveBackStack(name: String) {
        guard let str = JString(from: name) else { return }
        object.callVoidMethod(name: "saveBackStack", args: str.signedAsString())
    }
    
    // TODO: saveFragmentInstanceState
    
    /// Set a `FragmentFactory` for this `FragmentManager` that will be used to create new `Fragment` instances from this point onward.
    /// 
    /// The child `FragmentManager` of all `Fragments` in this `FragmentManager` will also use this factory if one is not explicitly set.
    public func fragmentFactory(_ factory: FragmentFactory) {
        object.callVoidMethod(name: "setFragmentFactory", args: factory.signed(as: FragmentFactory.className))
    }

    /// Sets the given result for the requestKey.
    ///
    /// This result will be delivered to a `FragmentResultListener` that is called given to `setFragmentResultListener` with the same requestKey.
    /// If no `FragmentResultListener` with the same key is set or the Lifecycle associated with the listener is not at least STARTED,
    /// the result is stored until one becomes available, or `clearFragmentResult` is called with the same `requestKey`.
    public func fragmentResult(requestKey: String, result: Bundle) {
        guard let str = JString(from: requestKey) else { return }
        object.callVoidMethod(name: "setFragmentFactory", args: str.signedAsString(), result.signed(as: Bundle.className))
    }

    // TODO: setFragmentResultListener
    // TODO: setStrictModePolicy
}