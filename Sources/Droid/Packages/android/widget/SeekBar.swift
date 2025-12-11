//
//  SeekBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class SeekBarClass: JClassName, @unchecked Sendable {}
    public class SeekBarOnSeekBarChangeListenerInterface: JClassName, @unchecked Sendable {}
    
    public var SeekBar: SeekBarClass { .init(parent: self, name: "SeekBar") }
    public var SeekBarOnSeekBarChangeListener: SeekBarOnSeekBarChangeListenerInterface { .init(parent: self, name: "SeekBar$OnSeekBarChangeListener") }
}

open class SeekBar: AbsSeekBar {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
    
    public func onSeekBarChangeListener(_ listener: JClass) {
        // callVoidWithMethod("setOnSeekBarChangeListener", .object(.android.widget.SeekBarOnSeekBarChangeListener) / listener)
    }
    
    public func progress(_ value: Int) {
        // callVoidWithMethod("setProgress", .int(value))
    }
    
    public func progress(_ value: Int, animated: Bool) {
        // callVoidWithMethod("setProgress", .int(value), .boolean(animated))
    }
}
