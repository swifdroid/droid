//
//  AndroidWidgetInlinePackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation

extension AndroidPackage.WidgetPackage {
    public class InlinePackage: JClassName, @unchecked Sendable {}
    
    public var inline: InlinePackage { .init(parent: self, name: "inline") }
}
