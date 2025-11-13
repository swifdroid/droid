//
//  Uri.swift
//  Droid
//
//  Created by Mihael Isaev on 25.10.2025.
//

/// Immutable URI reference. A URI reference includes a URI and a fragment,
/// the component of the URI following a '#'.
/// 
/// [Learn more](https://developer.android.com/reference/android/net/Uri)
public final class Uri: JObjectable, @unchecked Sendable {
    public class var className: JClassName { .init(stringLiteral: "android/net/Uri") }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public static func parse(_ value: String) -> Uri? {
        #if os(Android)
        InnerLog.t("Uri parse 1")
        guard
            let uriClazz = JClass.load(Self.className),
            let object = uriClazz.staticObjectMethod(name: "parse", args: value, returningClass: uriClazz)
        else {
            InnerLog.e("Uri parse 1.1 exit")
            return nil
        }
        InnerLog.t("Uri parse 2")
        return Uri(object)
        #else
        return nil
        #endif
    }

    // TODO: Add more methods and properties as needed
}