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

open class CalendarView: FrameLayout {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.CalendarView }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}
