//
//  ViewStub.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.ViewPackage {
    public class ViewStubClass: JClassName, @unchecked Sendable {}
    public var ViewStub: ViewStubClass { .init(parent: self, name: "ViewStub") }
}

public class ViewStub: View {
    /// The JNI class name
    public override class var className: JClassName { .android.view.ViewStub }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// MARK: Layout resource

extension ViewStub {
    /// Returns the resource id of the layout to inflate.
    public func layoutResource() -> Int {
        Int(instance?.callIntMethod(name: "getLayoutResource") ?? 0)
    }

    /// Sets the resource id of the layout to inflate when this stub becomes visible.
    @discardableResult
    public func layoutResource(_ value: Int) -> Self {
        instance?.callVoidMethod(name: "setLayoutResource", args: Int32(value))
        return self
    }
}

// MARK: Inflated id

extension ViewStub {
    /// Returns the id taken by the inflated view.
    public func inflatedId() -> Int {
        Int(instance?.callIntMethod(name: "getInflatedId") ?? 0)
    }

    /// Sets the id taken by the inflated view.
    @discardableResult
    public func inflatedId(_ value: Int) -> Self {
        instance?.callVoidMethod(name: "setInflatedId", args: Int32(value))
        return self
    }
}

// MARK: Inflate

extension ViewStub {
    /// Inflates the layout resource and replaces this stub in its parent.
    public func inflate() -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = instance?.callObjectMethod(name: "inflate", returningClass: returningClazz)
        else { return nil }
        return View(global, { [weak self] in self?.instance?.context })
    }
}
