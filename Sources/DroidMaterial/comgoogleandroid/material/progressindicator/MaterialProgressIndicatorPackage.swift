//
//  MaterialProgressIndicatorPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ProgressIndicatorPackage: AndroidClassName {}
    
    public var progressindicator: ProgressIndicatorPackage { .init(superClass: self, "progressindicator") }
}
