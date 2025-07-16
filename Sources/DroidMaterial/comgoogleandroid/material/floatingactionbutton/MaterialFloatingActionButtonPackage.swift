//
//  MaterialFloatingActionButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class FloatingActionButtonPackage: JClassName, @unchecked Sendable {}
    
    public var floatingactionbutton: FloatingActionButtonPackage { .init(parent: self, name: "floatingactionbutton") }
}
