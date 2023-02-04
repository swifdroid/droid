//
//  AndroidXPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

public class AndroidXPackage: AndroidClassName {
    public init () {
        super.init("androidx")
    }
}

extension AndroidClassName {
    public static var androidx: AndroidXPackage { .init() }
}
