//
//  TextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class TextViewClass: JClassName, @unchecked Sendable {}
    public var TextView: TextViewClass { .init(parent: self, name: "TextView") }
}

open class TextView: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.TextView }

    var textState: State<String>?

    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public init(_ text: String? = nil) {
        if let text {
            textState = State(wrappedValue: text)
        }
        super.init()
        applyTextState()
    }

    @discardableResult
    public init(_ state: State<String>) {
        textState = state
        super.init()
        applyTextState()
    }

    func applyTextState() {
        guard let textState else { return }
        text(textState.wrappedValue)
        textState.listen { [weak self] old, new in
            guard old != new else { return }
            self?.text(new)
        }
    }
}

// MARK: SetText

extension ViewPropertyKey {
    static let setText: Self = "setText"
}
struct SetTextViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setText
    let value: TextView
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let textState = value.textState
        else { return }
        instance.setText(env, textState.wrappedValue)
        #endif
    }
}
extension TextView {
    @discardableResult
    public func text(_ value: String) -> Self {
        textState?.removeAllListeners()
        textState = .init(wrappedValue: value)
        return SetTextViewProperty(value: self).applyOrAppend(nil, self)
    }
    @discardableResult
    public func text(_ value: State<String>) -> Self {
        textState?.removeAllListeners()
        textState = value
        return SetTextViewProperty(value: self).applyOrAppend(nil, self)
    }
}
extension TextView.ViewInstance {
    fileprivate func setText(_ env: JEnv?, _ text: String) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: text)
        else { return }
        callVoidMethod(env, name: "setText", args: string.object.signed(as: .java.lang.CharSequence))
        #endif
    }
}

// MARK: Gravity

extension TextView {
    @discardableResult
    public func gravity(_ value: Gravity) -> Self {
        GravityViewProperty(value: value).applyOrAppend(nil, self)
    }
}
