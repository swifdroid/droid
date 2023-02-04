//
//  AndroidWidgetInlinePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidPackage.WidgetPackage {
    public class InlinePackage: AndroidClassName {}
    
    public var inline: InlinePackage { .init(superClass: self, "inline") }
}
