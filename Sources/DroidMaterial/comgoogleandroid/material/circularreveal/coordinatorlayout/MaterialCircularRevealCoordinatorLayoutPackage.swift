//
//  MaterialCircularRevealCoordinatorLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CoordinatorLayoutPackage: JClassName, @unchecked Sendable {}
    
    public var coordinatorlayout: CoordinatorLayoutPackage { .init(parent: self, name: "coordinatorlayout") }
}
