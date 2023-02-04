//
//  CardView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.CardViewPackage.WidgetPackage {
    public class CardViewClass: AndroidClassName {}
    
    public var CardView: CardViewClass { .init(superClass: self, "CardView") }
}

class CardView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.cardview.widget.CardView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
