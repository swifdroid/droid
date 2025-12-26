//
//  NavInflater.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// Class which translates a navigation XML file into a NavGraph
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/NavInflater)
@MainActor
public final class NavInflater: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/NavInflater" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension NavInflater {

}