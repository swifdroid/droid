//
//  FragmentAppPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.FragmentPackage {
    public class AppPackage: AndroidClassName {}
    
    public var app: AppPackage { .init(superClass: self, "app") }
}
