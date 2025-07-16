//
//  AndroidSupportPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

import DroidFoundation

extension AndroidPackage.SupportPackage {
    public class V7Package: JClassName, @unchecked Sendable {}
    
    public var v7: V7Package { .init(parent: self, name: "v7") }
}