//
//  MaterialCardPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CardPackage: JClassName, @unchecked Sendable {}
    
    public var card: CardPackage { .init(parent: self, name: "card") }
}
