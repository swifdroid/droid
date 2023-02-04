//
//  RecyclerView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.RecyclerViewPackage.WidgetPackage {
    public class RecyclerViewClass: AndroidClassName {}
    
    public var RecyclerView: RecyclerViewClass { .init(superClass: self, "RecyclerView") }
}

class RecyclerView: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.recyclerview.widget.RecyclerView], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
