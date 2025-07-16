//
//  GridLayout.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import FoundationEssentials
extension AndroidPackage.WidgetPackage {
    public class GridLayoutClass: JClassName, @unchecked Sendable {}
    
    public var GridLayout: GridLayoutClass { .init(parent: self, name: "GridLayout") }
}

public class GridLayout: View, @unchecked Sendable {
    /// The JNI class name
    public class override var className: JClassName { .android.widget.GridLayout }
}
