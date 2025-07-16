//
//  CardViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class CardViewPackage: JClassName, @unchecked Sendable {}
    
    public var cardview: CardViewPackage { .init(parent: self, name: "cardview") }
}
