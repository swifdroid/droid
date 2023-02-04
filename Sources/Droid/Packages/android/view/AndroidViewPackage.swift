//
//  AndroidViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class ViewPackage: AndroidClassName {}
    
    public var view: ViewPackage { .init(superClass: self, "view") }
}
