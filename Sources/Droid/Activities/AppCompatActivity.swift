//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if os(Android)
extension AppCompatActivity: Sendable {}
#else
extension AppCompatActivity: @unchecked Sendable {}
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class AppCompatActivity: FragmentActivity {
    open class override var className: JClassName { "androidx/appcompat/app/AppCompatActivity" }
    open class override var gradleDependencies: [String] { [
        #"implementation("androidx.appcompat:appcompat:1.7.1")"#,
        #"implementation(platform("androidx.compose:compose-bom:2025.07.00"))"#
    ] }
    open class override var parentClass: String { "DroidAppCompatActivity()" }
}