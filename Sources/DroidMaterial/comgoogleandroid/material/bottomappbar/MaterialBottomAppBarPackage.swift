//
//  MaterialBottomAppBarPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class BottomAppBarPackage: AndroidClassName {}
    
    public var bottomappbar: BottomAppBarPackage { .init(superClass: self, "bottomappbar") }
}
