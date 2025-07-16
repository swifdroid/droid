//
//  RecyclerViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class RecyclerViewPackage: JClassName, @unchecked Sendable {}
    
    public var recyclerview: RecyclerViewPackage { .init(parent: self, name: "recyclerview") }
}
