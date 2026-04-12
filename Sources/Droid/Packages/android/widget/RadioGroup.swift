//
//  RadioGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RadioGroupClass: JClassName, @unchecked Sendable {}
    public class RadioGroupOnCheckedChangeListenerClass: JClassName, @unchecked Sendable {}
    public var RadioGroup: RadioGroupClass { .init(parent: self, name: "RadioGroup") }
    public var RadioGroupOnCheckedChangeListener: RadioGroupOnCheckedChangeListenerClass { .init(parent: self, name: "RadioGroup$OnCheckedChangeListener") }
}

/// A wrapper for `android.widget.RadioGroup`.
///
/// [Learn more](https://developer.android.com/reference/android/widget/RadioGroup)
open class RadioGroup: LinearLayout {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.RadioGroup }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// MARK: AddView

extension RadioGroup {
    /// Adds a child view at the specified index with layout params.
    public func addView(_ child: View, _ index: Int, _ params: LayoutParams) {
        instance?.callVoidMethod(
            name: "addView",
            args: child.signed(as: View.className), Int32(index), params.signed(as: .android.view.ViewGroup.LayoutParams)
        )
    }
}

// MARK: Check

extension RadioGroup {
    /// Sets the selection to the radio button whose identifier is passed in parameter.
    public func check(_ id: Int) {
        instance?.callVoidMethod(name: "check", args: Int32(id))
    }
}

// MARK: ClearCheck

extension RadioGroup {
    /// Clears the selection.
    public func clearCheck() {
        instance?.callVoidMethod(name: "clearCheck")
    }
}

// MARK: GetCheckedRadioButtonId

extension RadioGroup {
    /// Returns the identifier of the selected radio button.
    public func checkedRadioButtonId() -> Int {
        Int(instance?.callIntMethod(name: "getCheckedRadioButtonId") ?? -1)
    }
}

// MARK: OnFinishInflate

extension RadioGroup {
    /// Called after a view and all of its children has been inflated from XML.
    public func onFinishInflate() {
        instance?.callVoidMethod(name: "onFinishInflate")
    }
}

// MARK: Autofill

extension RadioGroup {
    /// Autofills this view with the value provided.
    public func autofill(_ value: JObject?) {
        instance?.callVoidMethod(name: "autofill", args: value?.signed(as: "android/view/autofill/AutofillValue"))
    }
}

// MARK: CheckLayoutParams

extension RadioGroup {
    /// Returns `true` if the supplied layout parameters are valid for this layout.
    public func checkLayoutParams(_ params: LayoutParams?) -> Bool {
        instance?.callBoolMethod(
            name: "checkLayoutParams",
            args: params?.signed(as: .android.view.ViewGroup.LayoutParams)
        ) ?? false
    }
}

// MARK: GenerateDefaultLayoutParams

extension RadioGroup {
    /// Returns a set of default layout parameters for children of this layout.
    public func generateDefaultLayoutParams() -> LayoutParams? {
        guard
            let returningClazz = JClass.load(.android.view.ViewGroup.LayoutParams),
            let global = instance?.callObjectMethod(name: "generateDefaultLayoutParams", returningClass: returningClazz)
        else { return nil }
        return LayoutParams(global)
    }
}

// MARK: GenerateLayoutParams

extension RadioGroup {
    /// Returns a safe copy of the supplied layout parameters.
    public func generateLayoutParams(_ params: JObject?) -> LayoutParams? {
        guard
            let returningClazz = JClass.load(.android.view.ViewGroup.LayoutParams),
            let global = instance?.callObjectMethod(
                name: "generateLayoutParams",
                args: params?.signed(as: .android.view.ViewGroup.LayoutParams),
                returningClass: returningClazz
            )
        else { return nil }
        return LayoutParams(global)
    }
}

// MARK: GetAutofillType

extension RadioGroup {
    /// Returns the type of value that can be autofilled in this view.
    public func autofillType() -> Int {
        Int(instance?.callIntMethod(name: "getAutofillType") ?? 0)
    }
}

// MARK: GetAutofillValue

extension RadioGroup {
    /// Returns the current value for autofill purposes.
    public func autofillValue() -> JObject? {
        guard
            let returningClazz = JClass.load("android/view/autofill/AutofillValue"),
            let global = instance?.callObjectMethod(name: "getAutofillValue", returningClass: returningClazz)
        else { return nil }
        return global
    }
}

// MARK: OnInitializeAccessibilityNodeInfo

extension RadioGroup {
    /// Initializes accessibility node info for this view.
    public func onInitializeAccessibilityNodeInfo(_ info: JObject?) {
        instance?.callVoidMethod(
            name: "onInitializeAccessibilityNodeInfo",
            args: info?.signed(as: "android/view/accessibility/AccessibilityNodeInfo")
        )
    }
}

// MARK: OnProvideStructure

extension RadioGroup {
    /// Called when assist data is requested.
    public func onProvideStructure(_ structure: JObject?) {
        instance?.callVoidMethod(
            name: "onProvideStructure",
            args: structure?.signed(as: "android/view/ViewStructure")
        )
    }
}

// MARK: SetOnCheckedChangeListener

struct RadioGroupOnCheckedChangeListenerViewProperty<T: JObjectable>: ViewPropertyToApply {
    let key: ViewPropertyKey = "setOnCheckedChangeListener"
    let value: T?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(
            env,
            name: key.rawValue,
            args: value?.signed(as: .android.widget.RadioGroupOnCheckedChangeListener)
        )
    }
}

extension RadioGroup {
    /// Registers a callback to be invoked when the checked radio button changes.
    @discardableResult
    public func onCheckedChangeListener<T: JObjectable>(_ listener: T?) -> Self {
        RadioGroupOnCheckedChangeListenerViewProperty(value: listener).applyOrAppend(nil, self)
    }
}

// MARK: SetOnHierarchyChangeListener

struct RadioGroupHierarchyChangeListenerViewProperty<T: JObjectable>: ViewPropertyToApply {
    let key: ViewPropertyKey = "setOnHierarchyChangeListener"
    let value: T?
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(
            env,
            name: key.rawValue,
            args: value?.signed(as: "android/view/ViewGroup$OnHierarchyChangeListener")
        )
    }
}

extension RadioGroup {
    /// Sets a listener to receive hierarchy change events.
    @discardableResult
    public func onHierarchyChangeListener<T: JObjectable>(_ listener: T?) -> Self {
        RadioGroupHierarchyChangeListenerViewProperty(value: listener).applyOrAppend(nil, self)
    }
}
