//
//  JavaLangCharSequence.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

extension JavaPackage.LangPackage {
    public class CharSequenceClass: JClassName, @unchecked Sendable {}
    
    public var CharSequence: CharSequenceClass { .init(parent: self, name: "CharSequence") }
}

// public protocol CharSequence: AnyJClass {
//     func toString() -> String
// }

// extension CharSequence {
//     public func toString() -> String {
//         guard let jobj = callJObjectWithMethod("toString", returning: .object(.java.lang.String)) else { return "" }
//         let bytes = JavaLangString(self, jobj).getBytes()
//         return String(data: Data(bytes), encoding: .utf8) ?? ""
//     }
    
//     public func length() -> Int {
//         guard let jint = callIntWithMethod("length", returning: .int()) else { return 0 }
//         return Int(jint)
//     }
// }
