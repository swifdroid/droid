//
//  MaterialProgressIndicatorPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class ProgressIndicatorPackage: JClassName, @unchecked Sendable {}
    
    public var progressindicator: ProgressIndicatorPackage { .init(parent: self, name: "progressindicator") }
}
