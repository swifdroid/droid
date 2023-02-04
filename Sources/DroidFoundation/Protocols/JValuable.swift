//
//  JValuable.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import CDroidJNI

public protocol JValuable {
    var jValue: jvalue { get }
}

extension Int: JValuable {
    public var jValue: jvalue { .init(i: jint.init(self)) }
}

extension Float: JValuable {
    public var jValue: jvalue { .init(f: jfloat.init(self)) }
}

extension Double: JValuable {
    public var jValue: jvalue { .init(d: jdouble.init(self)) }
}

extension Bool: JValuable {
    public var jValue: jvalue { .init(z: self ? 1 : 0) }
}
