//
//  AppKitPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

public class AppKitPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "stream/swift/droid/appkit")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "stream/swift/droid/appkit")
    }
}

extension AppKitPackage {
    public class CallbacksPackage: JClassName, @unchecked Sendable {}
    public var callbacks: CallbacksPackage { .init(parent: self, name: "callbacks") }
    public class ListenersPackage: JClassName, @unchecked Sendable {}
    public var listeners: ListenersPackage { .init(parent: self, name: "listeners") }
}

extension JClassName {
    static var appKit: AppKitPackage { .init() }
}
