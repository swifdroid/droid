//
//  AndroidPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

public class AndroidPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "android")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "android")
    }
}

extension JClassName {
    public static var android: AndroidPackage { .init() }
}
