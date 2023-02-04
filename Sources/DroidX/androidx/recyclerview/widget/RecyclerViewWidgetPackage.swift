//
//  RecyclerViewWidgetPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidXPackage.RecyclerViewPackage {
    public class WidgetPackage: AndroidClassName {}
    
    public var widget: WidgetPackage { .init(superClass: self, "widget") }
}
