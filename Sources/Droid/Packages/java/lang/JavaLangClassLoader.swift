// //
// //  JavaLangString.swift
// //  
// //
// //  Created by Mihael Isaev on 28.01.2022.
// //

// #if os(Android)
// import Android
// #endif
// import DroidFoundation
// import FoundationEssentials

// extension JavaPackage.LangPackage {
//     public class ClassLoaderClass: JClassName, @unchecked Sendable {}
    
//     public var ClassLoader: ClassLoaderClass { .init(parent: self, name: "ClassLoader") }
// }

// class JavaLangClassLoader: @unchecked Sendable, JObjectable {
//     // MARK: - Properties

//     #if os(Android)
//     /// The globally retained JNI reference to the Java string.
//     public let ref: jobject
//     #endif

//     /// The JNI class name
//     public class var className: JClassName { .java.lang.String }

//     /// The loaded `JClass`
//     public let clazz: JClass

//     /// Object wrapper
//     public var object: JObject

//     convenience init? (_ context: JObject) {
//         guard let env = JEnv.current() else { return nil }
//         self.init(env, context)
//     }
    
//     init? (_ env: JEnv, _ context: JObject) {
//         guard
//             let clazz = JClass.load(Self.className),
//             let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.java.lang.String), returning: .void)),
//             let global = env.newObject(clazz: clazz, constructor: methodId, args: nil)
//         else { return nil }
//         self.ref = global.ref
//         self.clazz = clazz
//         self.object = JObject(global.ref, clazz)
//     }

//     /// Finds a class by name using the current class loader.
//     ///
//     /// - Parameter name: JNI slash-separated class path (e.g. `"java/lang/String"`)
//     /// - Returns: A wrapped class reference or `nil` if not found.
//     public func findClass(_ name: JClassName) -> JClass? {
//         name.path.withCString {
//             JClass(env.pointee!.pointee.FindClass!(env, $0), name)
//         }
//     }
// }