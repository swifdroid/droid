//
//  LinearLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class LinearLayoutClass: AndroidClassName {}
    
    public var LinearLayout: LinearLayoutClass { .init(superClass: self, "LinearLayout") }
}

class LinearLayout: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        print(.debug, "🪚", "LinearLayout init step 1")
        super.init(environment, context, classes: [.android.widget.LinearLayout], args: [.object(.android.content.Context) / context])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    func ppp() {
        print(.info, "🪚initializedLayout: \(self.classObject)")
    }
    
    func setBackgroundColor(_ color: Int) {
        callVoidWithMethod("setBackgroundColor", .int() / color)
        print(.info, "🎨color has been set!")
    }
    
    func setDividerPadding(_ padding: Int) {
        callVoidWithMethod("setDividerPadding", .int() / padding)
    }
    
    func setOrientation(_ orientation: Int) {
        callVoidWithMethod("setOrientation", .int() / orientation)
    }
    
    func setGravity(_ gravity: Int) {
        callVoidWithMethod("setGravity", .int() / gravity)
    }
    
    func setHorizontalGravity(_ gravity: Int) {
        callVoidWithMethod("setHorizontalGravity", .int() / gravity)
    }
    
    func setVerticalGravity(_ gravity: Int) {
        callVoidWithMethod("setVerticalGravity", .int() / gravity)
    }
}
