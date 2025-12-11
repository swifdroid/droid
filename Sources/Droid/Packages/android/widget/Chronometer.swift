//
//  Chronometer.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ChronometerClass: JClassName, @unchecked Sendable {}
    public var Chronometer: ChronometerClass { .init(parent: self, name: "Chronometer") }
}

open class Chronometer: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
