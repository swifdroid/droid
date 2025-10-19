//
//  Checkable.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

#if os(Android)
@MainActor
#endif
public protocol Checkable: ViewInstanceable {
    func checked(_ checked: Bool)
    func isChecked() -> Bool
    func toggle()
}

extension Checkable {
    public func checked(_ checked: Bool) {
        instance?.callVoidMethod(name: "setChecked", args: [checked])
    }

    public func isChecked() -> Bool {
        instance?.callBoolMethod(name: "isChecked") ?? false
    }

    public func toggle() {
        instance?.callVoidMethod(name: "toggle")
    }
}