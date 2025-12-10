//
//  BadgePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 9.12.2025.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class BadgePackage: JClassName, @unchecked Sendable {}
    
    public var badge: BadgePackage { .init(parent: self, name: "badge") }
}