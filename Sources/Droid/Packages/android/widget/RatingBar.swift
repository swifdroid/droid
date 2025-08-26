//
//  RatingBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class RatingBarClass: JClassName, @unchecked Sendable {}
    public var RatingBar: RatingBarClass { .init(parent: self, name: "RatingBar") }
}

open class RatingBar: AbsSeekBar, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
