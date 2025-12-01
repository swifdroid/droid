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

// MARK: SetTitleable

fileprivate extension ViewPropertyKey {
    static let setTitle: Self = "setTitle"
}
protocol _SetTitleable: SetTitleable, _AnyView {
    var titleState: State<String>? { get set }
}
@MainActor
public protocol SetTitleable {}
extension SetTitleable {
    /// Set the title text, you can use `String` and `State<String>`
    @discardableResult
    public func title<S>(_ value: S) -> Self where S: StateValuable, S.Value == String {
        guard let s = self as? _SetTitleable else { return self }
        if let state = s.titleState, let s = self as? StatesHolder {
            s.releaseState(state) // Release previous state listeners
        }
        if let state = value.stateValue {
            s.titleState = state
        } else {
            s.titleState = .init(wrappedValue: value.simpleValue)
        }
        SetTitleViewProperty(s).applyOrAppend(nil, s)
        return self
    }
}
fileprivate final class SetTitleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTitle
    weak var value: _SetTitleable?
    init (_ value: _SetTitleable) { self.value = value }
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let titleState = value?.titleState
        else { return }
        instance.setTitle(env, titleState.wrappedValue)
        titleState.listen { [weak instance] old, new in
            guard old != new else { return }
            instance?.setTitle(env, new)
        }.hold(in: instance)
        #endif
    }
}
fileprivate extension View.ViewInstance {
    func setTitle(_ env: JEnv?, _ text: String) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: text)
        else { return }
        callVoidMethod(env, name: "setTitle", args: string.object.signed(as: .java.lang.CharSequence))
        #endif
    }
}

// MARK: SetSubtitleable

fileprivate extension ViewPropertyKey {
    static let setSubtitle: Self = "setSubtitle"
}
protocol _SetSubtitleable: SetSubtitleable, _AnyView {
    var subtitleState: State<String>? { get set }
}
@MainActor
public protocol SetSubtitleable {}
extension SetSubtitleable {
    /// Set the subtitle text, you can use `String` and `State<String>`
    @discardableResult
    public func subtitle<S>(_ value: S) -> Self where S: StateValuable, S.Value == String {
        guard let s = self as? _SetSubtitleable else { return self }
        if let state = s.subtitleState, let s = self as? StatesHolder {
            s.releaseState(state) // Release previous state listeners
        }
        if let state = value.stateValue {
            s.subtitleState = state
        } else {
            s.subtitleState = .init(wrappedValue: value.simpleValue)
        }
        SetSubtitleViewProperty(s).applyOrAppend(nil, s)
        return self
    }
}
fileprivate final class SetSubtitleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSubtitle
    weak var value: _SetSubtitleable?
    init (_ value: _SetSubtitleable) { self.value = value }
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let subtitleState = value?.subtitleState
        else { return }
        instance.setSubtitle(env, subtitleState.wrappedValue)
        subtitleState.listen { [weak instance] old, new in
            guard old != new else { return }
            instance?.setSubtitle(env, new)
        }.hold(in: instance)
        #endif
    }
}
fileprivate extension View.ViewInstance {
    func setSubtitle(_ env: JEnv?, _ text: String) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: text)
        else { return }
        callVoidMethod(env, name: "setSubtitle", args: string.object.signed(as: .java.lang.CharSequence))
        #endif
    }
}