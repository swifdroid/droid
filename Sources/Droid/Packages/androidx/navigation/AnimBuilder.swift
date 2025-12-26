//
//  AnimBuilder.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

/// DSL for setting custom Animation or Animator resources on a NavOptionsBuilder
///
/// [Learn more](https://developer.android.com/reference/androidx/navigation/AnimBuilder)
@MainActor
public final class AnimBuilder: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "androidx/navigation/AnimBuilder" }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }

    public init? () {
        guard
            let clazz = JClass.load(AnimBuilder.className),
            let global = clazz.newObject()
        else { return nil }
        self.object = global
    }
}

extension AnimBuilder {
    /// The custom Animation or Animator resource for the enter animation.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func enter() -> Int32? {
        callIntMethod(name: "getEnter")
    }

    /// The custom Animation or Animator resource for the exit animation.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func exit() -> Int32? {
        callIntMethod(name: "getExit")
    }

    /// The custom Animation or Animator resource for the enter animation when popping off the back stack.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func popEnter() -> Int32? {
        callIntMethod(name: "getPopEnter")
    }

    /// The custom Animation or Animator resource for the exit animation when popping off the back stack.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func popExit() -> Int32? {
        callIntMethod(name: "getPopExit")
    }

    /// The custom Animation or Animator resource for the enter animation.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func enter(_ enter: Int32) -> Self {
        callVoidMethod(name: "setEnter", args: enter)
        return self
    }

    /// The custom Animation or Animator resource for the exit animation.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func exit(_ exit: Int32) -> Self {
        callVoidMethod(name: "setExit", args: exit)
        return self
    }

    /// The custom Animation or Animator resource for the enter animation when popping off the back stack.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func popEnter(_ popEnter: Int32) -> Self {
        callVoidMethod(name: "setPopEnter", args: popEnter)
        return self
    }

    /// The custom Animation or Animator resource for the exit animation when popping off the back stack.
    /// 
    /// Note: Animator resources are not supported for navigating to a new Activity
    public func popExit(_ popExit: Int32) -> Self {
        callVoidMethod(name: "setPopExit", args: popExit)
        return self
    }
}