//
//  TextWatcher.swift
//  Droid
//
//  Created by Mihael Isaev on 27.01.2022.
//

import DroidFoundation
import FoundationEssentials

extension SwiftPackage {
    public class TextWatcherClass: JClassName, @unchecked Sendable {}
    
    public var TextWatcher: TextWatcherClass { .init(parent: self, name: "NativeTextWatcher") }
}

// var _nativeTextWatchers: [NativeTextWatcher] = []

// class NativeTextWatcher: @unchecked Sendable, JObjectable {
//     init (_ environment: JEnvironment, _ context: JObjectReference) {
//         super.init(environment, context, classes: [.swift.TextWatcher], args: [])
//         _nativeTextWatchers.append(self)
//     }
    
//     required init(_ environment: JEnvironment, _ ref: JClassReference, _ object: jobject) {
//         super.init(environment, ref, object)
//         _nativeTextWatchers.append(self)
//     }
    
//     deinit {
//         _nativeTextWatchers.removeAll(where: { $0 === self })
//     }
    
//     var _beforeTextChanged: (String, Int, Int, Int) -> Void = { _,_,_,_ in }
    
//     public func beforeTextChanged(_ handler: @escaping (_ text: String, _ start: Int, _ count: Int, _ after: Int) -> Void) -> Self {
//         _beforeTextChanged = handler
//         return self
//     }
    
//     var _onTextChanged: (String, Int, Int, Int) -> Void = { _,_,_,_ in }
    
//     public func onTextChanged(_ handler: @escaping (_ text: String, _ start: Int, _ before: Int, _ count: Int) -> Void) -> Self {
//         _onTextChanged = handler
//         return self
//     }
    
//     var _afterTextChanged: (String) -> Void = { _ in }
    
//     public func afterTextChanged(_ handler: @escaping (_ text: String) -> Void) -> Self {
//         _afterTextChanged = handler
//         return self
//     }
// }

// @_cdecl("Java_swift_NativeTextWatcher_beforeTextChanged")
// public func text_watcher_beforeTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, spannableStringBuilder: jobject, start: jint, count: jint, after: jint) {
//     let env = JEnvironment(env)
//     let sss = SpannableStringBuilder(env, JClassReference(env, [.android.text.SpannableStringBuilder]), spannableStringBuilder)
//     _nativeTextWatchers.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._beforeTextChanged(sss.toString(), Int(start), Int(count), Int(after))
// }

// @_cdecl("Java_swift_NativeTextWatcher_onTextChanged")
// public func text_watcher_onTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, spannableStringBuilder: jobject, start: jint, before: jint, count: jint) {
//     let env = JEnvironment(env)
//     let sss = SpannableStringBuilder(env, JClassReference(env, [.android.text.SpannableStringBuilder]), spannableStringBuilder)
//     _nativeTextWatchers.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._onTextChanged(sss.toString(), Int(start), Int(before), Int(count))
// }

// @_cdecl("Java_swift_NativeTextWatcher_afterTextChanged")
// public func text_watcher_afterTextChanged(env: UnsafeMutablePointer<JNIEnv?>, callerClassObject: jobject, spannableStringBuilder: jobject) {
//     let env = JEnvironment(env)
//     let sss = SpannableStringBuilder(env, JClassReference(env, [.android.text.SpannableStringBuilder]), spannableStringBuilder)
//     _nativeTextWatchers.first(where: { env.isSameObject($0.classObject, callerClassObject) })?._afterTextChanged(sss.toString())
// }
