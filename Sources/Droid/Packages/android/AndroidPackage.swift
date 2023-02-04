//
//  AndroidPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

public class AndroidPackage: AndroidClassName {
    public init () {
        super.init("android")
    }
}

extension AndroidClassName {
    public static var android: AndroidPackage { .init() }
}
