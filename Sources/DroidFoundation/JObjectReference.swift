//
//  JObjectReference.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import CDroidJNI

public class JObjectReference: JValuable {
    private(set) var objectReference: jobject
    
    public var jValue: jvalue { .init(l: objectReference) }
    
    public init (_ object: jobject) {
        self.objectReference = object
    }
}
