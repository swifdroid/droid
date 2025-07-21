//
//  AndroidXPackage.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

public class AndroidXPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "androidx")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "androidx")
    }
}

extension JClassName {
    public static var androidx: AndroidXPackage { .init() }
}
