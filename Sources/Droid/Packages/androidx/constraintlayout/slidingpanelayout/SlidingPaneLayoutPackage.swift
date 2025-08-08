//
//  SlidingPaneLayoutPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage {
    public class SlidingPaneLayoutPackage: JClassName, @unchecked Sendable {}
    public var slidingpanelayout: SlidingPaneLayoutPackage { .init(parent: self, name: "slidingpanelayout") }
}