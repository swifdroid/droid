//
//  AndroidGraphicsPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class GraphicsPackage: JClassName, @unchecked Sendable {}
    
    public var graphics: GraphicsPackage { .init(parent: self, name: "graphics") }
}
