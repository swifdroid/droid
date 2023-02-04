//
//  AndroidContentPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage {
    public class ContentPackage: AndroidClassName {}
    
    public var content: ContentPackage { .init(superClass: self, "content") }
}
