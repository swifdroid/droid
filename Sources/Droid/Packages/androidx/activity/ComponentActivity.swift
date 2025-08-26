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
extension ComponentActivity: Sendable {}
#else
extension ComponentActivity: @unchecked Sendable {}
#endif

/// [Learn more](https://developer.android.com/reference/androidx/activity/ComponentActivity)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class ComponentActivity: Activity {
    open class override var className: JClassName { "androidx/activity/ComponentActivity" }
    open class override var gradleDependencies: [String] { [
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class override var parentClass: String { "DroidComponentActivity()" }
}