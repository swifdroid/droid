//
//  JavaLangString.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

#if os(Android)
import Android
#endif

extension JavaPackage.LangPackage {
    public class StringClass: JClassName, @unchecked Sendable {}
    
    public var String: StringClass { .init(parent: self, name: "String") }
}

final class JavaLangString: Sendable, JObjectable {
    /// The JNI class name
    public class var className: JClassName { .java.lang.String }

    /// Object wrapper
    public let object: JObject

    convenience init? (_ context: JObject) {
        #if os(Android)
        guard let env = JEnv.current() else { return nil }
        self.init(env, context)
        #else
        return nil
        #endif
    }
    
    init? (_ env: JEnv, _ context: JObject) {
        #if os(Android)
        guard
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.java.lang.String), returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: nil)
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }
    
    // public func getBytes() -> [UInt8] {
    //     let bytesPointer = callJObjectWithMethod("getBytes", returning: .byte(array: true))
    //     guard let byteArrayElementsPointer = self.environment.pointer.pointee?.pointee.GetByteArrayElements(self.environment.pointer, bytesPointer, nil) else { return [] }
    //     guard let _arrayLength = self.environment.pointer.pointee?.pointee.GetArrayLength(self.environment.pointer, bytesPointer) else { return [] }
    //     let arrayLength = Int(_arrayLength)
    //     guard arrayLength > 0 else { return [] }
    //     let bytes = (0...(arrayLength - 1)).map { UInt8(byteArrayElementsPointer[$0]) }
    //     self.environment.pointer.pointee?.pointee.ReleaseByteArrayElements(self.environment.pointer, bytesPointer, byteArrayElementsPointer, 0)
    //     return bytes
    // }
}
