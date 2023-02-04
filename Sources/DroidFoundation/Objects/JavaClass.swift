//
//  JavaClass.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 23.10.2021.
//

import CDroidJNI

public class JavaClass {
    public let context: JNIEnvable & JNIObjectable
    public let `class`: jclass
    public var jni: JNINativeInterface { context.environmentPointer!.pointee!.pointee }
    
    public init? (_ context: JNIEnvable & JNIObjectable) {
        guard let jc: jclass = context.environmentPointer!.pointee!.pointee.GetObjectClass(context.environmentPointer, context.object) else {
            return nil
        }
        self.context = context
        self.class = jc
    }
    
    public func callMethod(_ name: String) {
        _ = name.withCString { method -> Int32 in
            return "()V".withCString { sig -> Int32 in
                let midCallBack: jmethodID = jni.GetMethodID(self.context.environmentPointer!, self.class, method, sig)!
                jni.CallVoidMethodA(self.context.environmentPointer!, self.context.object, midCallBack, nil)
//                jni.DeleteGlobalRef(self.context.environmentPointer, self.context.object)
                return 0
            }
        }
    }
    
    public func callMethod(_ name: String, _ value: Int) {
        _ = name.withCString { method -> Int32 in
            return "(I)V".withCString { sig -> Int32 in
                let midCallBack: jmethodID = jni.GetMethodID(self.context.environmentPointer!, self.class, method, sig)!
                var vvv: jvalue = jvalue.init(i: jint.init(value))
                jni.CallVoidMethodA(self.context.environmentPointer!, self.context.object, midCallBack, &vvv)
//                jni.DeleteGlobalRef(self.context.environmentPointer, self.context.object)
                return 0
            }
        }
    }
}
