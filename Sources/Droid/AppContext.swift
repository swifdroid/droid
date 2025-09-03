//
//  AppContext.swift
//  Droid
//
//  Created by Mihael Isaev on 01.09.2025.
//

public final class AppContext: JObjectable, JClassLoadable, @unchecked Sendable {
    static var shared: AppContext { DroidApp.shared.context }
    
    public static let className: JClassName = "android/content/Context"

    public let object: JObject

    public var cachedClassLoader: JClassLoader? = nil

    public init (_ object: JObject) {
        self.object = object
    }
}