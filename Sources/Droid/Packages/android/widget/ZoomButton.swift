//
//  ZoomButton.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ZoomButtonClass: JClassName, @unchecked Sendable {}
    public var ZoomButton: ZoomButtonClass { .init(parent: self, name: "ZoomButton") }
}

open class ZoomButton: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
