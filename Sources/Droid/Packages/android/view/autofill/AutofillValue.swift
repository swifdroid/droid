//
//  AutofillValue.swift
//  Droid
//
//  Created by Mihael Isaev on 17.09.2025.
//

#if os(Android)
import Android
#endif
import FoundationEssentials

extension AndroidPackage.ViewPackage {
    public class AutofillPackage: JClassName, @unchecked Sendable {}
    public var autofill: AutofillPackage { .init(parent: self, name: "autofill") }
}
extension AndroidPackage.ViewPackage.AutofillPackage {
    public class AutofillValueClass: JClassName, @unchecked Sendable {}
    public var AutofillValue: AutofillValueClass { .init(parent: self, name: "AutofillValue") }
}

/// Abstracts how a View can be autofilled by an [AutofillService](https://developer.android.com/reference/android/service/autofill/AutofillService).
/// 
/// Each AutofillValue is associated with a type, as defined by `View.getAutofillType()`.
///
/// [Learn more](https://developer.android.com/reference/android/view/autofill/AutofillValue)
public final class AutofillValue: JObjectable, Sendable {
    /// The JNI class name
    public static let className: JClassName = .android.view.autofill.AutofillValue
    
    /// Object wrapper
    public let object: JObject

    @discardableResult
    public init (_ object: JObject) {
        self.object = object
    }

    /// Creates a new `AutofillValue` to autofill a View representing a date.
    public static func forDate(_ date: Date) -> AutofillValue! {
        let value = Int64(date.timeIntervalSince1970 * 1000)
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.staticObjectMethod(name: "forDate", args: value, returningClass: clazz)
        else { return nil }
        return AutofillValue(global)
        #else
        return nil
        #endif
    }

    /// Creates a new `AutofillValue` to autofill a View representing a selection list.
    public static func forList(_ value: Int) -> AutofillValue! {
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.staticObjectMethod(name: "forList", args: Int32(value), returningClass: clazz)
        else { return nil }
        return AutofillValue(global)
        #else
        return nil
        #endif
    }

    /// Creates a new `AutofillValue` to autofill a View representing a text field.
    public static func forText(_ value: String) -> AutofillValue! {
        guard let value = value.wrap() else { return nil }
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.staticObjectMethod(name: "forText", args: value.signedAsCharSequence(), returningClass: clazz)
        else { return nil }
        return AutofillValue(global)
        #else
        return nil
        #endif
    }

    /// Creates a new `AutofillValue` to autofill a View representing a toggable field.
    public static func forToggle(_ value: Bool) -> AutofillValue! {
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let global = clazz.staticObjectMethod(name: "forToggle", args: value, returningClass: clazz)
        else { return nil }
        return AutofillValue(global)
        #else
        return nil
        #endif
    }

    /// Gets the value to autofill a date field.
    public func dateValue() -> Date? {
        #if os(Android)
        guard
            let time = object.callLongMethod(name: "getDateValue")
        else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        #else
        return nil
        #endif
    }

    /// Gets the value to autofill a selection list field.
    public func listValue() -> Int? {
        #if os(Android)
        guard
            let value = object.callIntMethod(name: "getListValue")
        else { return nil }
        return Int(value)
        #else
        return nil
        #endif
    }

    /// Gets the value to autofill a text field.
    public func textValue() -> String? {
        #if os(Android)
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let charSequence = object.callObjectMethod(name: "getTextValue", returningClass: returningClazz)
        else { return nil }
        return JString(charSequence).string()
        #else
        return nil
        #endif
    }

    /// Gets the value to autofill a toggable field.
    public func toggleValue() -> Bool? {
        #if os(Android)
        guard
            let value = object.callBoolMethod(name: "getToggleValue")
        else { return nil }
        return value
        #else
        return nil
        #endif
    }

    /// Checks if this is a date value.
    public func isDate() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "isDate") ?? false
        #else
        return false
        #endif
    }

    /// Checks if this is a list value.
    public func isList() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "isList") ?? false
        #else
        return false
        #endif
    }

    /// Checks if this is a text value.
    public func isText() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "isText") ?? false
        #else
        return false
        #endif
    }

    /// Checks if this is a toggle value.
    public func isToggle() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "isToggle") ?? false
        #else
        return false
        #endif
    }
}

public enum AutofillType: Int32, Sendable {
    /// Autofill type for views that cannot be autofilled.
    ///
    /// Typically used when the view is read-only; for example, a text label.
    case none = 0
    /// Autofill type for a text field, which is filled by a CharSequence.
    ///
    /// AutofillValue instances for autofilling a View can be obtained through AutofillValue.forText(CharSequence), and the value passed to autofill a View can be fetched through AutofillValue.getTextValue().
    case text = 1
    /// Autofill type for a togglable field, which is filled by a boolean.
    ///
    /// AutofillValue instances for autofilling a View can be obtained through AutofillValue.forToggle(boolean), and the value passed to autofill a View can be fetched through AutofillValue.getToggleValue().
    case toggle = 2
    /// Autofill type for a selection list field, which is filled by an int representing the element index inside the list (starting at 0).
    ///
    /// AutofillValue instances for autofilling a View can be obtained through AutofillValue.forList(int), and the value passed to autofill a View can be fetched through AutofillValue.getListValue().
    ///
    /// The available options in the selection list are typically provided by AssistStructure.ViewNode.getAutofillOptions().
    case list = 3
    /// Autofill type for a field that contains a date, which is represented by a long representing the number of milliseconds since the standard base time known as "the epoch", namely January 1, 1970, 00:00:00 GMT (see Date.getTime().
    ///
    /// AutofillValue instances for autofilling a View can be obtained through AutofillValue.forDate(long), and the values passed to autofill a View can be fetched through AutofillValue.getDateValue().
    case date = 4
}
