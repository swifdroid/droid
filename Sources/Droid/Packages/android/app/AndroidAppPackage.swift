//
//  AndroidAppPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class AppPackage: JClassName, @unchecked Sendable {}
    
    public var app: AppPackage { .init(parent: self, name: "app") }
}
