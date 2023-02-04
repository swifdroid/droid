//
//  MaterialCircularRevealCoordinatorLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CoordinatorLayoutPackage: AndroidClassName {}
    
    public var coordinatorlayout: CoordinatorLayoutPackage { .init(superClass: self, "coordinatorlayout") }
}
