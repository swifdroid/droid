//
//  String+CString.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import Foundation
import CDroidJNI

extension String {
    public var cString: UnsafePointer<Int8> {
        var pointer: UnsafePointer<Int8>!
        let group = DispatchGroup()
        group.enter()
        withCString {
            pointer = $0
            group.leave()
        }
        group.wait()
        return pointer
    }
}
