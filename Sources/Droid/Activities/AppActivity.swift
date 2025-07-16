//
//  Activity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

import DroidFoundation

extension AndroidPackage.AppPackage {
    public class ActivityPackage: JClassName, @unchecked Sendable {}
    
    public var Activity: ActivityPackage { .init(parent: self, name: "Activity") }
}

public final class AppActivity: DroidApp.AnyActivity {
    /// The globally retained JNI reference to the Java object.
    public let ref: JObjectBox

    /// The loaded `JClass`
    public let clazz: JClass

    /// Object wrapper
    public let object: JObject

    public required init(ref: JObjectBox, clazz: JClass, object: JObject) {
        self.ref = ref
        self.clazz = clazz
        self.object = object
    }
}