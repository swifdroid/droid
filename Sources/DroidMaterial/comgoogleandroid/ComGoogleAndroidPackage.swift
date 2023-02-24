//
//  ComGoogleAndroidPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Droid

public class ComGoogleAndroidPackage: AndroidClassName {
    public init () {
        super.init("com/google/android")
    }
}

extension AndroidClassName {
    public static var comGoogleAndroid: ComGoogleAndroidPackage { .init() }
}
