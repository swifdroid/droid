//
//  NativeOnSeekBarChangeListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension SwiftPackage {
    public class OnSeekBarChangeListenerClass: AndroidClassName {}
    
    public var OnSeekBarChangeListener: OnSeekBarChangeListenerClass { .init(superClass: self, "NativeOnSeekBarChangeListener") }
}

var _nativeOnSeekBarChangeListeners: [NativeOnSeekBarChangeListener] = []

class NativeOnSeekBarChangeListener: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.swift.OnSeekBarChangeListener], args: [])
        _nativeOnSeekBarChangeListeners.append(self)
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
        _nativeOnSeekBarChangeListeners.append(self)
    }
    
    deinit {
        _nativeOnSeekBarChangeListeners.removeAll(where: { $0 === self })
    }
    
    var _onProgressChanged: (Int, Bool) -> Void = { _,_ in }
    
    @discardableResult
    public func onProgressChanged(_ handler: @escaping (_ progress: Int, _ fromUser: Bool) -> Void) -> Self {
        _onProgressChanged = handler
        return self
    }
    
    var _onStartTrackingTouch: () -> Void = {}
    
    @discardableResult
    public func onStartTrackingTouch(_ handler: @escaping () -> Void) -> Self {
        _onStartTrackingTouch = handler
        return self
    }
    
    var _onStopTrackingTouch: () -> Void = {}
    
    @discardableResult
    public func onStopTrackingTouch(_ handler: @escaping () -> Void) -> Self {
        _onStopTrackingTouch = handler
        return self
    }
}

@_cdecl("Java_swift_NativeOnSeekBarChangeListener_onProgressChanged")
public func on_seekbar_change_listener_onProgressChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, seekbar: jobject, progress: jint, fromUser: jboolean) {
    let env = JEnvironment(env)
    _nativeOnSeekBarChangeListeners.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._onProgressChanged(Int(progress), fromUser == 1)
}

@_cdecl("Java_swift_NativeOnSeekBarChangeListener_onStartTrackingTouch")
public func on_seekbar_change_listener_onStartTrackingTouch(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, seekbar: jobject) {
    let env = JEnvironment(env)
    _nativeOnSeekBarChangeListeners.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._onStartTrackingTouch()
}

@_cdecl("Java_swift_NativeOnSeekBarChangeListener_onStopTrackingTouch")
public func on_seekbar_change_listener_onStopTrackingTouch(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, seekbar: jobject) {
    let env = JEnvironment(env)
    _nativeOnSeekBarChangeListeners.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._onStopTrackingTouch()
}
