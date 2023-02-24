//
//  MaterialAppBarPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class AppBarPackage: AndroidClassName {}
    
    public var appbar: AppBarPackage { .init(superClass: self, "appbar") }
}
