//
//  MaterialChipPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ChipPackage: AndroidClassName {}
    
    public var chip: ChipPackage { .init(superClass: self, "chip") }
}
