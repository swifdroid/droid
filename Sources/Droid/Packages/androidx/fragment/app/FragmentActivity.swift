//
//  ComponentActivity.swift
//  Droid
//
//  Created by Mihael Isaev on 27.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if os(Android)
extension FragmentActivity: Sendable {}
#else
extension FragmentActivity: @unchecked Sendable {}
#endif

/// [Learn more](https://developer.android.com/reference/androidx/fragment/app/FragmentActivity)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class FragmentActivity: ComponentActivity {
    open class override var className: JClassName { "androidx/fragment/app/FragmentActivity" }
    open class override var gradleDependencies: [String] { [
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class override var parentClass: String { "DroidFragmentActivity()" }
}