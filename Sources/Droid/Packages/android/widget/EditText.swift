//
//  EditText.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class EditTextClass: AndroidClassName {}
    
    public var EditText: EditTextClass { .init(superClass: self, "EditText") }
}

class EditText: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.EditText], args: [.object(.android.content.Context) / context])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    func addTextChangedListener(_ textWatcher: JClass) {
        callVoidWithMethod("addTextChangedListener", .object(.android.text.TextWatcher) / textWatcher)
    }
}
