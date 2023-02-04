//
//  JClassReference.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import CDroidJNI

public class JClassReference {
    public private(set) var classReference: jclass
    public private(set) var classes: [AndroidClassName]
    
    public init (_ ref: jclass, classes: [AndroidClassName] = []) {
        self.classReference = ref
        self.classes = classes
    }
    
    public init (_ env: JEnvironment, _ classes: [AndroidClassName]) {
        let classPath = classes.path
        print(.debug, "JClassReference", "init classPath: \(classPath)")
        guard let _classReference = env.findClass(classPath) else {
            fatalError("💣 Class \(classPath) not found")
        }
        self.classReference = _classReference.classReference
        self.classes = classes
    }
}
