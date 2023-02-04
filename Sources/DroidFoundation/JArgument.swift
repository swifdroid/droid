//
//  JArgument.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import CDroidJNI

public class JArgument {
    public let signatureItem: MethodSignatureItem
    public let value: JValuable
    
    public init (_ signatureItem: MethodSignatureItem, value: JValuable? = nil) {
        self.signatureItem = signatureItem
        self.value = value ?? ZeroJValue()
    }
    
    public static func boolean(_ v: Bool) -> JArgument { .init(.boolean(), value: v) }
    public static var booleanArray: JArgument { .init(.boolean(array: true)) }
    
    public static var byte: JArgument { .init(.byte()) }
    public static var byteArray: JArgument { .init(.byte(array: true)) }
    
    public static var char: JArgument { .init(.char()) }
    public static var charArray: JArgument { .init(.char(array: true)) }
    
    public static var short: JArgument { .init(.short()) }
    public static var shortArray: JArgument { .init(.short(array: true)) }
    
    public static func int(_ v: Int) -> JArgument { .init(.int(), value: v) }
    public static var intArray: JArgument { .init(.int(array: true)) }

    public static var long: JArgument { .init(.long()) }
    public static var longArray: JArgument { .init(.long(array: true)) }

    public static func float(_ v: Float) -> JArgument { .init(.float(), value: v) }
    public static var floatArray: JArgument { .init(.float(array: true)) }

    public static var double: JArgument { .init(.double()) }
    public static var doubleArray: JArgument { .init(.double(array: true)) }

    public static var void: JArgument { .init(.void()) }
    
    public static func object(_ classes: AndroidClassName...) -> JArgument { .init(.object(classes)) }
    public static func objectArray(_ classes: AndroidClassName...) -> JArgument { .init(.object(array: true, classes)) }
}

fileprivate struct ZeroJValue: JValuable {
    var jValue: jvalue { jvalue.init(i: 0) }
}
