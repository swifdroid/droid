//
//  ComGoogleAndroidPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Droid

public class ComGoogleAndroidPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "com/google/android")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "com/google/android")
    }
}

extension JClassName {
    public static var comGoogleAndroid: ComGoogleAndroidPackage { .init() }
}
