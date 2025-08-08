//
//  ConstraintLayoutMotionPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.ConstraintLayoutPackage {
    public class MotionPackage: JClassName, @unchecked Sendable {}
    public var motion: MotionPackage { .init(parent: self, name: "motion") }
}
