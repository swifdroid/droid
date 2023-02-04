//
//  JNIObjectable.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 23.10.2021.
//

import CDroidJNI

public protocol JNIObjectable {
    var object: jobject { get }
}
