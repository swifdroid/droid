//
//  CalendarView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class CalendarViewClass: JClassName, @unchecked Sendable {}
    public var CalendarView: CalendarViewClass { .init(parent: self, name: "CalendarView") }
}

open class CalendarView: FrameLayout, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.CalendarView }

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }
}
