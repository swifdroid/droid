//
//  JavaLangString.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension JavaPackage.LangPackage {
    public class StringClass: AndroidClassName {}
    
    public var String: StringClass { .init(superClass: self, "String") }
}

class JavaLangString: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.java.lang.String], args: [])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    init (_ class: AnyJClass, _ object: jobject) {
        super.init(`class`.environment, JClassReference(`class`.environment, [.java.lang.String]), object)
    }
    
//    init (_ class: AnyJClass, _ text: String) {
//        let bytes: [UInt8] = text.data(using: .utf8)?.map { $0 } ?? []
//        
//        super.init(`class`.environment, JClassReference(`class`.environment, [.java.lang.String]), classes: [.java.lang.String], args: [.byteArray, .object(.java.lang.String)])
//    }
    
    public func getBytes() -> [UInt8] {
        let bytesPointer = callJObjectWithMethod("getBytes", returning: .byte(array: true))
        guard let byteArrayElementsPointer = self.environment.pointer.pointee?.pointee.GetByteArrayElements(self.environment.pointer, bytesPointer, nil) else { return [] }
        guard let _arrayLength = self.environment.pointer.pointee?.pointee.GetArrayLength(self.environment.pointer, bytesPointer) else { return [] }
        let arrayLength = Int(_arrayLength)
        guard arrayLength > 0 else { return [] }
        let bytes = (0...(arrayLength - 1)).map { UInt8(byteArrayElementsPointer[$0]) }
        self.environment.pointer.pointee?.pointee.ReleaseByteArrayElements(self.environment.pointer, bytesPointer, byteArrayElementsPointer, 0)
        return bytes
    }
}
