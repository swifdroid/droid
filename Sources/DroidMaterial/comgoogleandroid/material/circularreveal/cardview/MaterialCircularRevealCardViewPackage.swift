//
//  MaterialCircularRevealCardViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import Droid

extension ComGoogleAndroidPackage.MaterialPackage.CircularRevealPackage {
    public class CardViewPackage: AndroidClassName {}
    
    public var cardview: CardViewPackage { .init(superClass: self, "cardview") }
}
