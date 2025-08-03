//
//  View.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

#if os(Android)
import Android
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#if canImport(Logging)
import Logging
#endif

extension AndroidPackage.ViewPackage {
    public class ViewClass: JClassName, @unchecked Sendable {}
    public var View: ViewClass { .init(parent: self, name: "View") }
}

extension AndroidPackage.ViewPackage {
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    
    public var ViewOnClickListener: OnClickListenerClass { .init(parent: self, name: "View$OnClickListener") }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public protocol AnyView: ViewInstanceable {
    static var gradleDependencies: [String] { get }
}

enum ViewStatus: Sendable {
    case new
    case floating(View.ViewInstance)
    case asContentView(View.ViewInstance)
    case inParent(View, View.ViewInstance)
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public protocol JClassNameable {
    static var className: JClassName { get }
    var className: JClassName { get }
}

extension JClassNameable {
    public var className: JClassName { Self.className }
}

open class View: AnyView, JClassNameable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { .android.view.View }

    open class var gradleDependencies: [String] { [] }
    
    /// Unique identifier
    nonisolated let id: Int32

    /// Layout Params class
    /// 
    /// - **Very important**:
    /// Each view should provide its own `LayoutParams` class.
    /// Otherwise `ViewGroup`'s one will be provided which could cause crash.
    open class var layoutParamsClass: LayoutParams.Class { .viewGroup }

    /// Layout Params for subviews, it uses `layoutParamsClass` so no need to override it in each view.
    /// 
    /// - **Very important**: Call it only when view already have its instance
    open func layoutParamsForSubviews() -> LayoutParams? {
        guard let instance else { return nil }
        return .init(instance.context, Self.layoutParamsClass.className)
    }

    /// Layout Params for subviews, it uses `layoutParamsClass` so no need to override it in each view.
    /// 
    /// - **Very important**: Call it only when view already have its instance
    open func layoutParamsForSubviews(width: LayoutParams.LayoutSize, height: LayoutParams.LayoutSize, unit: DimensionUnit) -> LayoutParams? {
        guard let instance else { return nil }
        return .init(instance.context, Self.layoutParamsClass.className, width: width, height: height, unit: unit)
    }
    
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
    public init (@BodyBuilder content: BodyBuilder.SingleView) {
        id = DroidApp.getNextViewId()
        _setup()
        body { content() }
    }

    func _setup() {

    }

    public var instance: ViewInstance? {
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
            InnerLog.d("🟨 Attempt to add subview that already present")
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
            InnerLog.d("🟨 Attempt to remove already removed view")
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
        InnerLog.d("view(id: \(id)) didMoveToParent 1")
        if let instance {
            InnerLog.d("view(id: \(id)) didMoveToParent 2")
            for p in _propertiesToApply {
                switch p {
                    case .backgroundColor(let value):
                        InnerLog.d("view(id: \(id)) didMoveToParent backgroundColor")
                        instance.setBackgroundColor(value)
                    case .orientation(let value):
                        InnerLog.d("view(id: \(id)) didMoveToParent orientation")
                        instance.setOrientation(value)
                    case .onClick(let listener):
                        InnerLog.d("view(id: \(id)) didMoveToParent onClick")
                        listener.attach(to: instance)
                        instance.setOnClickListener(listener)
                    case .fitsSystemWindows(let value):
                        InnerLog.d("view(id: \(id)) didMoveToParent fitsSystemWindows")
                        instance.setFitsSystemWindows(value)
                }
            }
            if subviews.count > 0 {
                InnerLog.d("view(id: \(id)) didMoveToParent iterating subviews")
                for (i, subview) in subviews.filter({ v in
                    switch v.status {
                        case .new, .floating: return true
                        default: return false
                    }
                }).enumerated() {
                    InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 1")
                    if let subviewInstance = subview.setStatusInParent(self, instance.context) {
                        InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 2")
                        subview.willMoveToParent()
                        instance.addView(subviewInstance)
                        subview.didMoveToParent()
                    } else {
                        InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 3")
                        InnerLog.c("🟥 Unable to initialize ViewInstance for `addView` in `didMoveToParent`")
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
        InnerLog.d("view(id: \(id)) setStatusAsContentView 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.d("🟨 Attempt to `setAsContentView` when view is already has parent")
                return nil
        }
        InnerLog.d("view(id: \(id)) setStatusAsContentView 2")
        guard let instance: ViewInstance = ViewInstance(Self.className, self, context, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setAsContentView`")
            return nil
        }
        InnerLog.d("view(id: \(id)) setStatusAsContentView 3")
        status = .asContentView(instance)
        return instance
    }
    
    func setStatusInParent(_ parent: View, _ context: ActivityContext) -> ViewInstance? {
        InnerLog.d("view(id: \(id)) setStatusInParent 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.d("🟨 Attempt to `setStatusInParent` when view is already has parent")
                return nil
        }
        InnerLog.d("view(id: \(id)) setStatusInParent 2")
        guard let instance = ViewInstance(Self.className, self, context, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setStatusInParent`")
            return nil
        }
        status = .inParent(parent, instance)
        InnerLog.d("view(id: \(id)) setStatusInParent 3")
        return instance
    }

    func setStatusFloating() {
        switch status {
            case .asContentView, .inParent: break
            default:
                InnerLog.d("🟨 Attempt to `setFloating` when view have no parent")
                return
        }
        guard let instance else {
            InnerLog.c("🟥 Unable to `setFloating` when its ViewInstance is nil")
            return
        }
        status = .floating(instance)
    }

    enum PropertyToApply {
        case backgroundColor(GraphicsColor)
        case orientation(LinearLayout.Orientation)
        case onClick(NativeOnClickListener)
        case fitsSystemWindows(Bool)
    }
    
    var _propertiesToApply: [PropertyToApply] = []    
    var _layoutParamsToApply: [LayoutParamToApply] = []

    func proceedSubviewsLayoutParams() {
        InnerLog.d("view(id: \(id)) proceedSubviewsLayoutParams")
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
    public func fitsSystemWindows(_ value: Bool = true) -> Self {
        if let instance {
            instance.setFitsSystemWindows(value)
        } else {
            _propertiesToApply.append(.fitsSystemWindows(value))
        }
        return self
    }
    
    @discardableResult
    public func onClick(_ handler: @escaping () async -> Void) -> Self {
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
        InnerLog.d("view(id: \(id)) addItem 1")
        switch item {
        case .single(let view):
            InnerLog.d("view(id: \(id)) addItem 2 (single)")
            add(views: [view], at: index)
        case .multiple(let views):
            InnerLog.d("view(id: \(id)) addItem 3 (multiple)")
            add(views: views, at: index)
        case .forEach(let fr):
            InnerLog.d("view(id: \(id)) addItem 4 (forEach)")
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
            InnerLog.d("view(id: \(id)) addItem 5 (nested)")
            items.forEach { addItem($0, at: index) }
            break
        case .none:
            InnerLog.d("view(id: \(id)) addItem 6 (none)")
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
    public static nonisolated func == (lhs: View, rhs: View) -> Bool {
        lhs.id == rhs.id
    }
    
    public nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
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
