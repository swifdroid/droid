//
//  LayoutInflater.swift
//  Droid
//
//  Created by Mihael Isaev on 27.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// Instantiates a layout XML file into its corresponding View objects.
/// 
/// It is never used directly. Instead, use Activity.getLayoutInflater() or Context.getSystemService
/// to retrieve a standard LayoutInflater instance that is already hooked up to the current context
// and correctly configured for the device you are running on.
///
/// To create a new LayoutInflater with an additional Factory for your own views, you can use cloneInContext(Context)
/// to clone an existing ViewFactory, and then call setFactory(Factory) on it to include your Factory.
///
/// For performance reasons, view inflation relies heavily on pre-processing of XML files that is done at build time.
/// 
/// Therefore, it is not currently possible to use LayoutInflater with an XmlPullParser over a plain XML file at runtime;
/// it only works with an XmlPullParser returned from a compiled resource (R.something file.)
///
/// Note: This class is not thread-safe and a given instance should only be accessed by a single thread.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/LayoutInflater)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class LayoutInflater: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/view/LayoutInflater" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement LayoutInflater methods
}