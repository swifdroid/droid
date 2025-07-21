//
//  ConstraintLayoutHelperPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage {
    public class HelperPackage: JClassName, @unchecked Sendable {}
    
    public var helper: HelperPackage { .init(parent: self, name: "helper") }
}
