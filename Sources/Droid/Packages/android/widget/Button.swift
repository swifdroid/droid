// //
// //  Button.swift
// //  Droid
// //
// //  Created by Mihael Isaev on 16.01.2022.
// //

// extension AndroidPackage.WidgetPackage {
//     public class ButtonClass: JClassName, @unchecked Sendable {}
    
//     public var Button: ButtonClass { .init(parent: self, name: "Button") }
// }

// class Button: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.android.widget.Button], args: [.object(.android.content.Context) / context])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
    
//     func setText(_ text: String) {
//         text.withCString { cstr in
//             let jsss = environment.pointer.pointee?.pointee.NewStringUTF(environment.pointer, cstr)
//             callVoidWithMethod("setText", .object(.java.lang.CharSequence) / JStringWrapper.init(v: jsss!))
//         }
//     }
// }

// struct JStringWrapper: JValuable {
//     let v: jstring
    
//     var jValue: jvalue { .init(l: v) }
// }
