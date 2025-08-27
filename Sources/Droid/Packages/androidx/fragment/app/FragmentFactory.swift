//
//  FragmentFactory.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentFactory)
public final class FragmentFactory: JObjectable, Sendable {
    public class var className: JClassName { .init(stringLiteral: "androidx/fragment/app/FragmentFactory") }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension FragmentFactory {
    /// Create a new instance of a `Fragment` with the given class name.
    ///
    /// This uses `loadFragmentClass` and the empty constructor of the resulting `Class` by default.
    public func instantiate(_ classLoader: JClassLoader, _ className: JClassName) -> Fragment? {
        guard
            let str = JString(from: className.path),
            let global = object.callObjectMethod(name: "instantiate", args: classLoader.signed(as: JClassLoader.className), str.signedAsString(), returning: .object(Fragment.className))
        else { return nil }
        return .init(global)
    }
}