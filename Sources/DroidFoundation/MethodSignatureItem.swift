//
//  MethodSignatureItem.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import CDroidJNI

public class MethodSignatureItem {
    private let key: String
    private let names: [AndroidClassName]
    public let className: String
    private let semicolon: Bool
    public let signature: String
    
    required public init (_ key: String, _ names: [AndroidClassName], semicolon: Bool = false) {
        self.key = key
        self.names = names
        if names.count > 0 {
            self.className = names.path + (semicolon ? ";" : "")
        } else {
            self.className = ""
        }
        self.semicolon = semicolon
        self.signature = key +  className
    }

    public static func boolean(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")Z", [])
    }

    public static func byte(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")B", [])
    }

    public static func char(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")C", [])
    }

    public static func short(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")S", [])
    }

    public static func int(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")I", [])
    }

    public static func long(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")J", [])
    }

    public static func float(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")F", [])
    }

    public static func double(array: Bool = false) -> Self {
        .init("\(array ? "[" : "")D", [])
    }

    public static func void() -> Self {
        .init("V", [])
    }

    public static func object(array: Bool = false, _ classes: AndroidClassName...) -> Self {
        .init("\(array ? "[" : "")L", classes, semicolon: true)
    }
    
    public static func object(array: Bool = false, _ classes: [AndroidClassName]) -> Self {
        .init("\(array ? "[" : "")L", classes, semicolon: true)
    }
}
