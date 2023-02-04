//
//  DetachedJavaContext.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 23.10.2021.
//

import Foundation
import CDroidJNI

public class DetachedJavaContext: JNIEnvable, JNIObjectable {
    public let context: JavaContext
    let environment: JEnvironment
    public var environmentPointer: UnsafeMutablePointer<JNIEnv?>?
    public var object: jobject { context.object }
    
    public init (_ context: JavaContext) {
        self.context = context
        AttachCurrentThread(context.jvm!, &environmentPointer)
        self.environment = .init(environmentPointer!)
        print(.warn, "MYAPP", "JVM is here on2 \(Thread.current.name ?? "-")")
        guard let jClass = self.environment.jni.getObjectClass(context.object) else {
            print(.info, "CLBCK", "step 3.1")
            return
        }
    }
    
    /// Call to release the thread
    public func finalize() {
        DetachCurrentThread(context.jvm!)
    }
    
    public func toClass() -> JavaClass? {
        .init(self)
    }
}
