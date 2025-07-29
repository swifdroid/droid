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
}
