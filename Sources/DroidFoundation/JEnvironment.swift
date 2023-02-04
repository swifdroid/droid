//
//  JEnvironment.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import Foundation
import CDroidJNI

public class JNI {
    public let environment: JEnvironment
    public let instance: JNINativeInterface
    
    public init (_ environment: JEnvironment, _ instance: JNINativeInterface) {
        self.environment = environment
        self.instance = instance
    }
    
    public func getObjectClass(_ object: jobject?) -> jclass? {
        instance.GetObjectClass(environment.pointer, object)
    }
}

public class JEnvironment {
    public let pointer: UnsafeMutablePointer<JNIEnv?>
    private(set) lazy var jni: JNI = .init(self, pointer.pointee!.pointee)
    
    public init (_ pointer: UnsafeMutablePointer<JNIEnv?>) {
        self.pointer = pointer
    }
    
    public func findClass(_ classPath: String) -> JClassReference? {
        let group = DispatchGroup()
        group.enter()
        var _classReference: jclass?
        classPath.withCString { cClassPath -> Void in
            _classReference = self.findClass(cClassPath)
            group.leave()
        }
        group.wait()
        guard let classRef = _classReference else { return nil }
        return .init(classRef)
    }
    
    public func findClass(_ cClassPath: UnsafePointer<Int8>) -> jclass? {
        pointer.pointee?.pointee.FindClass(pointer, cClassPath)
    }
    
    public func getObjectClass(_ object: jobject) -> jclass? {
        pointer.pointee?.pointee.GetObjectClass(pointer, object)
    }
    
    public func newGlobalRef(_ object: jobject) -> jobject? {
        pointer.pointee?.pointee.NewGlobalRef(pointer, object)
    }
    
    public func newWeakGlobalRef(_ object: jobject) -> jobject? {
        pointer.pointee?.pointee.NewWeakGlobalRef(pointer, object)
    }
    
    public func isSameObject(_ obj1: jobject, _ obj2: jobject) -> Bool {
        guard let jb = pointer.pointee?.pointee.IsSameObject(pointer, obj1, obj2) else { return false }
        return jb == 1
    }
}
