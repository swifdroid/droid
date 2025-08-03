//
//  ViewPager2.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ViewPager2Package.WidgetPackage {
    public class ViewPager2Class: JClassName, @unchecked Sendable {}
    
    public var ViewPager2: ViewPager2Class { .init(parent: self, name: "ViewPager2") }
}

// class ViewPager2: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.viewpager2.widget.ViewPager2], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
