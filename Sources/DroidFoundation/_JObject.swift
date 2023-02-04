//
//  JObject.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

//import CDroidJNI
//
//class JObject {
//    private(set) var object: jobject!
//    
//    init (env: UnsafeMutablePointer<JNIEnv?>, classref: jobject, _ name: AndroidClassName...) {
//        guard name.count > 0 else { fatalError("JObject name can't be empty") }
//        let group = DispatchGroup()
//        group.enter()
//        _ = name.path.withCString { className -> Int32 in
//            "<init>".withCString { initMethodName -> Int32 in
//                "(Landroid/content/Context;)V".withCString { initMethodSignature -> Int32 in
//                    let classReference = env.pointee?.pointee.FindClass(env, className)
//                    let methodId = env.pointee?.pointee.GetMethodID(env, classReference, initMethodName, initMethodSignature)
//                    var vvv: jvalue = jvalue.init(l: classref)
////                    let initializedLayout = env.pointee?.pointee.NewObjectA(env, classReference, methodId, &vvv)
//                    self.object = env.pointee?.pointee.NewObjectA(env, classReference, methodId, &vvv)
//    //                print(.info, "Found class: \(ccc)")
//                    group.leave()
//                    return 0
//                }
//            }
//        }
//        group.wait()
//    }
//}


//
//    _ = "android/widget/LinearLayout".withCString { className -> Int32 in
//        print(.debug, "className")
//        return "<init>".withCString { initMethodName -> Int32 in
//            print(.debug, "initMethodName")
//            return "(Landroid/content/Context;)V".withCString { initMethodSignature -> Int32 in
//                print(.debug, "initMethodSignature")
//                let classReference = env.pointee?.pointee.FindClass(env, className)
//                print(.debug, "initMethodSignature 1")
//                let methodId = env.pointee?.pointee.GetMethodID(env, classReference, initMethodName, initMethodSignature)
//                print(.debug, "initMethodSignature 2")
//                var vvv: jvalue = jvalue.init(l: classref)
//                print(.debug, "initMethodSignature 3")
//                let initializedLayout = env.pointee?.pointee.NewObjectA(env, classReference, methodId, &vvv)
////                print(.info, "Found class: \(ccc)")
//                print(.debug, "TESTING", "initializedLayout: \(initializedLayout)")
//                return 0
//            }
//        }
//    }
