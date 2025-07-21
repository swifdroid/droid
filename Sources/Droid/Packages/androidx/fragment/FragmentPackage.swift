//
//  FragmentPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class FragmentPackage: JClassName, @unchecked Sendable {}
    
    public var fragment: FragmentPackage { .init(parent: self, name: "fragment") }
}
