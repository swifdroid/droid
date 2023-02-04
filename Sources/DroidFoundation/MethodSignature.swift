//
//  MethodSignature.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

public class MethodSignature {
    public let signature: String
    
    public init (_ items: MethodSignatureItem..., returning: MethodSignatureItem) {
        self.signature = "(" + items.map { $0.signature }.joined() + ")" + returning.signature
    }
}
