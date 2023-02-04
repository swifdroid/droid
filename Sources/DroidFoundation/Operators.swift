//
//  Operators.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import Foundation

public func /(lhs: AndroidClassName, rhs: AndroidClassName) -> AndroidClassName {
    .init("\(lhs.name)/\(rhs.name)")
}

public func /(lhs: MethodSignatureItem, rhs: JValuable) -> JArgument {
    .init(lhs, value: rhs)
}
