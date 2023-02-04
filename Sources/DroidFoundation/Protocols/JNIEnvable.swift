//
//  JNIEnvable.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 23.10.2021.
//

import CDroidJNI

public protocol JNIEnvable {
    var environmentPointer: UnsafeMutablePointer<JNIEnv?>? { get }
}
