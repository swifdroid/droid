//
//  JavaLangCharSequence.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension JavaPackage.LangPackage {
    public class CharSequenceClass: AndroidClassName {}
    
    public var CharSequence: CharSequenceClass { .init(superClass: self, "CharSequence") }
}

public protocol CharSequence: AnyJClass {
    func toString() -> String
}

extension CharSequence {
    public func toString() -> String {
        guard let jobj = callJObjectWithMethod("toString", returning: .object(.java.lang.String)) else { return "" }
        let bytes = JavaLangString(self, jobj).getBytes()
        return String(data: Data(bytes), encoding: .utf8) ?? ""
    }
    
    public func length() -> Int {
        guard let jint = callIntWithMethod("length", returning: .int()) else { return 0 }
        return Int(jint)
    }
}
