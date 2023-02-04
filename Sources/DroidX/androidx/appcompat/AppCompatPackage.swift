//
//  AppCompatPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class AppCompatPackage: AndroidClassName {}
    
    public var appcompat: AppCompatPackage { .init(superClass: self, "appcompat") }
}
