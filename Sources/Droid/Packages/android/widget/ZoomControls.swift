//
//  ZoomControls.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ZoomControlsClass: JClassName, @unchecked Sendable {}
    public var ZoomControls: ZoomControlsClass { .init(parent: self, name: "ZoomControls") }
}

open class ZoomControls: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
