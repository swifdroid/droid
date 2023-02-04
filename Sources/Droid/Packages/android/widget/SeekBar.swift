//
//  SeekBar.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension AndroidPackage.WidgetPackage {
    public class SeekBarClass: AndroidClassName {}
    public class SeekBarOnSeekBarChangeListenerInterface: AndroidClassName {}
    
    public var SeekBar: SeekBarClass { .init(superClass: self, "SeekBar") }
    public var SeekBarOnSeekBarChangeListener: SeekBarOnSeekBarChangeListenerInterface { .init(superClass: self, "SeekBar$OnSeekBarChangeListener") }
}

class SeekBar: View {
    override init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.android.widget.SeekBar], args: [.object(.android.content.Context) / context])
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
    }
    
    public func setOnSeekBarChangeListener(_ listener: JClass) {
        callVoidWithMethod("setOnSeekBarChangeListener", .object(.android.widget.SeekBarOnSeekBarChangeListener) / listener)
    }
    
    public func setProgress(_ value: Int) {
        callVoidWithMethod("setProgress", .int(value))
    }
    
    public func setProgress(_ value: Int, animated: Bool) {
        callVoidWithMethod("setProgress", .int(value), .boolean(animated))
    }
}
