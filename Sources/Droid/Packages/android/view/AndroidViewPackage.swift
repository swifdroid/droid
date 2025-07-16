//
//  AndroidViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class ViewPackage: JClassName, @unchecked Sendable {}
    
    public var view: ViewPackage { .init(parent: self, name: "view") }
}
