//
//  JavaPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

public class JavaPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "java")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "java")
    }
}

extension JClassName {
    public static var java: JavaPackage { .init() }
}
