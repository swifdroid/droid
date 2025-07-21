//
//  SwiftPackage.swift
//  
//
//  Created by Mihael Isaev on 28.01.2022.
//

public class SwiftPackage: JClassName, @unchecked Sendable {
    public init () {
        super.init(stringLiteral: "stream/swift/android")
    }

    required init(stringLiteral: String) {
        super.init(stringLiteral: "stream/swift/android")
    }
}

extension JClassName {
    public static var swift: SwiftPackage { .init() }
}
