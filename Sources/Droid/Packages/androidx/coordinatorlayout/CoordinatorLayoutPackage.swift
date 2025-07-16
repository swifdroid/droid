//
//  CoordinatorLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class CoordinatorLayoutPackage: JClassName, @unchecked Sendable {}
    
    public var coordinatorlayout: CoordinatorLayoutPackage { .init(parent: self, name: "coordinatorlayout") }
}
