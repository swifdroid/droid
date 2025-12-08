//
//  EditText.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class EditTextClass: JClassName, @unchecked Sendable {}
    public var EditText: EditTextClass { .init(parent: self, name: "EditText") }
}

/// A user interface element for entering and modifying text.
///
/// [Learn more](https://developer.android.com/reference/android/widget/EditText)
open class EditText: TextView, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.EditText }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init<S>(id: Int32? = nil, _ state: S) where S: StateValuable, S.Value == String {
        super.init(id: id)
        self.text(state)
        self.textChangedListener(
            beforeTextChanged: { _ in },
            onTextChanged: { event in
                guard let str = event.p0 else { return }
                state.stateValue?.wrappedValue = str
            },
            afterTextChanged: { _ in }
        )
    }
    
    func addTextChangedListener(_ textWatcher: JClass) {
        // callVoidWithMethod("addTextChangedListener", .object(.android.text.TextWatcher) / textWatcher)
    }
}

// MARK: - Methods

// MARK: ExtendSelection

extension EditText {
    /// Extends the selection to the specified offset.
    ///
    /// Moves the selection anchor to the specified offset, extending the selection from its current position.
    ///
    /// - Parameter offset: The new offset for the selection anchor.
    ///
    /// [Learn more](https://developer.android.com/reference/android/widget/EditText#extendSelection(int))
    @discardableResult
    public func extendSelection(index: Int) -> Self {
        instance?.callVoidMethod(name: "extendSelection", args: Int32(index))
        return self
    }
}

// MARK: GetAccessibilityClassName

extension EditText {
    /// Returns the class name of the accessibility node info.
    @discardableResult
    public func getAccessibilityClassName() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let value = instance?.callObjectMethod(name: "getAccessibilityClassName", returningClass: returningClazz)
        else { return nil }
        return JString(value).string()
    }
}

// MARK: GetFreezesText

extension EditText {
    /// Return whether this text view is including its entire text contents in frozen icicles. 
    @discardableResult
    public func getFreezesText() -> Bool {
        instance?.callBoolMethod(name: "getFreezesText") ?? false
    }
}

// TODO: getText: implement Editable https://developer.android.com/reference/android/text/Editable

// MARK: IsStyleShortcutEnabled

extension EditText {
    /// Return true if style shortcut is enabled, otherwise returns false.
    @discardableResult
    public func isStyleShortcutEnabled() -> Bool {
        instance?.callBoolMethod(name: "isStyleShortcutEnabled") ?? false
    }
}

// TODO: onKeyShortcut: implement native wrapper
// TODO: onTextContextMenuItem

// MARK: SelectAll

extension EditText {
    /// Selects all the text in the EditText.
    public func selectAll() {
        instance?.callVoidMethod(name: "selectAll")
    }
}

// TODO: setEllipsize: implement TextUtils.TruncateAt https://developer.android.com/reference/android/text/TextUtils.TruncateAt

// MARK: SetSelection

extension EditText {
    /// Sets the selection to the specified offset.
    ///
    /// Moves the selection anchor to the specified offset.
    public func setSelection(index: Int) {
        instance?.callVoidMethod(name: "setSelection", args: Int32(index))
    }

    /// Sets the selection to the specified range.
    public func setSelection(start: Int, end: Int) {
        instance?.callVoidMethod(name: "setSelection", args: Int32(start), Int32(end))
    }
}

// MARK: SetStyleShortcutsEnabled

extension EditText {
    /// Enables style shortcuts, e.g. Ctrl+B for making text bold.
    @discardableResult
    public func setStyleShortcutsEnabled(_ enabled: Bool = true) -> Self {
        instance?.callVoidMethod(name: "setStyleShortcutsEnabled", args: enabled)
        return self
    }
}