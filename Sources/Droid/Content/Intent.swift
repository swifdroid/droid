//
//  Intent.swift
//  Droid
//
//  Created by Mihael Isaev on 25.10.2025.
//

/// It is an abstract description of an operation to be performed.
/// It can be used with `startActivity` to launch an `Activity`, `startService`
/// (or `startForegroundService`) to communicate with a `Service`, and
/// `sendBroadcast` to send a broadcast.
/// 
/// [Learn more](https://developer.android.com/reference/android/content/Intent.html)
@MainActor
public final class Intent: JObjectable, @unchecked Sendable {
    public class var className: JClassName { .init(stringLiteral: "android/content/Intent") }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    /// Creates an empty intent.
    public init? (_ env: JEnv? = nil) {
        #if os(Android)
        InnerLog.t("Intent init 1")
        guard let env = env ?? JEnv.current() else {
            InnerLog.e("Intent init 1.1 exit")
            return nil
        }
        InnerLog.t("Intent init 2")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent init 2.1 exit")
            return nil
        }
        InnerLog.t("Intent init 3")
        guard
            let global = intentClazz.newObject(env)
        else {
            InnerLog.e("Intent init 3.1 exit")
            return nil
        }
        InnerLog.t("Intent init 4")
        self.object = global
        #else
        return nil
        #endif
    }

    /// Creates an intent for a specific component.
    public init? (_ env: JEnv? = nil, className: JClassName) {
        #if os(Android)
        InnerLog.t("Intent init 1")
        guard let env = env ?? JEnv.current() else {
            InnerLog.e("Intent init 1.1 exit")
            return nil
        }
        InnerLog.t("Intent init 2")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent init 2.1 exit")
            return nil
        }
        InnerLog.t("Intent init 3 intentClazz: \(intentClazz.ref)")
        guard
            let activityClazz = JClass.load(className)
        else {
            InnerLog.e("Intent init 3.1 exit")
            return nil
        }
        InnerLog.t("Intent init 4 activityClazz: \(activityClazz.ref)")
        // TODO: migrate to intentClazz.newObject(env, args: ... )
        guard
            let methodId = intentClazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), .object(.java.lang.Class), returning: .void))
        else {
            InnerLog.e("Intent init 4.1 exit")
            return nil
        }
        InnerLog.t("Intent init 5")
        guard
            let global = env.newObject(clazz: intentClazz, constructor: methodId, args: [AppContext.shared.object, activityClazz])
        else {
            InnerLog.e("Intent init 5.1 exit")
            return nil
        }
        InnerLog.t("Intent init 5")
        self.object = global
        #else
        return nil
        #endif
    }

    /// Creates an intent with a given action.
    public init? (_ env: JEnv? = nil, _ action: IntentActionType) {
        #if os(Android)
        InnerLog.t("Intent init 1")
        guard let env = env ?? JEnv.current() else {
            InnerLog.e("Intent init 1.1 exit")
            return nil
        }
        InnerLog.t("Intent init 2")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent init 2.1 exit")
            return nil
        }
        InnerLog.t("Intent init 3")
        guard
            let global = intentClazz.newObject(env, args: action.value)
        else {
            InnerLog.e("Intent init 3.1 exit")
            return nil
        }
        
        InnerLog.t("Intent init 4")
        self.object = global
        #else
        return nil
        #endif
    }

    /// Creates an intent with a given action and for a given data url.
    public init? (_ env: JEnv? = nil, _ action: IntentActionType, _ url: String) {
        #if os(Android)
        InnerLog.t("Intent init 1")
        guard let env = env ?? JEnv.current() else {
            InnerLog.e("Intent init 1.1 exit")
            return nil
        }
        InnerLog.t("Intent init 2")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent init 2.1 exit")
            return nil
        }
        InnerLog.t("Intent init 3")
        guard
            let uri = Uri.parse(url)
        else {
            InnerLog.e("Intent init 3.1 exit")
            return nil
        }
        InnerLog.t("Intent init 4")
        guard
            let global = intentClazz.newObject(env, args: action.value, uri.signed(as: Uri.className))
        else {
            InnerLog.e("Intent init 4.1 exit")
            return nil
        }
        InnerLog.t("Intent init 5")
        self.object = global
        #else
        return nil
        #endif
    }

    /// Add a new category to the intent.
    ///
    /// Categories provide additional detail about the action the intent performs.
    ///
    /// When resolving an intent, only activities that provide all of the requested categories will be used.
    ///
    /// [Learn more](https://developer.android.com/reference/android/content/Intent#addCategory(java.lang.String))
    public func category(_ category: IntentCategoryType) -> Intent? {
        #if os(Android)
        InnerLog.t("Intent category 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent category 1.1 exit")
            return nil
        }
        InnerLog.t("Intent category 2")
        _ = object.callObjectMethod(name: "addCategory", args: category.value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Add additional flags to the intent (or with existing flags value).
    /// 
    /// [Learn more](https://developer.android.com/reference/android/content/Intent#addFlags(int))
    public func flags(_ flags: Int32) -> Intent? { // TODO: pass all possible flags and their combinations
        #if os(Android)
        InnerLog.t("Intent flags 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent flags 1.1 exit")
            return nil
        }
        InnerLog.t("Intent flags 2")
        _ = object.callObjectMethod(name: "addFlags", args: flags, returningClass: intentClazz)
        #endif
        return self
    }

    // TODO: implement createChooser

    // TODO: implement describeContents

    // TODO: implement fillIn

    /// Retrieves the general action to be performed.
    public func getAction() -> IntentActionType? {
        #if os(Android)
        InnerLog.t("Intent getAction 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let actionObject = object.callObjectMethod(name: "getAction", returningClass: stringClazz),
            let actionString = JString(actionObject).string()
        else {
            InnerLog.e("Intent getAction 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getAction 2")
        return IntentActionType(stringLiteral: actionString)
        #else
        return nil
        #endif
    }

    /// Retrieve extended data from the intent.
    public func getBooleanArrayExtra(_ name: String) -> [Bool]? {
        #if os(Android)
        InnerLog.t("Intent getAction 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JBoolArray.className),
            let rawObject = object.callObjectMethod(name: "getBooleanArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getAction 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getAction 2")
        return JBoolArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getBooleanExtra(_ name: String, _ defaultValue: Bool) -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "getBooleanExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getBundleExtra(_ name: String) -> Bundle? {
        #if os(Android)
        InnerLog.t("Intent getBundleExtra 1")
        guard
            let bundleClazz = JClass.load(Bundle.className),
            let rawObject = object.callObjectMethod(name: "getBundleExtra", args: name, returningClass: bundleClazz)
        else {
            InnerLog.e("Intent getBundleExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getBundleExtra 2")
        return Bundle(rawObject)
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getByteArrayExtra(_ name: String) -> [Int8]? {
        #if os(Android)
        InnerLog.t("Intent getByteArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JByteArray.className),
            let rawObject = object.callObjectMethod(name: "getByteArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getByteArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getByteArrayExtra 2")
        return JByteArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getByteExtra(_ name: String, _ defaultValue: Int8) -> Int8 {
        #if os(Android)
        return object.callByteMethod(name: "getByteExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    // TODO: implement getCategories

    /// Retrieves extended data from the intent.
    public func getCharArrayExtra(_ name: String) -> [UInt16]? {
        #if os(Android)
        InnerLog.t("Intent getCharArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JCharArray.className),
            let rawObject = object.callObjectMethod(name: "getCharArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getCharArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getCharArrayExtra 2")
        return JCharArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getCharExtra(_ name: String, _ defaultValue: UInt16) -> UInt16 {
        #if os(Android)
        return object.callCharMethod(name: "getCharExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    // TODO: implement getCharSequenceArrayExtra
    // TODO: implement getCharSequenceArrayListExtra
    // TODO: implement getCharSequenceExtra
    
    /// Return the `ClipData` associated with this Intent.
    @MainActor
    public func getClipData() -> ClipData? {
        #if os(Android)
        InnerLog.t("Intent getClipData 1")
        guard
            let clipDataClazz = JClass.load(ClipData.className),
            let rawObject = object.callObjectMethod(name: "getClipData", returningClass: clipDataClazz)
        else {
            InnerLog.e("Intent getClipData 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getClipData 2")
        return ClipData(rawObject)
        #else
        return nil
        #endif
    }

    // TODO: implement getComponent

    /// Retrieve data this intent is operating on. This URI specifies the name of the data;
    /// often it uses the content: scheme, specifying data in a content provider.
    /// 
    /// Other schemes may be handled by specific activities, such as http: by the web browser.
    public func getData() -> Uri? {
        #if os(Android)
        InnerLog.t("Intent getData 1")
        guard
            let uriClazz = JClass.load(Uri.className),
            let rawObject = object.callObjectMethod(name: "getData", returningClass: uriClazz)
        else {
            InnerLog.e("Intent getData 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getData 2")
        return Uri(rawObject)
        #else
        return nil
        #endif
    }

    /// The same as `getData()``, but returns the `Uri` as an encoded `String`.
    public func getDataString() -> String? {
        #if os(Android)
        InnerLog.t("Intent getDataString 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let dataObject = object.callObjectMethod(name: "getDataString", returningClass: stringClazz),
            let dataString = JString(dataObject).string()
        else {
            InnerLog.e("Intent getDataString 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getDataString 2")
        return dataString
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getDoubleArrayExtra(_ name: String) -> [Double]? {
        #if os(Android)
        InnerLog.t("Intent getDoubleArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JDoubleArray.className),
            let rawObject = object.callObjectMethod(name: "getDoubleArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getDoubleArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getDoubleArrayExtra 2")
        return JDoubleArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getDoubleExtra(_ name: String, _ defaultValue: Double) -> Double {
        #if os(Android)
        return object.callDoubleMethod(name: "getDoubleExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    // TODO: implement getExtras

    // TODO: implement getFlags

    /// Retrieves extended data from the intent.
    public func getFloatArrayExtra(_ name: String) -> [Float]? {
        #if os(Android)
        InnerLog.t("Intent getFloatArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JFloatArray.className),
            let rawObject = object.callObjectMethod(name: "getFloatArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getFloatArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getFloatArrayExtra 2")
        return JFloatArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getFloatExtra(_ name: String, _ defaultValue: Float) -> Float {
        #if os(Android)
        return object.callFloatMethod(name: "getFloatExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    /// Retrieves the identifier for this Intent.
    /// 
    /// If non-null, this is an arbitrary identity of the Intent to distinguish it from other Intents.
    public func getIdentifier() -> String? {
        #if os(Android)
        InnerLog.t("Intent getIdentifier 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let dataObject = object.callObjectMethod(name: "getIdentifier", returningClass: stringClazz),
            let dataString = JString(dataObject).string()
        else {
            InnerLog.e("Intent getIdentifier 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getIdentifier 2")
        return dataString
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getIntArrayExtra(_ name: String) -> [Int32]? {
        #if os(Android)
        InnerLog.t("Intent getIntArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JIntArray.className),
            let rawObject = object.callObjectMethod(name: "getIntArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getIntArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getIntArrayExtra 2")
        return JIntArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getIntExtra(_ name: String, _ defaultValue: Int32) -> Int32 {
        #if os(Android)
        return object.callIntMethod(name: "getIntExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    // TODO: getIntegerArrayListExtra

    /// Retrieves extended data from the intent.
    public func getLongArrayExtra(_ name: String) -> [Int64]? {
        #if os(Android)
        InnerLog.t("Intent getLongArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JLongArray.className),
            let rawObject = object.callObjectMethod(name: "getLongArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getLongArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getLongArrayExtra 2")
        return JLongArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getLongExtra(_ name: String, _ defaultValue: Int64) -> Int64 {
        #if os(Android)
        return object.callLongMethod(name: "getLongExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }
    
    /// Retrieves the application package name this Intent is limited to.
    /// 
    /// When resolving an Intent, if non-null this limits the resolution to only components in the given application package.
    public func getPackage() -> String? {
        #if os(Android)
        InnerLog.t("Intent getPackage 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let packageObject = object.callObjectMethod(name: "getPackage", returningClass: stringClazz),
            let packageString = JString(packageObject).string()
        else {
            InnerLog.e("Intent getPackage 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getPackage 2")
        return packageString
        #else
        return nil
        #endif
    }

    /// Return the scheme portion of the intent's data.
    /// 
    /// If the data is null or does not include a scheme, null is returned.
    /// 
    /// Otherwise, the scheme prefix without the final ':' is returned, i.e. "http".
    /// 
    /// This is the same as calling getData().getScheme() (and checking for null data).
    public func getScheme() -> String? {
        #if os(Android)
        InnerLog.t("Intent getScheme 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let schemeObject = object.callObjectMethod(name: "getScheme", returningClass: stringClazz),
            let schemeString = JString(schemeObject).string()
        else {
            InnerLog.e("Intent getScheme 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getScheme 2")
        return schemeString
        #else
        return nil
        #endif
    }

    // TODO: implement getSelector

    /// Retrieves extended data from the intent.
    public func getShortArrayExtra(_ name: String) -> [Int16]? {
        #if os(Android)
        InnerLog.t("Intent getShortArrayExtra 1")
        guard
            let env = JEnv.current(),
            let stringClazz = JClass.load(JShortArray.className),
            let rawObject = object.callObjectMethod(name: "getShortArrayExtra", args: name, returningClass: stringClazz)
        else {
            InnerLog.e("Intent getShortArrayExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getShortArrayExtra 2")
        return JShortArray(env, rawObject).toArray()
        #else
        return nil
        #endif
    }

    /// Retrieves extended data from the intent.
    public func getShortExtra(_ name: String, _ defaultValue: Int16) -> Int16 {
        #if os(Android)
        return object.callShortMethod(name: "getShortExtra", args: name) ?? defaultValue
        #else
        return defaultValue
        #endif
    }

    /// Get the bounds of the sender of this intent, in screen coordinates.
    /// 
    /// This can be used as a hint to the receiver for animations and the like.
    /// 
    /// Null means that there is no source bounds.
    @MainActor
    public func getSourceBounds() -> Rect? {
        #if os(Android)
        InnerLog.t("Intent getSourceBounds 1")
        guard
            let rectClazz = JClass.load(Rect.className),
            let rawObject = object.callObjectMethod(name: "getSourceBounds", returningClass: rectClazz)
        else {
            InnerLog.e("Intent getSourceBounds 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getSourceBounds 2")
        return Rect(rawObject)
        #else
        return nil
        #endif
    }

    // TODO: implement getStringArrayExtra

    /// Retrieves extended data from the intent.
    public func getStringExtra(_ name: String) -> String? {
        #if os(Android)
        InnerLog.t("Intent getStringExtra 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let stringObject = object.callObjectMethod(name: "getStringExtra", args: name, returningClass: stringClazz),
            let stringValue = JString(stringObject).string()
        else {
            InnerLog.e("Intent getStringExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getStringExtra 2")
        return stringValue
        #else
        return nil
        #endif
    }

    /// Retrieve any explicit MIME type included in the intent.
    /// 
    /// This is usually null, as the type is determined by the intent data.
    public func getType() -> String? {
        #if os(Android)
        InnerLog.t("Intent getType 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let typeObject = object.callObjectMethod(name: "getType", returningClass: stringClazz),
            let typeString = JString(typeObject).string()
        else {
            InnerLog.e("Intent getType 1.1 exit")
            return nil
        }
        InnerLog.t("Intent getType 2")
        return typeString
        #else
        return nil
        #endif
    }

    /// Check if a category exists in the intent.
    public func hasCategory(_ category: IntentCategoryType) -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "hasCategory", args: category.value) ?? false
        #else
        return false
        #endif
    }

    /// Returns true if an extra value is associated with the given name.
    public func hasExtra(_ name: String) -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "hasExtra", args: name) ?? false
        #else
        return false
        #endif
    }

    /// Returns true if the Intent's extras contain a parcelled file descriptor.
    public func hasFileDescriptors() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "hasFileDescriptors") ?? false
        #else
        return false
        #endif
    }

    /// Whether the intent mismatches all intent filters declared in the receiving component.
    public func isMismatchingFilter() -> Bool {
        #if os(Android)
        return object.callBoolMethod(name: "isMismatchingFilter") ?? false
        #else
        return false
        #endif
    }

    // TODO: implement makeMainActivity
    // TODO: implement makeMainSelectorActivity
    // TODO: implement makeRestartActivityTask
    // TODO: implement normalizeMimeType

    // TODO: implement parseUri

    // TODO: implement putCharSequenceArrayListExtra

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Bool]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra BoolArray 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra BoolArray 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra BoolArray 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Bool) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Bool 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Bool 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Bool 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Int8]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int8Array 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int8Array 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int8Array 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Int8) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int8 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int8 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int8 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Int16]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int16Array 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int16Array 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int16Array 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Int16) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int16 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int16 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int16 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Int32]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int32Array 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int32Array 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int32Array 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Int32) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int32 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int32 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int32 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Int64]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra BoolArray 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int64Array 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int64Array 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Int64) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Int64 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Int64 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Int64 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [UInt16]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra UInt16Array 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra UInt16Array 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra UInt16Array 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: UInt16) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra UInt16 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra UInt16 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra UInt16 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Double]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra DoubleArray 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra DoubleArray 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra DoubleArray 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Double) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Double 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Double 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Double 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: [Float]) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra FloatArray 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra FloatArray 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra FloatArray 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: Float) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra Float 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra Float 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra Float 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Adds extended data to the intent.
    public func putExtra(_ name: String, _ value: String) -> Self {
        #if os(Android)
        InnerLog.t("Intent putExtra String 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent putExtra String 1.1 exit")
            return self
        }
        InnerLog.t("Intent putExtra String 2")
        _ = object.callObjectMethod(name: "putExtra", args: name, value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Removes a category from the intent.
    public func removeCategory(_ category: IntentCategoryType) -> Intent? {
        #if os(Android)
        InnerLog.t("Intent removeCategory 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent removeCategory 1.1 exit")
            return nil
        }
        InnerLog.t("Intent removeCategory 2")
        _ = object.callObjectMethod(name: "removeCategory", args: category.value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Remove extended data from the intent.
    public func removeExtra(_ name: String) -> Intent? {
        #if os(Android)
        InnerLog.t("Intent removeExtra 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent removeExtra 1.1 exit")
            return nil
        }
        InnerLog.t("Intent removeExtra 2")
        _ = object.callObjectMethod(name: "removeExtra", args: name, returningClass: intentClazz)
        #endif
        return self
    }

    /// Remove flags from the intent.
    public func removeFlags(_ flags: Int32) -> Intent? {
        #if os(Android)
        InnerLog.t("Intent removeFlags 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent removeFlags 1.1 exit")
            return nil
        }
        InnerLog.t("Intent removeFlags 2")
        _ = object.callObjectMethod(name: "removeFlags", args: flags, returningClass: intentClazz)
        #endif
        return self
    }

    /// When an intent comes from another app or component as an embedded extra intent,
    /// the system creates a token to identify the creator of this foreign intent.
    /// 
    /// If this token is missing or invalid, the system will block the launch of this intent.
    /// 
    /// If it contains a valid token, the system will perform verification against the creator to block launching target
    /// it has no permission to launch or block it from granting URI access to the tagert it cannot access.
    /// 
    /// This method provides a way to opt out this feature.
    public func removeLaunchSecurityProtection() {
        #if os(Android)
        object.callVoidMethod(name: "removeLaunchSecurityProtection")
        #endif
    }
    
    /// Set the general action to be performed.
    public func action(_ action: IntentActionType) -> Self {
        #if os(Android)
        InnerLog.t("Intent setAction 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setAction 1.1 exit")
            return self
        }
        InnerLog.t("Intent setAction 2")
        _ = object.callObjectMethod(name: "setAction", args: action.value, returningClass: intentClazz)
        #endif
        return self
    }

    /// Convenience for calling `setComponent(android.content.ComponentName)`
    /// with the name returned by a `Class` object.
    // TODO: implement setClass
    // public func setClass(_ packageContext: Contextable, _ class: JClass) -> Self {
    
    /// Convenience for calling `setComponent(ComponentName)` with an explicit application package name and class name.
    public func className(_ packageContext: String, _ className: String) -> Self {
        #if os(Android)
        InnerLog.t("Intent setClassName 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setClassName 1.1 exit")
            return self
        }
        InnerLog.t("Intent setClassName 2")
        _ = object.callObjectMethod(name: "setClassName", args: packageContext, className, returningClass: intentClazz)
        #endif
        return self
    }

    /// Set a ClipData associated with this Intent.
    /// 
    /// This replaces any previously set ClipData.
    public func clipData(_ clip: ClipData) -> Self {
        #if os(Android)
        InnerLog.t("Intent setClipData 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setClipData 1.1 exit")
            return self
        }
        InnerLog.t("Intent setClipData 2")
        _ = object.callObjectMethod(name: "setClipData", args: clip.object, returningClass: intentClazz)
        #endif
        return self
    }

    // TODO: implement setComponent

    /// Set the data this intent is operating on.
    public func data(_ uri: Uri, normalize: Bool = false) -> Self {
        #if os(Android)
        InnerLog.t("Intent setData 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setData 1.1 exit")
            return self
        }
        InnerLog.t("Intent setData 2")
        _ = object.callObjectMethod(name: normalize ? "setDataAndNormalize" : "setData", args: uri.object, returningClass: intentClazz)
        #endif
        return self
    }

    /// (Usually optional) Set the data for the intent along with an explicit MIME data type.
    /// 
    /// This method should very rarely be used – it allows you to override the MIME type
    /// that would ordinarily be inferred from the data with your own type given here.
    public func setDataAndType(_ uri: Uri, _ type: String, normalize: Bool = false) -> Self {
        #if os(Android)
        InnerLog.t("Intent setDataAndType 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setDataAndType 1.1 exit")
            return self
        }
        InnerLog.t("Intent setDataAndType 2")
        _ = object.callObjectMethod(name: normalize ? "setDataAndTypeAndNormalize" : "setDataAndType", args: uri.object, type, returningClass: intentClazz)
        #endif
        return self
    }

    /// Set special flags controlling how this intent is handled.
    public func flags(_ flags: Int32) -> Self {
        #if os(Android)
        InnerLog.t("Intent setFlags 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setFlags 1.1 exit")
            return self
        }
        InnerLog.t("Intent setFlags 2")
        _ = object.callObjectMethod(name: "setFlags", args: flags, returningClass: intentClazz)
        #endif
        return self
    }

    /// Sets the identifier for this Intent.
    public func identifier(_ id: String) -> Self {
        #if os(Android)
        InnerLog.t("Intent setIdentifier 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setIdentifier 1.1 exit")
            return self
        }
        InnerLog.t("Intent setIdentifier 2")
        _ = object.callObjectMethod(name: "setIdentifier", args: id, returningClass: intentClazz)
        #endif
        return self
    }

    /// (Usually optional) Set an explicit application package name that limits the components this Intent will resolve to.
    ///
    /// If left to the default value of null, all components in all applications will considered.
    ///
    /// If non-null, the Intent can only match the components in the given application package.
    public func package(_ packageName: String) -> Self {
        #if os(Android)
        InnerLog.t("Intent setPackage 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setPackage 1.1 exit")
            return self
        }
        InnerLog.t("Intent setPackage 2")
        _ = object.callObjectMethod(name: "setPackage", args: packageName, returningClass: intentClazz)
        #endif
        return self
    }

    /// Set a selector for this Intent.
    /// 
    /// This is a modification to the kinds of things the Intent will match.
    /// 
    /// If the selector is set, it will be used when trying to find entities
    /// that can handle the Intent, instead of the main contents of the Intent.
    /// This allows you build an Intent containing a generic protocol while targeting it more specifically.
    public func selector(_ selector: Intent) -> Self {
        #if os(Android)
        InnerLog.t("Intent setSelector 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setSelector 1.1 exit")
            return self
        }
        InnerLog.t("Intent setSelector 2")
        _ = object.callObjectMethod(name: "setSelector", args: selector.object, returningClass: intentClazz)
        #endif
        return self
    }

    /// Set the bounds of the sender of this intent, in screen coordinates.
    public func sourceBounds(_ r: Rect) -> Self {
        #if os(Android)
        InnerLog.t("Intent setSourceBounds 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setSourceBounds 1.1 exit")
            return self
        }
        InnerLog.t("Intent setSourceBounds 2")
        _ = object.callObjectMethod(name: "setSourceBounds", args: r.object, returningClass: intentClazz)
        #endif
        return self
    }

    /// Set an explicit MIME data type for the intent.
    public func type(_ type: String, normalize: Bool = false) -> Self {
        #if os(Android)
        InnerLog.t("Intent setType 1")
        guard
            let intentClazz = JClass.load(.android.content.Intent)
        else {
            InnerLog.e("Intent setType 1.1 exit")
            return self
        }
        InnerLog.t("Intent setType 2")
        _ = object.callObjectMethod(name: normalize ? "setTypeAndNormalize" : "setType", args: type, returningClass: intentClazz)
        #endif
        return self
    }

    /// Convert this Intent into a String holding a URI representation of it.
    public func toURI(_ flags: Int32) -> String? {
        #if os(Android)
        InnerLog.t("Intent toURI 1")
        guard
            let stringClazz = JClass.load(.java.lang.String),
            let uriObject = object.callObjectMethod(name: "toUri", args: flags, returningClass: stringClazz),
            let uriString = JString(uriObject).string()
        else {
            InnerLog.e("Intent toURI 1.1 exit")
            return nil
        }
        InnerLog.t("Intent toURI 2")
        return uriString
        #else
        return nil
        #endif
    }

    // TODO: writeToParcel
}