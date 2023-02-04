//
//  JavaPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

public class JavaPackage: AndroidClassName {
    public init () {
        super.init("java")
    }
}

extension AndroidClassName {
    public static var java: JavaPackage { .init() }
}
