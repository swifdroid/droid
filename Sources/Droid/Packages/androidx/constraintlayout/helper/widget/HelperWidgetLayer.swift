//
//  HelperWidgetLayer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage.HelperPackage.WidgetPackage {
    public class LayerClass: JClassName, @unchecked Sendable {}
    
    public var Layer: LayerClass { .init(parent: self, name: "Layer") }
}

// class Layer: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.constraintlayout.helper.widget.Layer], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
