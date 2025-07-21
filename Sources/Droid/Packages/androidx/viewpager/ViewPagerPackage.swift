//
//  ViewPagerPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class ViewPagerPackage: JClassName, @unchecked Sendable {}
    
    public var viewpager: ViewPagerPackage { .init(parent: self, name: "viewpager") }
}
