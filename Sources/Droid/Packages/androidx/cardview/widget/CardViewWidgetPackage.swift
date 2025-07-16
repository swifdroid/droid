//
//  CardViewWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

import DroidFoundation

extension AndroidXPackage.CardViewPackage {
    public class WidgetPackage: JClassName, @unchecked Sendable {}
    
    public var widget: WidgetPackage { .init(parent: self, name: "widget") }
}
