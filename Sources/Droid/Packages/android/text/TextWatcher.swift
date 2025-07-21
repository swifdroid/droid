//
//  TextWatcher.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

extension AndroidPackage.TextPackage {
    public class TextWatcherClass: JClassName, @unchecked Sendable {}
    
    public var TextWatcher: TextWatcherClass { .init(parent: self, name: "TextWatcher") }
}

// class TextWatcher: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.android.text.TextWatcher], args: [])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
// }
