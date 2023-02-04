//
//  JClass.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import Foundation
import CDroidJNI

public protocol AnyJClass: JValuable {
    var environment: JEnvironment { get }
    var reference: JClassReference { get }
    var classObject: jobject { get }
    
    func callVoidWithMethod(_ methodName: String, _ args: JArgument...)
    func callVoidWithMethod(_ methodName: String, _ customSignatureItems: [MethodSignatureItem], _ args: [JArgument])
    
    static func callVoidWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument])
    
    func callIntWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jint?
    
    func callJObjectWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jobject?
    
    func callStaticJObjectWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jobject?
    static func callStaticJObjectWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jobject?
    
    func getJObjectWithMethod(_ methodName: String, _ args: JArgument...) -> jobject?
    static func getJObjectWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jobject?
    
    func getMethodId(_ methodName: String, _ customSignatureItems: [MethodSignatureItem], _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jmethodID?
    static func getMethodId(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jmethodID?
}

extension AnyJClass {
    public var jValue: jvalue { .init(l: classObject) }
}

open class JClass: AnyJClass {
    public let environment: JEnvironment
    public let reference: JClassReference
    public let classObject: jobject
    
    public func move(to detachedContext: DetachedJavaContext, _ obj: jobject? = nil) -> Self {
        return .init(detachedContext.environment, .init(detachedContext.environment.getObjectClass(classObject)!), classObject)
    }
    
    public func move(to newEnv: JEnvironment, _ obj: jobject? = nil) -> Self {
        return .init(newEnv, .init(newEnv.getObjectClass(classObject)!), classObject)
    }
    
    required public init (_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        self.environment = environment
        self.reference = ref
        self.classObject = object
    }
    
//    public init (_ environment: JEnvironment, _ context: JObjectReference, classes: AndroidClassName...) {
//        self.environment = environment
//        let ref = JClassReference(environment, classes)
//        self.reference = ref
//        guard let classObject = Self.getJObjectWithMethod("<init>", environment, ref, [.object(.android.content.Context) / context]) else {
//            fatalError("💣 Unable to instantiate class " + classes.path)
//        }
//        self.classObject = classObject
//    }
    
    public init (_ environment: JEnvironment, _ context: JObjectReference, classes: [AndroidClassName], args: [JArgument]) {
        print(.debug, "🪚", "JClass init step 1")
        self.environment = environment
        print(.debug, "🪚", "JClass init step 2")
        let ref = JClassReference(environment, classes)
        print(.debug, "🪚", "JClass init step 3")
        self.reference = ref
        print(.debug, "🪚", "JClass init step 4")
        guard let classObject = Self.getJObjectWithMethod("<init>", environment, ref, args, nil) else {
            print(.debug, "🪚", "JClass init step 4.1")
            fatalError("💣 Unable to instantiate class " + classes.path)
        }
        print(.debug, "🪚", "JClass init step 5")
        self.classObject = environment.newGlobalRef(classObject)! // NOTE: weak global ref should never be used
        print(.debug, "🪚", "JClass init step 6")
    }
    
    public init (_ environment: JEnvironment, _ ref: JClassReference, classes: [AndroidClassName], args: [JArgument]) {
        print(.debug, "🪚", "JClass init step 1")
        self.environment = environment
        print(.debug, "🪚", "JClass init step 2")
        self.reference = ref
        print(.debug, "🪚", "JClass init step 3")
        guard let classObject = Self.getJObjectWithMethod("<init>", environment, ref, args, nil) else {
            print(.debug, "🪚", "JClass init step 3.1")
            fatalError("💣 Unable to instantiate class " + classes.path)
        }
        print(.debug, "🪚", "JClass init step 4")
        self.classObject = environment.newGlobalRef(classObject)! // NOTE: weak global ref should never be used
        print(.debug, "🪚", "JClass init step 5")
    }
    
//    public init (_ environment: JEnvironment, _ context: JObjectReference, classes: [AndroidClassName]) {
//        self.environment = environment
//        let ref = JClassReference(environment, classes)
//        self.reference = ref
//        guard let classObject = Self.getJObjectWithMethod("<init>", environment, ref, [.object(.android.content.Context) / context]) else {
//            fatalError("💣 Unable to instantiate class " + classes.path)
//        }
//        self.classObject = environment.newGlobalRef(classObject)!//classObject
//    }
    
    public func map<C>(to classes: AndroidClassName...) -> C where C: JClass {
        return .init(environment, reference, classObject)
    }
    
    public func callVoidWithMethod(_ methodName: String, _ args: JArgument...) {
        callVoidWithMethod(methodName, [], args)
    }
    
    public func callVoidWithMethod(_ methodName: String, _ customSignatureItems: [MethodSignatureItem], _ args: [JArgument]) {
        let methodId = getMethodId(methodName, customSignatureItems, args, nil)
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            self.environment.pointer.pointee?.pointee.CallVoidMethodA(self.environment.pointer, self.classObject, methodId, &arr)
        } else {
            self.environment.pointer.pointee?.pointee.CallVoidMethodA(self.environment.pointer, self.classObject, methodId, nil)
        }
    }
    
    public static func callVoidWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument]) {
        let methodId = getMethodId(methodName, env, ref, args, nil)
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            env.pointer.pointee?.pointee.CallVoidMethodA(env.pointer, ref.classReference, methodId, &arr)
        } else {
            env.pointer.pointee?.pointee.CallVoidMethodA(env.pointer, ref.classReference, methodId, nil)
        }
    }
    
//    public func callByteArrayWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem? = nil) -> jbyteArray? {
//        let methodId = Self.getMethodId(methodName, self.environment, self.reference, args, returning)
//        // TODO: multiple args https://stackoverflow.com/questions/30900507/call-newobject-method-jni-with-params-in-jobjectarrayr
//        if let firstArg = args.first {
//            var val = [firstArg.value.jValue]
//            return self.environment.pointer.pointee?.pointee.CallByteMethodA(self.environment.pointer, self.classObject, methodId, &val)
//        } else {
//            return self.environment.pointer.pointee?.pointee.CallByteMethodA(self.environment.pointer, self.classObject, methodId, nil)
//        }
//    }
    
    public func callIntWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jint? {
        let methodId = Self.getMethodId(methodName, self.environment, self.reference, args, returning)
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            return self.environment.pointer.pointee?.pointee.CallIntMethodA(self.environment.pointer, self.classObject, methodId, &arr)
        } else {
            return self.environment.pointer.pointee?.pointee.CallIntMethodA(self.environment.pointer, self.classObject, methodId, nil)
        }
    }
    
    public func callJObjectWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jobject? {
        let methodId = Self.getMethodId(methodName, self.environment, self.reference, args, returning)
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            return self.environment.pointer.pointee?.pointee.CallObjectMethodA(self.environment.pointer, self.classObject, methodId, &arr)
        } else {
            return self.environment.pointer.pointee?.pointee.CallObjectMethodA(self.environment.pointer, self.classObject, methodId, nil)
        }
    }
    
    public func callStaticJObjectWithMethod(_ methodName: String, _ args: JArgument..., returning: MethodSignatureItem?) -> jobject? {
        Self.callStaticJObjectWithMethod(methodName, self.environment, self.reference, args, returning)
    }
    
    public static func callStaticJObjectWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem? = nil) -> jobject? {
        let jObject: jobject?
        let methodId = getMethodId(methodName, env, ref, args, resultSignature)
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            jObject = env.pointer.pointee?.pointee.CallObjectMethodA(env.pointer, ref.classReference, methodId, &arr)
        } else {
            jObject = env.pointer.pointee?.pointee.CallObjectMethodA(env.pointer, ref.classReference, methodId, nil)
        }
        return jObject
    }
    
    public func getJObjectWithMethod(_ methodName: String, _ args: JArgument...) -> jobject? {
        Self.getJObjectWithMethod(methodName, self.environment, self.reference, args, nil)
    }
    
    public static func getJObjectWithMethod(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jobject? {
        let jObject: jobject?
        let methodId = getMethodId(methodName, env, ref, args, resultSignature)
        print(.debug, "🪚", "JClass.getJObjectWithMethod ref.classReference: \(ref.classReference)")
        print(.debug, "🪚", "JClass.getJObjectWithMethod env.pointer: \(env.pointer)")
        print(.debug, "🪚", "JClass.getJObjectWithMethod methodName: \(methodName)")
        // TODO: multiple args https://stackoverflow.com/questions/30900507/call-newobject-method-jni-with-params-in-jobjectarrayr
        if args.count > 0 {
            var arr: [jvalue] = args.map { $0.value.jValue }
            jObject = env.pointer.pointee?.pointee.NewObjectA(env.pointer, ref.classReference, methodId, &arr)
        } else {
            jObject = env.pointer.pointee?.pointee.NewObjectA(env.pointer, ref.classReference, methodId, nil)
        }
        return jObject
    }
    
    public func getMethodId(_ methodName: String, _ customSignatureItems: [MethodSignatureItem], _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jmethodID? {
        print(.debug, "🪚", "JClass.getMethodId step 1")
        var methodId: jmethodID? = nil
        let group = DispatchGroup()
        group.enter()
        let signature: String
        if customSignatureItems.count > 0 {
            signature = "(" + customSignatureItems.map { $0.signature }.joined() + ")" + (resultSignature?.signature ?? "V")
        } else {
            signature = "(" + args.map { $0.signatureItem.signature }.joined() + ")" + (resultSignature?.signature ?? "V")
        }
        print(.debug, "🪚", "JClass.getMethodId step 2")
        methodName.withCString { cMethodName -> Void in
            signature.withCString { cMethodSignature -> Void in
                print(.debug, "🪚", "JClass.getMethodId step 3")
                methodId = self.environment.pointer.pointee?.pointee.GetMethodID(self.environment.pointer, self.reference.classReference, cMethodName, cMethodSignature)
                print(.debug, "🪚", "JClass.getMethodId step 4")
                group.leave()
            }
        }
        group.wait()
        print(.debug, "🪚", "JClass.getMethodId step 5")
        return methodId
    }
    
    // TODO: try to cache methodId in dictionary by method siganture string
    public static func getMethodId(_ methodName: String, _ env: JEnvironment, _ ref: JClassReference, _ args: [JArgument], _ resultSignature: MethodSignatureItem?) -> jmethodID? {
        var methodId: jmethodID? = nil
        let group = DispatchGroup()
        group.enter()
        
        
        let sig = ("(" + args.map { $0.signatureItem.signature }.joined() + ")" + (resultSignature?.signature ?? "V"))
        print(.debug, "🎯", "sig: \(sig)")
        methodName.withCString { cMethodName -> Void in
            sig.withCString { cMethodSignature -> Void in
                methodId = env.pointer.pointee?.pointee.GetMethodID(env.pointer, ref.classReference, cMethodName, cMethodSignature)
                group.leave()
            }
        }
        group.wait()
        return methodId
    }
}
