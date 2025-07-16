//
//  ConstraintLayoutUtilsPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage {
    public class UtilsPackage: JClassName, @unchecked Sendable {}
    
    public var utils: UtilsPackage { .init(parent: self, name: "utils") }
}
