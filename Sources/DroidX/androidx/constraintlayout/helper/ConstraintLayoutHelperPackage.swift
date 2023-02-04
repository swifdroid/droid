//
//  ConstraintLayoutHelperPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage {
    public class HelperPackage: AndroidClassName {}
    
    public var helper: HelperPackage { .init(superClass: self, "helper") }
}
