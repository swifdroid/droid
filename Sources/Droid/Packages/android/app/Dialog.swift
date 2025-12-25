//
//  Dialog.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Base class for Dialogs.
///
/// Note: Activities provide a facility to manage the creation, saving
/// and restoring of dialogs. See `Activity.onCreateDialog(int)`,
/// `Activity.onPrepareDialog(int, Dialog)`, `Activity.showDialog(int)`,
/// and `Activity.dismissDialog(int)`. If these methods are used,
/// `getOwnerActivity()` will return the Activity that managed this dialog.
///
/// [Learn more](https://developer.android.com/reference/android/app/Dialog)
@MainActor
open class Dialog: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/app/Dialog" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Creates a dialog window that uses the default dialog theme.
    public init? (_ context: ActivityContext) {
        guard
            let clazz = JClass.load(Dialog.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"))
        else { return nil }
        self.object = global
    }

    /// Creates a dialog window that uses a custom dialog style.
    public init? (_ context: ActivityContext, _ themeResId: Int32) {
        guard
            let clazz = JClass.load(Dialog.className),
            let global = clazz.newObject(args: context.signed(as: "android/content/Context"), themeResId)
        else { return nil }
        self.object = global
    }
}

extension Dialog {
    /// Add an additional content view to the screen.
    ///
    /// Added after any existing ones in the screen – existing views are NOT removed.
    public func addContentView(_ view: View, _ lp: LayoutParams) {
        guard let view = view.instance else { return }
        callVoidMethod(name: "addContentView", args: view.signed(as: .android.view.View), lp.object.signed(as: .android.view.ViewGroup.LayoutParams))
    }

    /// Cancel the dialog.
    ///
    /// This is essentially the same as calling `dismiss()`,
    /// but it will also call your `DialogInterface.OnCancelListener` (if registered).
    public func cancel() {
        callVoidMethod(name: "cancel")
    }

    /// Close the options menu.
    public func closeOptionsMenu() {
        callVoidMethod(name: "closeOptionsMenu")
    }

    /// Forces immediate creation of the dialog.
    ///
    /// Note that you should not override this method to perform dialog creation.
    /// Rather, override `onCreate(android.os.Bundle)`.
    public func create() {
        callVoidMethod(name: "create")
    }

    /// Dismiss this dialog, removing it from the screen.
    ///
    /// This method can be invoked safely from any thread.
    /// Note that you should not override this method
    /// to do cleanup when the dialog is dismissed,
    /// instead implement that in `onStop()`.
    public func dismiss() {
        callVoidMethod(name: "dismiss")
    }

    /// Called to process generic motion events.
    ///
    /// You can override this to intercept all generic motion events
    /// before they are dispatched to the window.
    /// Be sure to call this implementation for generic motion events
    /// that should be handled normally.
    public func dispatchGenericMotionEvent(_ event: MotionEvent) -> Bool {
        callBoolMethod(name: "dispatchGenericMotionEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }

    /// Called to process key events.
    ///
    /// You can override this to intercept all generic motion events
    /// before they are dispatched to the window.
    /// Be sure to call this implementation for generic motion events
    /// that should be handled normally.
    public func dispatchKeyEvent(_ event: KeyEvent) -> Bool {
        callBoolMethod(name: "dispatchKeyEvent", args: event.signed(as: KeyEvent.className)) ?? false
    }

    /// Called to process a key shortcut event.
    ///
    /// You can override this to intercept all generic motion events
    /// before they are dispatched to the window.
    /// Be sure to call this implementation for generic motion events
    /// that should be handled normally.
    public func dispatchKeyShortcutEvent(_ event: KeyEvent) -> Bool {
        callBoolMethod(name: "dispatchKeyShortcutEvent", args: event.signed(as: KeyEvent.className)) ?? false
    }

    // TODO: dispatchPopulateAccessibilityEvent

    /// Called to process touch screen events.
    ///
    /// You can override this to intercept all generic motion events
    /// before they are dispatched to the window.
    /// Be sure to call this implementation for generic motion events
    /// that should be handled normally.
    public func dispatchTouchEvent(_ event: MotionEvent) -> Bool {
        callBoolMethod(name: "dispatchTouchEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }

    /// Called to process trackball events.
    ///
    /// You can override this to intercept all generic motion events
    /// before they are dispatched to the window.
    /// Be sure to call this implementation for generic motion events
    /// that should be handled normally.
    public func dispatchTrackballEvent(_ event: MotionEvent) -> Bool {
        callBoolMethod(name: "dispatchTrackballEvent", args: event.signed(as: MotionEvent.className)) ?? false
    }

    // TODO: findViewById

    public func getActionBar() -> ActionBar? {
        guard
            let clazz = JClass.load(ActionBar.className),
            let global = callObjectMethod(
                name: "getActionBar",
                returningClass: clazz
            )
        else { return nil }
        return ActionBar(global)
    }

    // TODO: implement Dialog methods
}