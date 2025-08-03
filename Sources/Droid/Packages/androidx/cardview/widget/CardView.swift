//
//  CardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.CardViewPackage.WidgetPackage {
    public class CardViewClass: JClassName, @unchecked Sendable {}
    
    public var CardView: CardViewClass { .init(parent: self, name: "CardView") }
}

// class CardView: View, @unchecked Sendable {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.androidx.cardview.widget.CardView], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
