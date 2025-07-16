//
//  MaterialChipPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ChipPackage: JClassName, @unchecked Sendable {}
    
    public var chip: ChipPackage { .init(parent: self, name: "chip") }
}
