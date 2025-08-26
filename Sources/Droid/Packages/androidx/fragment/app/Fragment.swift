//
//  Fragment.swift
//  Droid
//
//  Created by Mihael Isaev on 26.08.2025.
//

/// A Fragment is a piece of an application's user interface or behavior that can be placed in an Activity.
///
/// Interaction with fragments is done through `FragmentManager`, which can be obtained via Activity.getFragmentManager() and Fragment.getFragmentManager().
/// 
/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/Fragment)
public final class Fragment: JObjectable, Sendable {
    public class var className: JClassName { .init(stringLiteral: "androidx/fragment/app/Fragment") }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}