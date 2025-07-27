//
//  AnyActivity.swift
//
//
//  Created by Mihael Isaev on 25.02.2023.
//

#if os(Android)
import Android
#endif

extension DroidApp {
    public protocol AnyActivity: AnyObject, JObjectable, JClassLoadable, Sendable {
        // MARK: - Properties

        /// The globally retained JNI reference to the Java object.
        var ref: JObjectBox { get }

        /// The loaded `JClass`
        var clazz: JClass { get }

        /// Object wrapper
        var object: JObject { get }

        // MARK: - Initializers

        init (ref: JObjectBox, clazz: JClass, object: JObject)
        
        // MARK: - Static Properties

        /// The JNI class name
        static var className: JClassName { get }
        /// What should be imported in Java header
        static var javaImports: [String] { get }
        /// Parent Java class name
        static var parentClass: String { get }
        /// Swift class name
        static var name: String { get }

        // MARK: - Methods

        func setContentView(_ object: JObject)
    }
}

extension DroidApp.AnyActivity {
    var ref: JObjectBox { object.ref }
    var clazz: JClass { object.clazz }
}

// MARK: - Static Properties

extension DroidApp.AnyActivity {
    public static var className: JClassName { .init(stringLiteral: "androidx/appcompat/app/AppCompatActivity") }
    public static var javaImports: [String] { ["stream.swift.droid.appkit.activities.*"] }
    public static var parentClass: String { "DroidAppCompatActivity()" }
    public static var name: String { "\(Self.self)" }
}

// MARK: - Initializers

extension DroidApp.AnyActivity {
    public init?<C: JClassLoadable>(_ env: JEnv, _ context: C) {
        #if os(Android)
        guard
            let classLoader = context.getClassLoader(),
            let clazz = classLoader.loadClass(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: nil)
        else { return nil }
        self.init(ref: global.ref, clazz: clazz, object: global)
        #else
        return nil
        #endif
    }
}

// MARK: - Methods

extension DroidApp.AnyActivity {
    public func setContentView(_ object: JObject) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = clazz.methodId(env: env, name: "setContentView", signature: .init(.object(.android.view.View), returning: .void))
        else { return }
        env.callVoidMethod(object: .init(ref, clazz), methodId: methodId, args: [object])
        #endif
    }
}