//
//  ViewPager2Package.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class ViewPager2Package: JClassName, @unchecked Sendable {}
    
    public var viewpager2: ViewPager2Package { .init(parent: self, name: "viewpager2") }
}
