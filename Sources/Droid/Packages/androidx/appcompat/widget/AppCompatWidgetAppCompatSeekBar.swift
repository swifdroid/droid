//
//  AppCompatWidgetAppCompatSeekBar.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage.AppCompatPackage.WidgetPackage {
    public class AppCompatSeekBarClass: JClassName, @unchecked Sendable {}
    
    public var AppCompatSeekBar: AppCompatSeekBarClass { .init(parent: self, name: "AppCompatSeekBar") }
}

// class AppCompatSeekBar: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.appcompat.widget.AppCompatSeekBar], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
