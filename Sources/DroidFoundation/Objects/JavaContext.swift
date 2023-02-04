//
//  JavaContext.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 23.10.2021.
//

import CDroidJNI

public class JavaContext: JNIEnvable, JNIObjectable {
    public let me, classref: jobject
    public let environment: JEnvironment
    public var environmentPointer: UnsafeMutablePointer<JNIEnv?>? { environment.pointer }
    public var _jvm: JavaVM?
    public var jvm: UnsafeMutablePointer<JavaVM?>?
    public let object: jobject
    
    public init (_ env: UnsafeMutablePointer<JNIEnv?>, _ me: jobject, _ classref: jobject) {
        self.environment = .init(env)
        self.me = me
        self.classref = classref
        jvm = .init(&_jvm)
        GetJVM(env, &jvm)
        object = environment.newGlobalRef(me)!
    }
    
    public func detach() -> DetachedJavaContext {
        .init(self)
    }
    
    public func toClass() -> JavaClass? {
        .init(self)
    }
    
//    public func findClass(_ name: String) -> JavaClass? {
//        tag.withCString { tag -> Int32 in
//        environment?.pointee?.pointee.FindClass()
//    }
}
