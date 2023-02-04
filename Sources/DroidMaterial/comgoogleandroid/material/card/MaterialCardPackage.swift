//
//  MaterialCardPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension ComGoogleAndroidPackage.MaterialPackage {
    public class CardPackage: AndroidClassName {}
    
    public var card: CardPackage { .init(superClass: self, "card") }
}
