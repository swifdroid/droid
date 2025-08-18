//
//  ViewPropertyProtocols.swift
//  Droid
//
//  Created by Mihael Isaev on 15.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

// MARK: SetTextable

fileprivate extension ViewPropertyKey {
    static let setText: Self = "setText"
}
protocol _SetTextable: SetTextable, _AnyView {
    var textState: State<String>? { get set }
}
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public protocol SetTextable {}
extension SetTextable {
    @discardableResult
    public func text(_ value: String) -> Self {
        guard let s = self as? _SetTextable else { return self }
        s.textState?.removeAllListeners()
        s.textState = .init(wrappedValue: value)
        SetTextViewProperty(value: s).applyOrAppend(nil, s)
        return self
    }
    @discardableResult
    public func text(_ value: State<String>) -> Self {
        guard let s = self as? _SetTextable else { return self }
        s.textState?.removeAllListeners()
        s.textState = value
        SetTextViewProperty(value: s).applyOrAppend(nil, s)
        return self
    }
}
fileprivate struct SetTextViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setText
    let value: _SetTextable
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let textState = value.textState
        else { return }
        instance.setText(env, textState.wrappedValue)
        #endif
    }
}
fileprivate extension View.ViewInstance {
    func setText(_ env: JEnv?, _ text: String) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: text)
        else { return }
        callVoidMethod(env, name: "setText", args: string.object.signed(as: .java.lang.CharSequence))
        #endif
    }
}