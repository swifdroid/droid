//
//  AndroidSupportPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class SupportPackage: JClassName, @unchecked Sendable {}
    
    public var support: SupportPackage { .init(parent: self, name: "support") }
}