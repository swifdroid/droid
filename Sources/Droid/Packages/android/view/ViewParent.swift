//
//  ViewGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class ViewParentClass: JClassName, @unchecked Sendable {}
    
    public var ViewParent: ViewGroupClass { .init(parent: self, name: "ViewParent") }
}

// public class ViewParent: View, @unchecked Sendable {
//     /// The JNI class name
//     public class override var className: JClassName { .android.view.ViewParent }

//     public func removeView(_ view: View) {
//         #if os(Android)
//         guard
//             let env = JEnv.current(),
//             let methodId = clazz.methodId(env: env, name: "removeView", signature: .init(.object(.android.view.View), returning: .void))
//         else { return }
//         env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [object])
//         #endif
//     }
// }
