//
//  CorePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class CorePackage: JClassName, @unchecked Sendable {}
    
    public var core: CorePackage { .init(parent: self, name: "core") }
}
