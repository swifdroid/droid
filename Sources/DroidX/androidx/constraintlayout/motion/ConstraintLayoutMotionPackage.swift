//
//  ConstraintLayoutMotionPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.ConstraintLayoutPackage {
    public class MotionPackage: AndroidClassName {}
    
    public var motion: MotionPackage { .init(superClass: self, "motion") }
}
