//
//  MaterialCircularRevealCardViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CardViewPackage: JClassName, @unchecked Sendable {}
    
    public var cardview: CardViewPackage { .init(parent: self, name: "cardview") }
}
