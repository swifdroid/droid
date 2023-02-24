//
//  MaterialFloatingActionButtonPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class FloatingActionButtonPackage: AndroidClassName {}
    
    public var floatingactionbutton: FloatingActionButtonPackage { .init(superClass: self, "floatingactionbutton") }
}
