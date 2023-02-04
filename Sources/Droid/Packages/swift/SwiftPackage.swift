//
//  SwiftPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

public class SwiftPackage: AndroidClassName {
    public init () {
        super.init("swift")
    }
}

extension AndroidClassName {
    public static var swift: SwiftPackage { .init() }
}
