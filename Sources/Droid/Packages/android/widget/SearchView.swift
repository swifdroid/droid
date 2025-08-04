//
//  SearchView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SearchViewClass: JClassName, @unchecked Sendable {}
    public var SearchView: SearchViewClass { .init(parent: self, name: "SearchView") }
}

open class SearchView: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
