//
//  AndroidGraphicsPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class GraphicsPackage: AndroidClassName {}
    
    public var graphics: GraphicsPackage { .init(superClass: self, "graphics") }
}
