//
//  CardViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidXPackage {
    public class CardViewPackage: JClassName, @unchecked Sendable {}
    
    public var cardview: CardViewPackage { .init(parent: self, name: "cardview") }
}
