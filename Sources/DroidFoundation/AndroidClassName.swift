//
//  AndroidClassName.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

open class AndroidClassName {
    public let name: String
    
    public init (_ name: String) {
        self.name = name
    }
    
    public init (superClass: AndroidClassName, _ name: String) {
        self.name = "\(superClass.name)/\(name)"
    }
    
    public init (superClass: AndroidClassName, subclass: String) {
        self.name = "\(superClass.name)$\(subclass)"
    }
}

extension Array where Element == AndroidClassName {
    /// Android full path to class name
    /// e.g.: `android/widget/LinearLayout`
    public var path: String { map { $0.name }.joined(separator: "/") }
}
