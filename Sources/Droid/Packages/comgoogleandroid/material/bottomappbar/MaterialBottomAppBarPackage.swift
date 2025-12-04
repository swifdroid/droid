//
//  MaterialBottomAppBarPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class BottomAppBarPackage: JClassName, @unchecked Sendable {}
    
    public var bottomappbar: BottomAppBarPackage { .init(parent: self, name: "bottomappbar") }
}
