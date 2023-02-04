//
//  RecyclerViewPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage {
    public class RecyclerViewPackage: AndroidClassName {}
    
    public var recyclerview: RecyclerViewPackage { .init(superClass: self, "recyclerview") }
}
