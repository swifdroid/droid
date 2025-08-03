//
//  ViewPager.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ViewPagerPackage.WidgetPackage {
    public class ViewPagerClass: JClassName, @unchecked Sendable {}
    
    public var ViewPager: ViewPagerClass { .init(parent: self, name: "ViewPager") }
}

// class ViewPager: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.viewpager.widget.ViewPager], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
