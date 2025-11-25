//
//  ViewPropertyProtocols.swift
//  Droid
//
//  Created by Mihael Isaev on 15.08.2025.
//

// MARK: SetTextable

fileprivate extension ViewPropertyKey {
    static let setText: Self = "setText"
}
protocol _SetTextable: SetTextable, _AnyView {
    var textState: State<String>? { get set }
}
@MainActor
public protocol SetTextable {}
extension SetTextable {
    /// Set the text, you can use `String` and `State<String>`
    @discardableResult
    public func text<S>(_ value: S) -> Self where S: StateValuable, S.Value == String {
        guard let s = self as? _SetTextable else { return self }
        if let state = s.textState, let s = self as? StatesHolder {
            s.releaseState(state) // Release previous state listeners
        }
        if let state = value.stateValue {
            s.textState = state
        } else {
            s.textState = .init(wrappedValue: value.simpleValue)
        }
        SetTextViewProperty(s).applyOrAppend(nil, s)
        return self
    }
}
fileprivate final class SetTextViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setText
    weak var value: _SetTextable?
    init (_ value: _SetTextable) { self.value = value }
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let textState = value?.textState
        else { return }
        instance.setText(env, textState.wrappedValue)
        textState.listen { [weak instance] old, new in
            guard old != new else { return }
            instance?.setText(env, new)
        }.hold(in: instance)
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