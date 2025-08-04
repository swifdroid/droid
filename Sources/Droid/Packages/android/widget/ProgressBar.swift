//
//  ProgressBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class ProgressBarClass: JClassName, @unchecked Sendable {}    
    public var ProgressBar: ProgressBarClass { .init(parent: self, name: "ProgressBar") }
}

open class ProgressBar: View, @unchecked Sendable {
    /// The JNI class name
    public override class var className: JClassName { .android.widget.ProgressBar }

    @discardableResult
    public override init() {
        super.init()
    }
}
