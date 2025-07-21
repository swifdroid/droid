//
//  ConstraintLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class ConstraintLayoutPackage: JClassName, @unchecked Sendable {}
    
    public var constraintlayout: ConstraintLayoutPackage { .init(parent: self, name: "constraintlayout") }
}
