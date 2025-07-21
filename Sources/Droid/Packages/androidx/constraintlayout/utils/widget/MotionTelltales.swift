//
//  MotionTelltales.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.UtilsPackage.WidgetPackage {
    public class MotionTelltalesClass: JClassName, @unchecked Sendable {}
    
    public var MotionTelltales: MotionTelltalesClass { .init(parent: self, name: "MotionTelltales") }
}

// class MotionTelltales: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.utils.widget.MotionTelltales], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
