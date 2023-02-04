//
//  NativeOnClickListener.swift
//  
//
//  Created by Mihael Isaev on 29.01.2022.
//

import DroidFoundation
import Foundation
import CDroidJNI

extension SwiftPackage {
    public class OnClickListenerClass: AndroidClassName {}
    
    public var OnClickListener: OnClickListenerClass { .init(superClass: self, "NativeOnClickListener") }
}

var _nativeOnClickListeners: [NativeOnClickListener] = []

class NativeOnClickListener: JClass {
    init (_ environment: JEnvironment, _ context: JObjectReference) {
        super.init(environment, context, classes: [.swift.OnClickListener], args: [])
        _nativeOnClickListeners.append(self)
    }
    
    required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
        super.init(environment, ref, object)
        _nativeOnClickListeners.append(self)
    }
    
    deinit {
        _nativeOnClickListeners.removeAll(where: { $0 === self })
    }
    
    var _onClick: () -> Void = {}
    
    public func onClick(_ handler: @escaping () -> Void) -> Self {
        _onClick = handler
        return self
    }
}

@_cdecl("Java_swift_NativeOnClickListener_onClick")
public func on_click_listener_onClick(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, view: jobject) {
    let env = JEnvironment(env)
    _nativeOnClickListeners.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._onClick()
}
