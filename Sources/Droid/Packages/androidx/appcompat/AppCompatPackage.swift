//
//  AppCompatPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class AppCompatPackage: JClassName, @unchecked Sendable {}
    
    public var appcompat: AppCompatPackage { .init(parent: self, name: "appcompat") }
}
