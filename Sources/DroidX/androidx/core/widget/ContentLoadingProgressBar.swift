//
//  ContentLoadingProgressBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Foundation
import CDroidJNI
import DroidFoundation
import Droid

extension AndroidXPackage.CorePackage.WidgetPackage {
    public class ContentLoadingProgressBarClass: AndroidClassName {}
    
    public var ContentLoadingProgressBar: ContentLoadingProgressBarClass { .init(superClass: self, "ContentLoadingProgressBar") }
}

class ContentLoadingProgressBar: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.androidx.core.widget.ContentLoadingProgressBar], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
}
