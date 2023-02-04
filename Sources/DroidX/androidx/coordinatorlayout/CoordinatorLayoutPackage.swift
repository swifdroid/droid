//
//  CoordinatorLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class CoordinatorLayoutPackage: AndroidClassName {}
    
    public var coordinatorlayout: CoordinatorLayoutPackage { .init(superClass: self, "coordinatorlayout") }
}
