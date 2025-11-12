//
//  AndroidPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

@MainActor
public struct android: ~Copyable {
    public static let R = InnerR(JClassName.android)
}

public class AndroidPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "android")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "android")
    }
}

extension JClassName {
    public static var android: AndroidPackage { .init() }
}
