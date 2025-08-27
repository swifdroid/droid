//
//  PaintDrawable.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.GraphicsPackage.DrawablePackage {
    public class PaintDrawableClass: JClassName, @unchecked Sendable {}
    
    public var PaintDrawable: PaintDrawableClass { .init(parent: self, name: "PaintDrawable") }
}

// class PaintDrawable: ShapeDrawable {
//     init (_ environment: JEnvironment, _ context: JObjectReference, _ color: Int) {
//         super.init(environment, context, classes: [.android.graphics.drawable.PaintDrawable], args: [.int(color)])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
    
//     func cornerRadius(_ radius: Float) {
//         callVoidWithMethod("setCornerRadius", .float(radius))
//     }
// }
