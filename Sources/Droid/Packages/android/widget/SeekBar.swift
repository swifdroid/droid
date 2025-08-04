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

open class SeekBar: AbsSeekBar, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
    
    public func setOnSeekBarChangeListener(_ listener: JClass) {
        // callVoidWithMethod("setOnSeekBarChangeListener", .object(.android.widget.SeekBarOnSeekBarChangeListener) / listener)
    }
    
    public func setProgress(_ value: Int) {
        // callVoidWithMethod("setProgress", .int(value))
    }
    
    public func setProgress(_ value: Int, animated: Bool) {
        // callVoidWithMethod("setProgress", .int(value), .boolean(animated))
    }
}
