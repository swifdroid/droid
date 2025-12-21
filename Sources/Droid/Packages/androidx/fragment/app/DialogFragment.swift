//
//  DialogFragment.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

/// A fragment that displays a dialog window,
/// floating in the foreground of its activity's window.
/// This fragment contains a `Dialog` object, which it displays
/// as appropriate based on the fragment's state.
/// Control of the dialog (deciding when to show, hide, dismiss it)
/// should be done through the APIs here, not with direct calls on the dialog.
///
/// Implementations should override this class and implement
/// `onViewCreated` to supply the content of the dialog.
/// Alternatively, they can override `onCreateDialog` to create
/// an entirely custom dialog, such as an `AlertDialog`, with its own content.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/DialogFragment)
@MainActor
open class DialogFragment: Fragment {
    /// The JNI class name
    public override class var className: JClassName { "androidx/fragment/app/DialogFragment" }

    public required init(_ object: JObject) {
        super.init(object)
    }

    public override init! () {
        super.init()
    }

    public enum Style: Int32 {
        /// Basic, normal dialog.
        case normal = 0
        /// Don't include a title area.
        case noTitle = 1
        /// Don't draw any frame at all;
        /// the view hierarchy returned by `onCreateView` is entirely responsible
        /// for drawing the dialog.
        case noFrame = 2
        /// Like `noFrame`, but also disables all input to the dialog.
        case noInput = 3
    }
}

extension DialogFragment {
    /// Dismiss the fragment and its dialog.
    public func dismiss() {
        callVoidMethod(name: "dismiss")
    }

    /// Version of `dismiss` that uses `FragmentTransaction.commitAllowingStateLoss()`.
    public func dismissAllowingStateLoss() {
        callVoidMethod(name: "dismissAllowingStateLoss")
    }

    /// Version of `dismiss` that uses `commitNow`.
    public func dismissNow() {
        callVoidMethod(name: "dismissNow")
    }

    /// Return the Dialog this fragment is currently controlling.
    public func dialog() -> Dialog? {
        guard
            let clazz = JClass.load(Dialog.className),
            let global = callObjectMethod(
                name: "getDialog",
                returningClass: clazz
            )
        else { return nil }
        return Dialog(global)
    }

    /// Return the current value of setShowsDialog.
    public func showsDialog() -> Bool {
        callBoolMethod(name: "getShowsDialog") ?? false
    }

    /// Return the theme to use when creating the dialog.
    public func theme() -> Int32 {
        callIntMethod(name: "getTheme") ?? 0
    }

    /// Return whether the dialog is cancelable.
    public func isCancelable() -> Bool {
        callBoolMethod(name: "isCancelable") ?? false
    }

    // TODO: implement all `on` methods via native kotlin class

    // TODO: requireComponentDialog

    // TODO: requireDialog

    /// Control whether the shown Dialog is cancelable.
    ///
    /// Use this instead of directly calling `Dialog.setCancelable(boolean)`,
    /// because `DialogFragment` needs to change its behavior based on this.
    public func cancelable(_ cancelable: Bool) {
        callVoidMethod(name: "setCancelable", args: cancelable)
    }

    /// Controls whether this fragment should be shown in a dialog.
    /// If not set, no Dialog will be created and the fragment's view hierarchy will thus not be added to it. This allows you to instead use it as a normal fragment (embedded inside of its activity).
    /// 
    /// This is normally set for you based on whether the fragment
    /// is associated with a container view ID passed
    /// to `FragmentTransaction.add(int, Fragment)`.
    /// If the fragment was added with a container, `setShowsDialog`
    /// will be initialized to false; otherwise, it will be true.
    /// 
    /// If calling this manually, it should be called in `onCreate` as calling it
    /// any later will have no effect.
    public func showsDialog(_ showsDialog: Bool) {
        callVoidMethod(name: "setShowsDialog", args: showsDialog)
    }

    /// Call to customize the basic appearance and behavior of the fragment's dialog.
    /// This can be used for some common dialog behaviors,
    /// taking care of selecting flags, theme, and other options for you.
    /// The same effect can be achieve by manually setting `Dialog` and `Window`
    /// attributes yourself. Calling this after the fragment's `Dialog` is created
    /// will have no effect.
    public func style(_ style: Style, _ theme: Int32) {
        callVoidMethod(name: "setStyle", args: style.rawValue, theme)
    }

    /// Display the dialog, adding the fragment to the given FragmentManager.
    /// This is a convenience for explicitly creating a transaction,
    /// adding the fragment to it with the given tag, and committing it.
    /// This does not add the transaction to the fragment back stack.
    /// When the fragment is dismissed, a new transaction will be executed
    /// to remove it from the activity.
    public func show(_ fragmentManager: FragmentManager, _ tag: String) {
        callVoidMethod(name: "show", args: fragmentManager.signed(as: FragmentManager.className), tag)
    }

    /// Display the dialog, adding the fragment using an existing transaction
    /// and then committing the transaction.
    public func show(_ fragmentTransaction: FragmentTransaction, _ tag: String) -> Int32 {
        callIntMethod(name: "show", args: fragmentTransaction.signed(as: FragmentTransaction.className), tag) ?? -1
    }

    /// Display the dialog, immediately adding the fragment
    /// to the given FragmentManager. This is a convenience for explicitly
    /// creating a transaction, adding the fragment to it with the given tag,
    /// and calling commitNow. This does not add the transaction
    /// to the fragment back stack. When the fragment is dismissed,
    /// a new transaction will be executed to remove it from the activity.
    public func showNow(_ fragmentManager: FragmentManager, _ tag: String) {
        callVoidMethod(name: "showNow", args: fragmentManager.signed(as: FragmentManager.className), tag)
    }
}