//
//  View.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

#if os(Android)
import Android
#endif
import DroidFoundation
import FoundationEssentials
import JNIKit
#if canImport(AndroidLooper)
import AndroidLooper
#endif
import Logging

extension AndroidPackage.ViewPackage {
    public class ViewClass: JClassName, @unchecked Sendable {}
    
    public var View: ViewClass { .init(parent: self, name: "View") }
}

extension AndroidPackage.ViewPackage {
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    
    public var ViewOnClickListener: OnClickListenerClass { .init(parent: self, name: "View$OnClickListener") }
}

public protocol AnyView {}

enum ViewStatus: Sendable {
    case new
    case floating(View.ViewInstance)
    case asContentView(View.ViewInstance)
    case inParent(View, View.ViewInstance)
}

open class View: AnyView, @unchecked Sendable {
    /// The JNI class name
    public class var className: JClassName { .android.view.View }

    /// Unique identifier
    let id: Int32
    
    /// Status of the view in the app, e.g. instantiated in in JNI or not yet
    var status: ViewStatus = .new
    
    public var subviews: [View] = []
    public var parent: View? {
        switch status {
            case .new: return nil
            case .floating: return nil
            case .asContentView: return nil
            case .inParent(let parent, _): return parent
        }
    }

    // MARK: Applied Layout Params

    var marginLeft: Int32 = 0
    var marginTop: Int32 = 0
    var marginRight: Int32 = 0
    var marginBottom: Int32 = 0

    // MARK: - Initializers

    @discardableResult
    public init () {
        id = DroidApp.getNextViewId()
        _setup()
    }

    @discardableResult
    public init (@BodyBuilder content: () -> BodyBuilderItemable) {
        id = DroidApp.getNextViewId()
        _setup()
        body { content() }
    }

    func _setup() {

    }

    var instance: ViewInstance? {
        switch status {
            case .new:
                return nil
            case .floating(let instance), .asContentView(let instance), .inParent(_, let instance):
                return instance
        }
    }

    // MARK: - Properties

    @discardableResult
    public func setPadding(left: Int, top: Int, right: Int, bottom: Int) -> Self {
        if let instance {
            instance.setPadding(left: left, top:top, right: right, bottom: bottom)
        }
        return self
    }
    
    @discardableResult
    public func setLayoutParams(_ params: LayoutParams) -> Self {
        if let instance {
                instance.setLayoutParams(params)
        }
        return self
    }
    
    @discardableResult
    public func addSubview(_ subview: View) -> Self {
        guard subviews.firstIndex(of: subview) == nil else {
            DroidApp.logger.debug("🟨 Attempt to add subview that already present")
            return self
        }
        subviews.append(subview)
        if let instance {
            subview.willMoveToParent()
            willAddSubview(subview)
            if let subviewInstance = subview.setStatusInParent(self, instance.context) {
                instance.addView(subviewInstance)
                subview.didMoveToParent()
                didAddSubview(subview)
                subview._addToParentHandlers.forEach { $0() }
            }
        }
        return self
    }

    @discardableResult
    public func addSubviews(_ views: [View]) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
    
    @discardableResult
    public func addSubviews(_ views: View...) -> Self {
        addSubviews(views)
    }

    var _removedFromParentHandlers: [() -> Void] = []

    @discardableResult
    public func onRemovedFromParent(_ handler: @escaping () -> Void) -> Self {
        _removedFromParentHandlers.append(handler)
        return self
    }

    var _addToParentHandlers: [() -> Void] = []

    @discardableResult
    public func onAddToParent(_ handler: @escaping () -> Void) -> Self {
        _addToParentHandlers.append(handler)
        return self
    }

    @discardableResult
    public func removeSubview(_ subview: View) -> Self {
        guard let subviewIndex = subviews.firstIndex(of: subview) else {
            DroidApp.logger.debug("🟨 Attempt to remove already removed view")
            return self
        }
        subview.willMoveFromParent()
        willRemoveSubview(subview)
        subviews.remove(at: subviewIndex)
        if let instance, let subviewInstance = subview.instance {
            instance.removeView(subviewInstance)
        }
        subview.didMoveFromParent()
        subview._removedFromParentHandlers.forEach { $0() }
        didRemoveSubview(subview)
        return self
    }

    public func removeFromParent() {
        parent?.removeSubview(self)
    }

    /// Triggered before subview has been added
    open func willAddSubview(_ subview: View) {}
    /// Triggered after subview has been added
    open func didAddSubview(_ subview: View) {}
    
    /// Triggered before subview has been removed
    open func willRemoveSubview(_ subview: View) {}
    /// Triggered after subview has been removed
    open func didRemoveSubview(_ subview: View) {}

    /// Triggered before this view added into parent view
    open func willMoveToParent() {}
    /// Triggered after this view added into parent view
    open func didMoveToParent() {
        DroidApp.logger.debug("view(id: \(id)) didMoveToParent 1")
        if let instance {
            DroidApp.logger.debug("view(id: \(id)) didMoveToParent 2")
            for p in _propertiesToApply {
                switch p {
                    case .backgroundColor(let value):
                        DroidApp.logger.debug("view(id: \(id)) didMoveToParent backgroundColor")
                        instance.setBackgroundColor(value)
                    case .orientation(let value):
                        DroidApp.logger.debug("view(id: \(id)) didMoveToParent orientation")
                        instance.setOrientation(value)
                    case .onClick(let listener):
                        DroidApp.logger.debug("view(id: \(id)) didMoveToParent onClick")
                        listener.attach(to: instance)
                        instance.setOnClickListener(listener)
                }
            }
            if subviews.count > 0 {
                DroidApp.logger.debug("view(id: \(id)) didMoveToParent iterating subviews")
                for (i, subview) in subviews.filter({ v in
                    switch v.status {
                        case .new, .floating: return true
                        default: return false
                    }
                }).enumerated() {
                    DroidApp.logger.debug("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 1")
                    if let subviewInstance = subview.setStatusInParent(self, instance.context) {
                        DroidApp.logger.debug("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 2")
                        subview.willMoveToParent()
                        instance.addView(subviewInstance)
                        subview.didMoveToParent()
                    } else {
                        DroidApp.logger.debug("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 3")
                        DroidApp.logger.critical("🟥 Unable to initialize ViewInstance for `addView` in `didMoveToParent`")
                    }
                }
            }
            proceedSubviewsLayoutParams()
        }
    }

    /// Triggered before this view removed from its parent view
    open func willMoveFromParent() {}
    /// Triggered after this view removed from its parent view
    open func didMoveFromParent() {
        setStatusFloating()
    }

    func setStatusAsContentView(_ context: ActivityContext) -> ViewInstance? {
        DroidApp.logger.debug("view(id: \(id)) setStatusAsContentView 1")
        switch status {
            case .new, .floating: break
            default:
                DroidApp.logger.debug("🟨 Attempt to `setAsContentView` when view is already has parent")
                return nil
        }
        DroidApp.logger.debug("view(id: \(id)) setStatusAsContentView 2")
        guard let instance: ViewInstance = ViewInstance(Self.className, context, id) else {
            DroidApp.logger.critical("🟥 Unable to initialize ViewInstance for `setAsContentView`")
            return nil
        }
        DroidApp.logger.debug("view(id: \(id)) setStatusAsContentView 3")
        status = .asContentView(instance)
        return instance
    }
    
    func setStatusInParent(_ parent: View, _ context: ActivityContext) -> ViewInstance? {
        DroidApp.logger.debug("view(id: \(id)) setStatusInParent 1")
        switch status {
            case .new, .floating: break
            default:
                DroidApp.logger.debug("🟨 Attempt to `setStatusInParent` when view is already has parent")
                return nil
        }
        DroidApp.logger.debug("view(id: \(id)) setStatusInParent 2")
        guard let instance = ViewInstance(Self.className, context, id) else {
            DroidApp.logger.critical("🟥 Unable to initialize ViewInstance for `setStatusInParent`")
            return nil
        }
        status = .inParent(parent, instance)
        DroidApp.logger.debug("view(id: \(id)) setStatusInParent 3")
        return instance
    }

    func setStatusFloating() {
        switch status {
            case .asContentView, .inParent: break
            default:
                DroidApp.logger.debug("🟨 Attempt to `setFloating` when view have no parent")
                return
        }
        guard let instance else {
            DroidApp.logger.critical("🟥 Unable to `setFloating` when its ViewInstance is nil")
            return
        }
        status = .floating(instance)
    }

    enum PropertyToApply {
        case backgroundColor(GraphicsColor)
        case orientation(LinearLayout.Orientation)
        case onClick(NativeOnClickListener)
    }
    
    var _propertiesToApply: [PropertyToApply] = []    
    var _layoutParamsToApply: [LayoutParamToApply] = []

    func proceedSubviewsLayoutParams() {
        DroidApp.logger.debug("view(id: \(id)) proceedSubviewsLayoutParams")
        for subview in subviews.filter({ v in
            switch v.status {
                case .inParent: return true
                default: return false
            }
        }) {
            let paramsToApply = filterSubviewLayoutParams(subview)
            proceedSubviewLayoutParams(subview, paramsToApply)
        }
    }

    @discardableResult
    public func backgroundColor(_ color: GraphicsColor) -> Self {
        if let instance {
            instance.setBackgroundColor(color)
        } else {
            _propertiesToApply.append(.backgroundColor(color))
        }
        return self
    }
    
    // public func background(Object) -> Self {}
    
    @discardableResult
    public func onClick(_ handler: @escaping @Sendable () async -> Void) -> Self {
        let listener = NativeOnClickListener(handler)
        if let instance {
            instance.setOnClickListener(listener)
        } else {
            _propertiesToApply.append(.onClick(listener))
        }
        return self
    }

    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        addItem(block())
        return self
    }
    
    func addItem(_ item: BodyBuilderItemable, at index: Int? = nil) {
        addItem(item.bodyBuilderItem, at: index)
    }
    
    func addItem(_ item: BodyBuilderItem, at index: Int? = nil) {
        DroidApp.logger.debug("view(id: \(id)) addItem 1")
        switch item {
        case .single(let view):
            DroidApp.logger.debug("view(id: \(id)) addItem 2 (single)")
            add(views: [view], at: index)
        case .multiple(let views):
            DroidApp.logger.debug("view(id: \(id)) addItem 3 (multiple)")
            add(views: views, at: index)
        case .forEach(let fr):
            DroidApp.logger.debug("view(id: \(id)) addItem 4 (forEach)")
            let subview: View
            if let _ = fr.orientation {
                let ll: LinearLayout = LinearLayout()
                // ll.setLayoutParams() // TODO: implement delayed LP
                subview = ll
            } else {
                subview = FrameLayout()
            }
            fr.allItems().forEach {
                subview.addItem($0)
            }
            add(views: [subview], at: index)
            fr.subscribeToChanges({}, { deletions, insertions, _ in
                subview.subviews.removeFromSuperview(at: deletions)
                insertions.forEach {
                    subview.addItem(fr.items(at: $0), at: $0)
                }
            }) {}
            break
        case .nested(let items):
            DroidApp.logger.debug("view(id: \(id)) addItem 5 (nested)")
            items.forEach { addItem($0, at: index) }
            break
        case .none:
            DroidApp.logger.debug("view(id: \(id)) addItem 6 (none)")
            break
        }
    }
    
    func add(views: [View], at index: Int?) {
        guard let index = index else {
            addSubviews(views)
            return
        }
        let nextViews = subviews.dropFirst(index)
        nextViews.forEach { $0.removeFromParent() }
        addSubviews(views)
        nextViews.forEach { self.addSubview($0) }
    }
}

extension View: Equatable, Hashable {
    public static func == (lhs: View, rhs: View) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Array where Element == View {
    func removeFromSuperview(at indexes: [Int]) {
        guard indexes.count > 0 else { return }
        var filtered: [View] = []
        enumerated().forEach { i, v in
            guard indexes.contains(i) else { return }
            filtered.append(v)
        }
        filtered.forEach { $0.removeFromParent() }
    }
}
