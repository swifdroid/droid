//
//  AppLifecycle.swift
//  
//
//  Created by Mihael Isaev on 27.10.2021.
//

public final class AppLifecycle {
    private init () {}
    
    // MARK: Finish Launching

    var _didFinishLaunching: [() -> Void] = []
    
    /// Called when app just started
    public func didFinishLaunching(_ handler: @escaping () -> Void) -> Self {
        _didFinishLaunching.append(handler)
        return self
    }
    
    /// Called when app just started
    public static func didFinishLaunching(_ handler: @escaping () -> Void) -> Self {
        Self().didFinishLaunching(handler)
    }
    
    // MARK: Will Terminate
    
    var _willTerminate: [() -> Void] = []
    
    /// Called when app is going to die
    public func willTerminate(_ handler: @escaping () -> Void) -> Self {
        _willTerminate.append(handler)
        return self
    }
    
    /// Called when app is going to die
    public static func willTerminate(_ handler: @escaping () -> Void) -> Self {
        Self().willTerminate(handler)
    }
    
    // MARK: Become Active
    
    var _didBecomeActive: [() -> Void] = []
    
    /// Called when window is active
    public func didBecomeActive(_ handler: @escaping () -> Void) -> Self {
        _didBecomeActive.append(handler)
        return self
    }
    
    /// Called when window is active
    public static func didBecomeActive(_ handler: @escaping () -> Void) -> Self {
        Self().didBecomeActive(handler)
    }
    
    // MARK: Resign Active

    var _willResignActive: [() -> Void] = []
    
    /// Called when window is not active
    public func willResignActive(_ handler: @escaping () -> Void) -> Self {
        _willResignActive.append(handler)
        return self
    }
    
    /// Called when window is not active
    public static func willResignActive(_ handler: @escaping () -> Void) -> Self {
        Self().willResignActive(handler)
    }
    
    // MARK: Did Enter Background
    
    var _didEnterBackground: [() -> Void] = []
    
    /// Called when app is actually in background or when user started switching apps
    public func didEnterBackground(_ handler: @escaping () -> Void) -> Self {
        _didEnterBackground.append(handler)
        return self
    }
    
    /// Called when app is actually in background or when user started switching apps
    public static func didEnterBackground(_ handler: @escaping () -> Void) -> Self {
        Self().didEnterBackground(handler)
    }
    
    // MARK: Will Enter Foreground

    var _willEnterForeground: [() -> Void] = []
    
    /// Called when app is going into foreground, e.g. user switch back to the app or app is just started
    public func willEnterForeground(_ handler: @escaping () -> Void) -> Self {
        _willEnterForeground.append(handler)
        return self
    }
    
    /// Called when app is going into foreground, e.g. user switch back to the app or app is just started
    public static func willEnterForeground(_ handler: @escaping () -> Void) -> Self {
        Self().willEnterForeground(handler)
    }
}
