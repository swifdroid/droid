//
//  Droid.swift
//  Droid
//
//  Created by Mihael Isaev on 23.10.2021.
//

import CDroidJNI
import Foundation
#if os(Android)
import FoundationNetworking
#endif

class AnyActivity: JClass {
    func setContentView(_ class: JClass) {
        callVoidWithMethod("setContentView", [.object(.android.view.View)], [.object(`class`.reference.classes) / `class`])
    }
}

@_cdecl("Java_swift_App_initialize")
public func initialize(env: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject: jobject) {
    print(.debug, "DROID", "hello from swift13 ♥️")
//    let context = JavaContext(env, appObject, callerObject)
    let env = JEnvironment(env)
    
    let rrr = JObjectReference(callerObject)
	
    let ll = LinearLayout(env, rrr)
    ll.setGravity(17)
	ll.setBackgroundColor(GraphicsColor.magenta)
    ll.setLayoutParams(LayoutParams(env, rrr, width: 800, height: 400))
    
    let ll2 = LinearLayout(env, rrr)
//    let drw = PaintDrawable.init(env, rrr, GraphicsColor.yellow)
//    drw.setCornerRadius(20)
//    ll2.setBackground(drw)
////    ll2.setBackgroundColor(GraphicsColor.yellow)
//    ll2.setLayoutParams(LayoutParams(env, rrr, width: 100, height: 100))
//
    ll.addView(ll2)
    
//    let editText1 = EditText(env, rrr)
//
//    let textWatcher1 = NativeTextWatcher(env, rrr).beforeTextChanged { text, start, count, after in
//        print(.debug, "✍️NativeTextWatcher1", "beforeTextChanged text: \(text) start: \(start) count: \(count) after: \(after)")
//    }.onTextChanged { text, start, before, count in
//        print(.debug, "✍️NativeTextWatcher1", "onTextChanged text: \(text) start: \(start) before: \(before) count: \(count)")
//    }.afterTextChanged { text in
//        print(.debug, "✍️NativeTextWatcher1", "afterTextChanged text: \(text)")
//    }
//    editText1.addTextChangedListener(textWatcher1)
//
//    ll.addView(editText1)
//
//    let editText2 = EditText(env, rrr)
//
//    let textWatcher2 = NativeTextWatcher(env, rrr).beforeTextChanged { text, start, count, after in
//        print(.debug, "✍️NativeTextWatcher2", "beforeTextChanged text: \(text) start: \(start) count: \(count) after: \(after)")
//    }.onTextChanged { text, start, before, count in
//        print(.debug, "✍️NativeTextWatcher2", "onTextChanged text: \(text) start: \(start) before: \(before) count: \(count)")
//    }.afterTextChanged { text in
//        print(.debug, "✍️NativeTextWatcher2", "afterTextChanged text: \(text)")
//    }
//    editText2.addTextChangedListener(textWatcher2)
//
//    ll.addView(editText2)
    
//    let button1 = Button(env, rrr)
//    button1.setText("swift button")
//
//    let listener = NativeOnClickListener(env, rrr).onClick {
//        print(.debug, "🏂NativeOnClickListener", "onClick")
//    }
//
//    button1.setOnClickListener(listener)
//    ll.addView(button1)
    
    let seekbar = SeekBar(env, rrr)
    seekbar.setLayoutParams(LayoutParams(env, rrr, width: 300, height: 50))
    
    let seekbar2 = SeekBar(env, rrr)
    seekbar2.setLayoutParams(LayoutParams(env, rrr, width: 300, height: 50))
    
    let seekListener = NativeOnSeekBarChangeListener(env, rrr)
    seekListener.onProgressChanged { progress, fromUser in
        print(.debug, "🏂NativeOnSeekBarChangeListener", "onProgressChanged progress: \(progress) fromUser: \(fromUser)")
        seekbar2.move(to: env, nil).setProgress(progress)//, animated: true)
    }
    seekbar.setOnSeekBarChangeListener(seekListener)
    
    ll.addView(seekbar)
    ll.addView(seekbar2)
    
    let callerClass = env.getObjectClass(callerObject)
    let activity = AnyActivity(env, JClassReference.init(callerClass!), callerObject)
    activity.setContentView(ll)
    
//    print(.debug, "TESTING", "😎: \(ll)")
    print(.debug, "TESTING", "🥳")
    
    
    
//    DispatchQueue.asyncAfter(deadline: .now() + 4, in: context) { datachedContext in
//        let ll = ll.move(to: datachedContext)
//        ll.setBackgroundColor(GraphicsColor.magenta)
//    }
}

@_cdecl("Java_swift_App_setCallback")
func setCallback(env: UnsafeMutablePointer<JNIEnv?>, me: jobject, classref: jobject) {
    
}
