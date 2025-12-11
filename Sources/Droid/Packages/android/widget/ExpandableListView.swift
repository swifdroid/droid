//
//  ExpandableListView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ExpandableListViewClass: JClassName, @unchecked Sendable {}
    public var ExpandableListView: ExpandableListViewClass { .init(parent: self, name: "ExpandableListView") }
}

/// A view that shows items in a vertically scrolling two-level list.
/// 
/// This differs from the ListView by allowing two levels: groups which can individually be expanded to show its children.
/// 
/// The items come from the ExpandableListAdapter associated with this view.
/// 
/// [Learn more](https://developer.android.com/reference/android/widget/ExpandableListView)
open class ExpandableListView: View {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    // TODO
}
