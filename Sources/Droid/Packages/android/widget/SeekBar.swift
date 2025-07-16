// //
// //  SeekBar.swift
// //  Droid
// //
// //  Created by Mihael Isaev on 16.01.2022.
// //

// import DroidFoundation
// import FoundationEssentials
// extension AndroidPackage.WidgetPackage {
//     public class SeekBarClass: JClassName, @unchecked Sendable {}
//     public class SeekBarOnSeekBarChangeListenerInterface: JClassName, @unchecked Sendable {}
    
//     public var SeekBar: SeekBarClass { .init(parent: self, name: "SeekBar") }
//     public var SeekBarOnSeekBarChangeListener: SeekBarOnSeekBarChangeListenerInterface { .init(parent: self, name: "SeekBar$OnSeekBarChangeListener") }
// }

// class SeekBar: View {
//     override init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.android.widget.SeekBar], args: [.object(.android.content.Context) / context])
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//     }
    
//     public func setOnSeekBarChangeListener(_ listener: JClass) {
//         callVoidWithMethod("setOnSeekBarChangeListener", .object(.android.widget.SeekBarOnSeekBarChangeListener) / listener)
//     }
    
//     public func setProgress(_ value: Int) {
//         callVoidWithMethod("setProgress", .int(value))
//     }
    
//     public func setProgress(_ value: Int, animated: Bool) {
//         callVoidWithMethod("setProgress", .int(value), .boolean(animated))
//     }
// }
