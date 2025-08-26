//
//  Bundle.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

/// A mapping from `String` keys to various `Parcelable` values.
/// 
/// [Learn more](https://developer.android.com/reference/android/os/Bundle)
public final class Bundle: JObjectable, Sendable {
    public class var className: JClassName { .init(stringLiteral: "android/os/Bundle") }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}