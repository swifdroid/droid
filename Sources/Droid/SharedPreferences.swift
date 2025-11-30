//
//  SharedPreferences.swift
//  Droid
//
//  Created by Mihael Isaev on 15.11.2025.
//

#if os(Android)
import Android
#endif

/// A class representing Android's SharedPreferences for storing key-value pairs.
public final class SharedPreferences: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "android/content/SharedPreferences" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Checks whether the preferences contains a preference.
    public func contains(key: String) -> Bool {
        callBoolMethod(name: "contains", args: key) ?? false
    }

    /// Create a new Editor for these preferences,
    /// through which you can make modifications
    /// to the data in the preferences and atomically
    /// commit those changes back to the `SharedPreferences` object.
    /// 
    /// Note that you must call Editor.commit to have any changes
    /// you perform in the Editor actually show up in the `SharedPreferences`.
    public func edit() -> Editor? {
        guard let clazz = JClass.load(Editor.className) else {
            return nil
        }
        guard let obj = callObjectMethod(name: "edit", returningClass: clazz) else {
            return nil
        }
        return Editor(obj)
    }

    // TODO: implement getAll

    /// Retrieve a boolean value from the preferences.
    public func boolean(key: String, defValue: Bool) -> Bool {
        callBoolMethod(name: "getBoolean", args: key, defValue) ?? defValue
    }

    /// Retrieve a float value from the preferences.
    public func float(key: String, defValue: Float) -> Float {
        callFloatMethod(name: "getFloat", args: key, defValue) ?? defValue
    }

    /// Retrieve an integer value from the preferences.
    public func int(key: String, defValue: Int) -> Int {
        if let value = callIntMethod(name: "getInt", args: key, Int32(defValue)) {
            return Int(value)
        }
        return defValue
    }

    /// Retrieve a long value from the preferences.
    public func long(key: String, defValue: Int64) -> Int64 {
        callLongMethod(name: "getLong", args: key, defValue) ?? defValue
    }

    /// Retrieve a string value from the preferences.
    public func string(key: String, defValue: String?) -> String? {
        guard let clazz = JClass.load(JString.className) else {
            return nil
        }
        guard let object = callObjectMethod(name: "getString", args: key, defValue, returningClass: clazz) else {
            return nil
        }
        return JString(object).string()
    }

    /// Retrieve a set of string values from the preferences.
    // public func stringSet(key: String, defValues: Set<String>?) -> Set<String>? {
    //     // Implementation goes here
    //     return defValues
    // } // TODO: implement getStringSet

    // /// Registers a callback to be invoked when a change happens to a preference.
    // public func registerOnSharedPreferenceChangeListener(listener: Any) {
    //     // Implementation goes here
    // }
    // TODO: implement registerOnSharedPreferenceChangeListener

    // /// Unregisters a previously registered callback.
    // public func unregisterOnSharedPreferenceChangeListener(listener: Any) {
    //     // Implementation goes here
    // }
    // TODO: implement unregisterOnSharedPreferenceChangeListener
}

extension SharedPreferences {
    public final class Editor: JObjectable, @unchecked Sendable {
        public class var className: JClassName { "android/content/SharedPreferences$Editor" }
        
        /// JNI Object
        public let object: JObject
        
        /// Base Droid constructor with existing JNI object
        public init (_ object: JObject) {
            self.object = object
        }

        /// Creates an empty intent.
        public init? (_ env: JEnv? = nil) {
            #if os(Android)
            InnerLog.t("SharedPreferences.Editor init 1")
            guard let env = env ?? JEnv.current() else {
                InnerLog.e("SharedPreferences.Editor init 1.1 exit")
                return nil
            }
            InnerLog.t("SharedPreferences.Editor init 2")
            guard
                let clazz = JClass.load(Editor.className)
            else {
                InnerLog.e("SharedPreferences.Editor init 2.1 exit")
                return nil
            }
            InnerLog.t("SharedPreferences.Editor init 3")
            guard
                let global = clazz.newObject(env)
            else {
                InnerLog.e("SharedPreferences.Editor init 3.1 exit")
                return nil
            }
            InnerLog.t("SharedPreferences.Editor init 4")
            self.object = global
            #else
            return nil
            #endif
        }

        /// Commit your preferences changes back from this Editor to the `SharedPreferences` object it is editing.
        /// 
        /// This atomically performs the requested modifications, replacing whatever is currently in the `SharedPreferences`.
        ///
        /// Note that when two editors are modifying preferences at the same time, the last one to call apply wins.
        ///
        /// Unlike `commit()`, which writes its preferences out to persistent storage synchronously,
        /// `apply()` commits its changes to the in-memory `SharedPreferences` immediately
        /// but starts an asynchronous commit to disk and you won't be notified of any failures.
        /// 
        /// If another editor on this `SharedPreferences` does a regular `commit()`
        /// while a `apply()` is still outstanding, the `commit()` will block
        /// until all async commits are completed as well as the commit itself.
        ///
        /// As `SharedPreferences` instances are singletons within a process,
        /// it's safe to replace any instance of `commit()` with `apply()`
        /// if you were already ignoring the return value.
        ///
        /// You don't need to worry about Android component lifecycles
        /// and their interaction with `apply()` writing to disk.
        /// The framework makes sure in-flight disk writes from `apply()` complete before switching states.
        public func apply() {
            callVoidMethod(name: "apply")
        }

        /// Mark in the editor to remove all values from the preferences.
        /// Once commit is called, the only remaining preferences will be any that you have defined in this editor.
        ///
        /// Note that when committing back to the preferences, the clear is done first,
        /// regardless of whether you called clear before or after put methods on this editor.
        @discardableResult
        public func clear() -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "clear", returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Commit your preferences changes back
        /// from this `Editor` to the `SharedPreferences` object it is editing.
        /// This atomically performs the requested modifications,
        /// replacing whatever is currently in the SharedPreferences.
        ///
        /// Note that when two editors are modifying preferences
        /// at the same time, the last one to call commit wins.
        ///
        /// If you don't care about the return value and you're using this
        /// from your application's main thread, consider using `apply()` instead.
        public func commit() -> Bool {
            callBoolMethod(name: "commit") ?? false
        }

        /// Set a boolean value in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        @discardableResult
        public func boolean(key: String, value: Bool) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "putBoolean", args: key, value, returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Set a float value in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        @discardableResult
        public func float(key: String, value: Float) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "putFloat", args: key, value, returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Set an integer value in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        @discardableResult
        public func int(key: String, value: Int) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "putInt", args: key, Int32(value), returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Set a long value in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        @discardableResult
        public func long(key: String, value: Int64) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "putLong", args: key, value, returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Set a string value in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        @discardableResult
        public func string(key: String, value: String?) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "putString", args: key, value, returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }

        /// Set a set of string values in the preferences editor,
        /// to be written back once `commit()` or `apply()` are called.
        // @discardableResult
        // public func stringSet(key: String, values: Set<String>?) -> Editor? {
        //     // Implementation goes here
        //     return nil
        // } // TODO: implement putStringSet

        /// Mark in the editor that a preference value should be removed,
        /// which will be done in the actual preferences once `commit()` is called.
        ///
        /// Note that when committing back to the preferences, all removals are done first,
        /// regardless of whether you called remove before or after put methods on this editor.
        @discardableResult
        public func remove(key: String) -> Editor? {
            guard let clazz = JClass.load(Editor.className) else {
                return nil
            }
            guard let object = callObjectMethod(name: "remove", args: key, returningClass: clazz) else {
                return nil
            }
            return Editor(object)
        }
    }
}