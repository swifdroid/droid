//
//  FragmentAppPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.FragmentPackage {
    public class AppPackage: JClassName, @unchecked Sendable {}
    
    public var app: AppPackage { .init(parent: self, name: "app") }
}
