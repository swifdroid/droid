//
//  View.swift
//  Droid
//
//  Created by Mihael Isaev on 14.01.2022.
//

#if os(Android)
import Android
#endif
#if canImport(Logging)
import Logging
#endif

extension AndroidPackage.ViewPackage {
    public class ViewClass: JClassName, @unchecked Sendable {}
    public var View: ViewClass { .init(parent: self, name: "View") }
}

extension AndroidPackage.ViewPackage {
    public class OnApplyWindowInsetsListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnApplyWindowInsetsListener: OnApplyWindowInsetsListenerClass { .init(parent: self, name: "View$OnApplyWindowInsetsListener") }
    public class CapturedPointerListenerClass: JClassName, @unchecked Sendable {}
    public var ViewCapturedPointerListener: CapturedPointerListenerClass { .init(parent: self, name: "View$OnCapturedPointerListener") }
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnClickListener: OnClickListenerClass { .init(parent: self, name: "View$OnClickListener") }
    public class OnContextClickListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnContextClickListener: OnContextClickListenerClass { .init(parent: self, name: "View$OnContextClickListener") }
    public class OnCreateContextMenuListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnCreateContextMenuListener: OnCreateContextMenuListenerClass { .init(parent: self, name: "View$OnCreateContextMenuListener") }
    public class OnDragListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnDragListener: OnDragListenerClass { .init(parent: self, name: "View$OnDragListener") }
    public class OnFocusChangeListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnFocusChangeListener: OnFocusChangeListenerClass { .init(parent: self, name: "View$OnFocusChangeListener") }
    public class OnGenericMotionListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnGenericMotionListener: OnGenericMotionListenerClass { .init(parent: self, name: "View$OnGenericMotionListener") }
    public class OnHoverListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnHoverListener: OnHoverListenerClass { .init(parent: self, name: "View$OnHoverListener") }
    public class OnKeyListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnKeyListener: OnKeyListenerClass { .init(parent: self, name: "View$OnKeyListener") }
    public class OnLongClickListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnLongClickListener: OnLongClickListenerClass { .init(parent: self, name: "View$OnLongClickListener") }
    public class OnReceiveContentListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnReceiveContentListener: OnReceiveContentListenerClass { .init(parent: self, name: "View$OnReceiveContentListener") }
    public class OnScrollChangeListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnScrollChangeListener: OnScrollChangeListenerClass { .init(parent: self, name: "View$OnScrollChangeListener") }
    public class OnSystemUiVisibilityChangeListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnSystemUiVisibilityChangeListener: OnSystemUiVisibilityChangeListenerClass { .init(parent: self, name: "View$OnSystemUiVisibilityChangeListener") }
    public class OnTouchListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnTouchListener: OnTouchListenerClass { .init(parent: self, name: "View$OnTouchListener") }
}

@MainActor
public protocol AnyView: AnyObject, ViewInstanceable {
    static var gradleDependencies: [AppGradleDependency] { get }
}
@MainActor
protocol _AnyView: AnyView {
    var _propertiesToApply: [any ViewPropertyToApply] { get set }
    var status: ViewStatus { get set }
}

@MainActor
enum ViewStatus: @MainActor CustomStringConvertible {
    case new
    case floating(View.ViewInstance)
    case asContentView(View.ViewInstance)
    case inParent(WeakView, View.ViewInstance)

    var description: String {
        switch self {
            case .new: return "new"
            case .floating: return "floating"
            case .asContentView: return "asContentView"
            case .inParent: return "inParent"
        }
    }
}
@MainActor
final class WeakView {
    weak var view: View?
    init (_ view: View) {
        self.view = view
    }
}

@MainActor
public protocol JClassNameable: AnyObject {
    static var className: JClassName { get }
    var className: JClassName { get }
}

extension JClassNameable {
    public var className: JClassName { type(of: self).className }
}

@MainActor
public protocol Viewable {
    associatedtype ViewType: View
    var view: ViewType { get }
}
extension View: Viewable {
    public var view: View { self }
}

open class View: _AnyView, JClassNameable, StatesHolder, Sendable {
    public typealias Body = BodyBuilder.Result

    /// The JNI class name
    open class var className: JClassName { .android.view.View }

    open class var gradleDependencies: [AppGradleDependency] { [] }
    
    /// Unique identifier
    public nonisolated let id: Int32

    /// States holder
    public let statesValues: StatesHolderValuesBox = StatesHolderValuesBox()

    /// Layout Params class
    /// 
    /// - **Very important**:
    /// Each view should provide its own `LayoutParams` class.
    /// Otherwise `ViewGroup`'s one will be provided which could cause crash.
    open class var layoutParamsClass: LayoutParams.Class { .viewGroup }

    /// Set true if LayoutParams should never be initialized but only loaded from the instance
    open class var layoutParamsShouldBeLoaded: Bool { true }

    /// Layout Params for subviews, it uses `layoutParamsClass` so no need to override it in each view.
    /// 
    /// - **Very important**: Call it only when view already have its instance
    open func layoutParamsForSubviews() -> LayoutParams? {
        .init(Self.layoutParamsClass.className)
    }

    /// Layout Params for subviews, it uses `layoutParamsClass` so no need to override it in each view.
    /// 
    /// - **Very important**: Call it only when view already have its instance
    open func layoutParamsForSubviews(width: LayoutParams.LayoutSize, height: LayoutParams.LayoutSize, _ unit: DimensionUnit) -> LayoutParams? {
        .init(Self.layoutParamsClass.className, width: width, height: height, unit)
    }

    open func applicableLayoutParams() -> [LayoutParamKey] {
        [
            .width,
            .height,
            .setMargins,
            .startMargin,
            .endMargin,
            .leftMargin,
            .rightMargin,
            .topMargin,
            .bottomMargin
        ]
    }

    public func filteredLayoutParams(_ parentApplicableKeys: [LayoutParamKey]) -> [any LayoutParamToApply] {
        var applicableKeys = parentApplicableKeys
        return _layoutParamsToApply.filter {
            if let index = applicableKeys.firstIndex(of: $0.key) {
                applicableKeys.remove(at: index)
                return true
            }
            return false
        }
    }
    
    open func processLayoutParams(_ instance: ViewInstance, _ lp: LayoutParams, for subview: View) {
        let params = subview.filteredLayoutParams(applicableLayoutParams())
        let env = JEnv.current()
        params.forEach {
            InnerLog.t("Processing LP: \($0.key) for \(subview.className.path)#\(subview.id) in lp: \(lp.clazz.name.path)")
            $0.apply(env, instance, lp)
        }
    }

    open func processProperties(_ propertiesToSkip: [ViewPropertyKey], _ instance: View.ViewInstance) {
        guard let env = JEnv.current() else { return }
        for property in _propertiesToApply {
            if propertiesToSkip.contains(property.key) { continue }
            property.applyToInstance(env, instance)
        }
    }
    
    /// Status of the view in the app, e.g. instantiated in in JNI or not yet
    var status: ViewStatus = .new {
        didSet {
            InnerLog.t("🔳 Status changed to \(status) for (\(Self.className.name))view(id: \(id))")
        }
    }
    
    public var subviews: [View] = []
    public var parent: View? {
        switch status {
            case .new: return nil
            case .floating: return nil
            case .asContentView: return nil
            case .inParent(let parent, _): return parent.view
        }
    }

    // MARK: - Initializers

    @discardableResult
    public init (id: Int32? = nil) {
        self.id = id ?? .nextViewId()
        InnerLog.t("🟩View.init 1 \(self)")
        _setup()
        body { body }
        buildUI()
    }

    @discardableResult
    public init (id: Int32? = nil, _ object: JObject, _ contextLink: @escaping () -> ActivityContext?) {
        self.id = id ?? .nextViewId()
        if let instance = ViewInstance(object, self, contextLink, self.id, setId: id != nil) {
            self.status = .asContentView(instance)
        }
        #if os(Android)
        InnerLog.t("🟩View.init 2 viewInstance: \(object.className.fullName) ref: \(object.ref.ref)")
        #endif
        _setup()
        body { body }
        buildUI()
    }
    
    @discardableResult
    public init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        self.id = id ?? .nextViewId()
        InnerLog.t("🟩View.init 3 \(self)")
        _setup()
        body { content() }
        body { body }
        buildUI()
    }

    deinit {
        InnerLog.t("🟥🟥🟥 DEINIT view: \(self)")
        releaseStates()
    }

    public var instance: ViewInstance? {
        switch status {
            case .new:
                return nil
            case .floating(let instance), .asContentView(let instance), .inParent(_, let instance):
                return instance
        }
    }

    func _setup() {

    }

    // MARK: - Properties
    
    @discardableResult
    public func layoutParams(_ params: LayoutParams) -> Self {
        if let instance {
            instance.setLayoutParams(params)
        }
        return self
    }
    
    /// Adds a subview to this view.
    @discardableResult
    public func addSubview(_ subview: View) -> Self {
        guard subviews.firstIndex(of: subview) == nil else {
            InnerLog.t("🟨 Attempt to add subview that already present")
            return self
        }
        #if os(Android)
        InnerLog.t("🟦 Added subview type: \(subview) ref: \(String(describing: subview.instance?.object.ref.ref))")
        #endif
        subviews.append(subview)
        if let instance {
            if instance.contextLink() == nil {
                InnerLog.c("🟥 Unable to add subview: parent view's context is nil")
                return self
            }
            subview.willMoveToParent()
            willAddSubview(subview)
            if let subviewInstance = subview.setStatusInParent(self, instance.contextLink) {
                instance.addView(subviewInstance)
                subview.didMoveToParent()
                didAddSubview(subview)
                subview._addToParentHandlers.forEach { $0() }
            }
        }
        return self
    }

    /// Adds multiple subviews to this view.
    @discardableResult
    public func addSubviews(_ views: [View]) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
    
    /// Adds multiple subviews to this view.        
    @discardableResult
    public func addSubviews(_ views: View...) -> Self {
        addSubviews(views)
    }

    var _removedFromParentHandlers: [() -> Void] = []

    /// Adds a handler that will be called when view is removed from its parent.
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
            InnerLog.t("🟨 Attempt to remove already removed view(id: \(subview.id))")
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
        if let parent {
            InnerLog.t("Removing (\(Self.className.name))view(id: \(id)) from (\(parent.className.name))parentView(id: \(parent.id))) subviews.count=\(subviews.count)")
        } else {
            InnerLog.t("Removing (\(Self.className.name))view(id: \(id)) from the content root view")
        }
        for subview in subviews {
            subview.removeFromParent()
        }
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
        // InnerLog.t("view(id: \(id)) didMoveToParent 1")
        guard let instance else {
            InnerLog.c("🟥 Unable to proceed `didMoveToParent` when its ViewInstance is nil")
            return
        }
        if instance.contextLink() == nil {
            InnerLog.c("🟥 Unable to proceed `didMoveToParent`: view's context is nil")
            return
        }
        InnerLog.t("view(id: \(id)) didMoveToParent 2 before setting all properties")
        processProperties([], instance)
        InnerLog.t("view(id: \(id)) didMoveToParent 2.5 after setting all properties")
        if subviews.count > 0 {
            // InnerLog.t("view(id: \(id)) didMoveToParent iterating subviews")
            for (_, subview) in subviews.filter({ v in
                switch v.status {
                    case .new, .floating: return true
                    default: return false
                }
            }).enumerated() {
                // InnerLog.t("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 1")
                if let subviewInstance = subview.setStatusInParent(self, instance.contextLink) {
                    // InnerLog.t("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 2")
                    subview.willMoveToParent()
                    instance.addView(subviewInstance)
                    subview.didMoveToParent()
                } else {
                    // InnerLog.t("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 3")
                    InnerLog.c("🟥 Unable to initialize ViewInstance for `addView` in `didMoveToParent`")
                }
            }
        }
        proceedSubviewsLayoutParams(instance)
    }

    /// Triggered before this view removed from its parent view
    open func willMoveFromParent() {}
    /// Triggered after this view removed from its parent view
    open func didMoveFromParent() {
        setStatusFloating()
    }

    @discardableResult
    func setStatusAsContentView(_ contextLink: @escaping () -> ActivityContext?) -> ViewInstance? {
        InnerLog.t("view(id: \(id)) \(self) setStatusAsContentView 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.t("🟨 Attempt to `setAsContentView` when view is already has parent")
                return nil
        }
        // InnerLog.t("view(id: \(id)) setStatusAsContentView 2")
        guard let instance: ViewInstance = ViewInstance(Self.className, self, contextLink, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setAsContentView`")
            return nil
        }
        if Self.layoutParamsShouldBeLoaded {
            instance.lpClassName = Self.layoutParamsClass.className
        }
        // InnerLog.t("view(id: \(id)) setStatusAsContentView 3")
        self.status = .asContentView(instance)
        return instance
    }
    
    @discardableResult
    func setStatusInParent(_ parent: View, _ contextLink: @escaping () -> ActivityContext?) -> ViewInstance? {
        InnerLog.t("view(id: \(id)) \(self) setStatusInParent 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.t("🟨 Attempt to `setStatusInParent` when view is already has parent")
                return nil
        }
        // InnerLog.t("view(id: \(id)) setStatusInParent 2")
        guard let instance = ViewInstance(Self.className, self, contextLink, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setStatusInParent`")
            return nil
        }
        if Self.layoutParamsShouldBeLoaded {
            instance.lpClassName = Self.layoutParamsClass.className
        }
        self.status = .inParent(.init(parent), instance)
        // InnerLog.t("view(id: \(id)) setStatusInParent 3")
        return instance
    }

    func setStatusFloating() {
        switch status {
            case .asContentView, .inParent: break
            default:
                InnerLog.t("🟨 Attempt to `setFloating` when view have no parent")
                return
        }
        guard let instance else {
            InnerLog.c("🟥 Unable to `setFloating` when its ViewInstance is nil")
            return
        }
        self.status = .floating(instance)
    }
    
    var _propertiesToApply: [any ViewPropertyToApply] = []
    var _layoutParamsToApply: [any LayoutParamToApply] = []

    var layoutParamsShouldBeLoaded: Bool { Self.layoutParamsShouldBeLoaded }
    var layoutParamsClass: LayoutParams.Class { Self.layoutParamsClass }

        // InnerLog.t("view(id: \(id)) proceedSubviewsLayoutParams")
    func proceedSubviewsLayoutParams(_ instance: ViewInstance) {
        for subview in subviews.filter({ v in
            switch v.status {
                case .inParent: return true
                default: return false
            }
        }) {
            if Self.layoutParamsShouldBeLoaded, let lp = subview.instance?.layoutParams(Self.layoutParamsClass.className) {
                InnerLog.t("view(id: \(id)) proceedSubviewsLayoutParams loaded lp for subview(id: \(subview.id)) in lp: \(lp.clazz.name.path)")
                processLayoutParams(instance, lp, for: subview)
                subview.layoutParams(lp)
            } else if let lp = layoutParamsForSubviews() {
                InnerLog.t("view(id: \(id)) proceedSubviewsLayoutParams created lp for subview(id: \(subview.id)) in lp: \(lp.clazz.name.path)")
                processLayoutParams(instance, lp, for: subview)
                subview.layoutParams(lp)
            }
        }
    }
    
    // public func background(Object) -> Self {}

    @BodyBuilder open var body: Body { EmptyBodyBuilderItem() }

    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        addItem(block())
        return self
    }

    open func buildUI() {}
    
    func addItem(_ item: BodyBuilderItemable, at index: Int? = nil) {
        addItem(item.bodyBuilderItem, at: index)
    }
    
    func addItem(_ item: BodyBuilderItem, at index: Int? = nil) {
        // InnerLog.t("view(id: \(id)) addItem 1")
        switch item {
        case .single(let view):
            // InnerLog.t("view(id: \(id)) addItem 2 (single)")
            add(views: [view], at: index)
        case .multiple(let views):
            // InnerLog.t("view(id: \(id)) addItem 3 (multiple)")
            add(views: views, at: index)
        case .forEach(let fr):
            InnerLog.t("view(id: \(id)) addItem 4 (forEach)")
            let subview: View
            if let orientation = fr.orientation {
                subview = LinearLayout()
                    .orientation(orientation)
                    .width(.matchParent)
                    .height(.matchParent)
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
            } else {
                fr.allItems().forEach {
                    addItem($0)
                }
                // add(views: [subview], at: index)
                //     fr.subscribeToChanges({}, { deletions, insertions, _ in
                //     subviews.removeFromSuperview(at: deletions)
                //     insertions.forEach {
                //         self.addItem(fr.items(at: $0), at: $0)
                //     }
                // }) {}
            }
            break
        case .nested(let items):
            // InnerLog.t("view(id: \(id)) addItem 5 (nested)")
            items.forEach { addItem($0, at: index) }
            break
        case .supportActiionBar:
            break
        case .none:
            // InnerLog.t("view(id: \(id)) addItem 6 (none)")
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

@MainActor
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

// MARK: - Properties

// Details are here https://developer.android.com/reference/android/view/View

// MARK: AccessibilityDataSensitive

public enum AccessibilityDataSensitiveMode: Int32 {
    case auto = 0x00000000
    case no = 0x00000002
    case yes = 0x00000001
}
struct AccessibilityDataSensitiveViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityDataSensitive
    let value: AccessibilityDataSensitiveMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Specifies whether this view should only allow interactions from AccessibilityServices with the AccessibilityServiceInfo.isAccessibilityTool() property set to true.
    @discardableResult
    public func accessibilityDataSensitive(_ value: AccessibilityDataSensitiveMode) -> Self {
        AccessibilityDataSensitiveViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityDelegate

// TODO: https://developer.android.com/reference/android/view/View#setAccessibilityDelegate(android.view.View.AccessibilityDelegate)

// MARK: AccessibilityHeading

struct AccessibilityHeadingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityHeading
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set if view is a heading for a section of content for accessibility purposes.
    @discardableResult
    public func accessibilityHeading(_ value: Bool = true) -> Self {
        AccessibilityHeadingViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityLiveRegion
public enum AccessibilityLiveRegionMode: Int32 {
    /// Accessibility services should not announce changes to this view.
    case none = 0
    /// Accessibility services should announce changes to this view.
    case polite = 1
    /// Accessibility services should interrupt ongoing speech to immediately announce changes to this view.
    case assertive = 2
}
struct AccessibilityLiveRegionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityLiveRegion
    let value: AccessibilityLiveRegionMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets the live region mode for this view.
    @discardableResult
    public func accessibilityLiveRegion(_ value: AccessibilityLiveRegionMode) -> Self {
        AccessibilityLiveRegionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityPaneTitle

struct AccessibilityPaneTitleProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityPaneTitle
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(.java.lang.CharSequence))])
        #endif
    }
}
extension View {
    /// Visually distinct portion of a window with window-like semantics are considered panes for accessibility purposes.
    @discardableResult
    public func accessibilityPaneTitle(_ value: String) -> Self {
        AccessibilityPaneTitleProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityTraversalAfter

struct AccessibilityTraversalAfterProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityTraversalAfter
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of a view that screen readers are requested to visit before this view.
    @discardableResult
    public func accessibilityTraversalAfter(_ value: Int32) -> Self {
        AccessibilityTraversalAfterProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityTraversalBefore

struct AccessibilityTraversalBeforeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAccessibilityTraversalBefore
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of a view that screen readers are requested to visit after this view.
    @discardableResult
    public func accessibilityTraversalBefore(_ value: Int32) -> Self {
        AccessibilityTraversalBeforeProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Activated

struct ActivatedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setActivated
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Changes the activated state of this view.
    @discardableResult
    public func activated(_ value: Bool = true) -> Self {
        ActivatedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AllowClickWhenDisabled

struct AllowClickWhenDisabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAllowClickWhenDisabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enables or disables click events for this view when disabled.
    @discardableResult
    public func allowClickWhenDisabled(_ value: Bool = true) -> Self {
        AllowClickWhenDisabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AllowedHandwritingDelegatePackage

struct AllowedHandwritingDelegatePackageProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAllowedHandwritingDelegatePackage
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(JString.className))])
        #endif
    }
}
extension View {
    /// Specifies that this view may act as a handwriting initiation delegator for a delegate editor view from the specified package.
    @discardableResult
    public func allowedHandwritingDelegatePackage(_ value: String) -> Self {
        AllowedHandwritingDelegatePackageProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AllowedHandwritingDelegatorPackage

struct AllowedHandwritingDelegatorPackageProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAllowedHandwritingDelegatorPackage
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(JString.className))])
        #endif
    }
}
extension View {
    /// Specifies that a view from the specified package may act as a handwriting delegator for this delegate editor view.
    @discardableResult
    public func allowedHandwritingDelegatorPackage(_ value: String) -> Self {
        AllowedHandwritingDelegatorPackageProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Alpha

struct AlphaProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAlpha
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the opacity of the view to a value from 0 to 1,
    /// where 0 means the view is completely transparent
    /// and 1 means the view is completely opaque.
    @discardableResult
    public func alpha(_ value: Float) -> Self {
        AlphaProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Animation

// TODO:

// MARK: AnimationMatrix

// TODO:

// MARK: AutoHandwritingEnabled

struct AutoHandwritingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setAutoHandwritingEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view enables automatic handwriting initiation.
    @discardableResult
    public func autoHandwritingEnabled(_ value: Bool = true) -> Self {
        AutoHandwritingEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AutofillHints

public enum AutofillHint: String, Sendable {
    /// Hint indicating that this view can be autofilled with a credit card expiration date.
    ///
    /// It should be used when the credit card expiration date is represented by just one view;
    /// if it is represented by more than one (for example, one view for the month and another view for the year),
    /// then each of these views should use the hint specific for the unit (.creditCardExpirationDay, .creditCardExpirationMonth, or .creditCardExpirationYear).
    ///
    /// Can be used with either `setAutofillHints([])` or `android:autofillHint` (in which case the value should be .creditCardExpirationDate).
    ///
    /// When annotating a view with this hint, it's recommended to use a date autofill value to avoid ambiguity when the autofill service provides a value for it.
    /// To understand why a value can be ambiguous, consider "April of 2020", which could be represented as either of the following options:
    /// - "04/2020"
    /// - "4/2020"
    /// - "2020/04"
    /// - "2020/4"
    /// - "April/2020"
    /// - "Apr/2020"
    /// 
    /// You define a date autofill value for the view by overriding the following methods:
    /// 
    /// - `getAutofillType()` to return `.date`.
    /// - `getAutofillValue()` to return a `date autofillvalue`.
    /// - `autofill(AutofillValue)` to expect a `data autofillvalue`.
    case creditCardExpirationDate = "creditCardExpirationDate"
    /// Hint indicating that this view can be autofilled with a credit card expiration day.
    case creditCardExpirationDay = "creditCardExpirationDay"
    /// Hint indicating that this view can be autofilled with a credit card expiration month.
    case creditCardExpirationMonth = "creditCardExpirationMonth"
    /// Hint indicating that this view can be autofilled with a credit card expiration year.
    case creditCardExpirationYear = "creditCardExpirationYear"
    /// Hint indicating that this view can be autofilled with a credit card number.
    case creditCardNumber = "creditCardNumber"
    /// Hint indicating that this view can be autofilled with a credit card security code.
    case creditCardSecurityCode = "creditCardSecurityCode"
    /// Hint indicating that this view can be autofilled with an email address.
    case emailAddress = "emailAddress"
    /// Hint indicating that this view can be autofilled with a user's real name.
    case name = "name"
    /// Hint indicating that this view can be autofilled with a password.
    case password = "password"
    /// Hint indicating that this view can be autofilled with a phone number.
    case phone = "phone"
    /// Hint indicating that this view can be autofilled with a postal address.
    case postalAddress = "postalAddress"
    /// Hint indicating that this view can be autofilled with a postal code.
    case postalCode = "postalCode"
    /// Hint indicating that this view can be autofilled with a username.
    case username = "username"
}

// TODO: implement `getAutofillType` method

// MARK: AutofillId

// TODO:

// MARK: Background

// TODO:

// MARK: BackgroundColor

struct BackgroundColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setBackgroundColor
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, signatureItems: .int, args: value.value)
    }
}
extension View {
    /// Sets the background color for this view.
    @discardableResult
    public func backgroundColor(_ color: GraphicsColor) -> Self {
        BackgroundColorViewProperty(value: color).applyOrAppend(nil, self)
        return self
    }
}

// MARK: BackgroundResource

struct BackgroundResourceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setBackgroundResource
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set the background to a given resource.
    @discardableResult
    public func backgroundResource(_ value: Int32) -> Self {
        BackgroundResourceProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: BackgroundTintBlendMode

// TODO:

// MARK: BackgroundTintList

// TODO:

// MARK: BackgroundTintMode

// TODO:

// MARK: Bottom

struct BottomProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setBottom
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the bottom position of this view relative to its parent.
    @discardableResult
    public func bottom(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        BottomProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: CameraDistance

struct CameraDistanceProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setCameraDistance
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(value.0))
    }
}
extension View {
    /// Sets the distance along the Z axis (orthogonal to the X/Y plane on which views are drawn) from the camera to this view.
    @discardableResult
    public func cameraDistance(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        CameraDistanceProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Clickable

struct ClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enables or disables click events for this view.
    @discardableResult
    public func clickable(_ value: Bool = true) -> Self {
        ClickableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ClipBounds

// TODO:

// MARK: ClipToOutline

struct ClipToOutlineViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setClipToOutline
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether the View's Outline should be used to clip the contents of the View.
    @discardableResult
    public func clipToOutline(_ value: Bool = true) -> Self {
        ClipToOutlineViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ContentCaptureSession

// TODO:

// MARK: ContentDescription

struct ContentDescriptionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setContentDescription
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(.java.lang.CharSequence))])
        #endif
    }
}
extension View {
    /// Sets the View's content description.
    @discardableResult
    public func contentDescription(_ value: String) -> Self {
        ContentDescriptionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ContentSensitivity

public enum ContentSensitivity: Int32 {
    /// Content sensitivity is determined by the framework.
    ///
    /// The framework uses a heuristic to determine if this view displays sensitive content.
    case auto = 0
    /// The view doesn't display sensitive content.
    case notSensitive = 2
    /// The view displays sensitive content.
    case sensitive = 1
}
struct ContentSensitivityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setContentSensitivity
    let value: ContentSensitivity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets content sensitivity mode to determine whether this view displays sensitive content (e.g. username, password etc.).
    @discardableResult
    public func contentSensitivity(_ value: ContentSensitivity) -> Self {
        ContentSensitivityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ContextClickable

struct ContextClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setContextClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enables or disables context clicking for this view.
    @discardableResult
    public func contextClickable(_ value: Bool = true) -> Self {
        ContextClickableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DefaultFocusHighlightEnabled

struct DefaultFocusHighlightEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDefaultFocusHighlightEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether this View should use a default focus highlight when it gets focused
    /// but doesn't have `R.attr.state_focused` defined in its background.
    @discardableResult
    public func defaultFocusHighlightEnabled(_ value: Bool = true) -> Self {
        DefaultFocusHighlightEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DrawingCacheBackgroundColor

struct DrawingCacheBackgroundColorProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDrawingCacheBackgroundColor
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension View {
    /// This method was deprecated in API level 28.
    ///
    /// The view drawing cache was largely made obsolete
    /// with the introduction of hardware-accelerated rendering in API 11.
    ///
    /// With hardware-acceleration, intermediate cache layers are largely unnecessary
    /// and can easily result in a net loss in performance due to the cost of creating and updating the layer. 
    @discardableResult
    public func drawingCacheBackgroundColor(_ value: GraphicsColor) -> Self {
        DrawingCacheBackgroundColorProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DrawingCacheEnabled

struct DrawingCacheEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDrawingCacheEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// This method was deprecated in API level 28.
    ///
    /// The view drawing cache was largely made obsolete
    /// with the introduction of hardware-accelerated rendering in API 11.
    ///
    /// With hardware-acceleration, intermediate cache layers are largely unnecessary
    /// and can easily result in a net loss in performance due to the cost of creating and updating the layer. 
    @discardableResult
    public func drawingCacheEnabled(_ value: Bool = true) -> Self {
        DrawingCacheEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DrawingCacheQuality

public enum DrawingCacheQuality: Int32 {
    case auto = 0
    case high = 0x00100000
    case low = 0x00080000
}
struct DrawingCacheQualityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDrawingCacheQuality
    let value: DrawingCacheQuality
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// This method was deprecated in API level 28.
    ///
    /// The view drawing cache was largely made obsolete
    /// with the introduction of hardware-accelerated rendering in API 11.
    ///
    /// With hardware-acceleration, intermediate cache layers are largely unnecessary
    /// and can easily result in a net loss in performance due to the cost of creating and updating the layer. 
    @discardableResult
    public func drawingCacheQuality(_ value: DrawingCacheQuality) -> Self {
        DrawingCacheQualityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DuplicateParentStateEnabled

struct DuplicateParentStateEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDuplicateParentStateEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enables or disables the duplication of the parent's state into this view.
    @discardableResult
    public func duplicateParentStateEnabled(_ value: Bool = true) -> Self {
        DuplicateParentStateEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Elevation

struct ElevationProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setElevation
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(value.0))
    }
}
extension View {
    /// Sets the base elevation of this view.
    @discardableResult
    public func elevation(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        ElevationProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Enabled

struct EnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set the enabled state of this view.
    @discardableResult
    public func enabled(_ value: Bool = true) -> Self {
        EnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: FadingEdgeLength

struct FadingEdgeLengthProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFadingEdgeLength
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Set the size of the faded edge used to indicate that more content in this view is available.
    @discardableResult
    public func fadingEdgeLength(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        FadingEdgeLengthProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: FilterTouchesWhenObscured

struct FilterTouchesWhenObscuredViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFilterTouchesWhenObscured
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether the framework should discard touches when the view's window is obscured by another visible window at the touched location.
    @discardableResult
    public func filterTouchesWhenObscured(_ value: Bool = true) -> Self {
        FilterTouchesWhenObscuredViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: FitsSystemWindows

struct SetFitsSystemWindowsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFitsSystemWindows
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether or not this view should account for system screen decorations
    /// such as the status bar and inset its content;
    /// that is, controlling whether the default implementation of `fitSystemWindows(Rect)` will be executed.
    @discardableResult
    public func fitsSystemWindows(_ value: Bool = true) -> Self {
        SetFitsSystemWindowsViewProperty(value: value).applyOrAppend(nil, self)
        return self
    }
}

// MARK: Focusable

struct FocusableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFocusable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether this view can receive focus.
    @discardableResult
    public func focusable(_ value: Bool = true) -> Self {
        FocusableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: FocusableInTouchMode

struct FocusableInTouchModeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFocusableInTouchMode
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view can receive focus while in touch mode.
    @discardableResult
    public func focusableInTouchMode(_ value: Bool = true) -> Self {
        FocusableInTouchModeViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: FocusedByDefault

struct FocusedByDefaultViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFocusedByDefault
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether this View should receive focus when the focus is restored for the view hierarchy containing this view.
    @discardableResult
    public func focusedByDefault(_ value: Bool = true) -> Self {
        FocusedByDefaultViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ForceDarkAllowed

struct ForceDarkAllowedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setForceDarkAllowed
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether or not to allow force dark to apply to this view.
    @discardableResult
    public func forceDarkAllowed(_ value: Bool = true) -> Self {
        ForceDarkAllowedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Foreground

// TODO:

// MARK: ForegroundGravity

struct ForegroundGravityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setForegroundGravity
    let value: Gravity
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.rawValue))
    }
}
extension View {
    /// Describes how the foreground is positioned.
    @discardableResult
    public func foregroundGravity(_ value: Gravity) -> Self {
        ForegroundGravityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ForegroundTintBlendMode

// TODO:

// MARK: ForegroundTintList

// TODO:

// MARK: ForegroundTintMode

// TODO:

// MARK: FrameContentVelocity

struct FrameContentVelocityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFrameContentVelocity
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set the current velocity of the View, we only track positive value.
    @discardableResult
    public func frameContentVelocity(_ value: Float) -> Self {
        FrameContentVelocityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HandwritingBoundsOffsets

struct HandwritingBoundsOffsetsProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHandwritingBoundsOffsets
    let value: (Float, Float, Float, Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.4.toPixels(value.0), value.4.toPixels(value.1), value.4.toPixels(value.2), value.4.toPixels(value.3))
    }
}
extension View {
    /// Set the amount of offset applied to this view's stylus handwriting bounds.
    @discardableResult
    public func handwritingBoundsOffsets(_ left: Float, _ top: Float, _ right: Float, _ bottom: Float, _ unit: DimensionUnit = .dp) -> Self {
        HandwritingBoundsOffsetsProperty(value: (left, top, right, bottom, unit)).applyOrAppend(nil, self)
    }
}

// MARK: HandwritingDelegateFlags

public enum HandwritingDelegateFlag: Int32 {
    case `default` = 0
    /// Flag indicating that views from the default home screen (`Intent.CATEGORY_HOME`) may act as a handwriting delegator for the delegate editor view. If set, views from the home screen package will be trusted for handwriting delegation.
    case homeDelegatorAllowed = 1
}
struct HandwritingDelegateFlagsProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHandwritingDelegateFlags
    let value: HandwritingDelegateFlag
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets flags configuring the handwriting delegation behavior for this delegate editor view.
    @discardableResult
    public func handwritingDelegateFlags(_ value: HandwritingDelegateFlag) -> Self {
        HandwritingDelegateFlagsProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HandwritingDelegatorCallback

// TODO:

// MARK: HapticFeedbackEnabled

struct HapticFeedbackEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHapticFeedbackEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view should have haptic feedback for events such as long presses.
    @discardableResult
    public func hapticFeedbackEnabled(_ value: Bool = true) -> Self {
        HapticFeedbackEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HasTransientState

struct HasTransientStateViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHasTransientState
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view is currently tracking transient state that the framework should attempt to preserve when possible.
    @discardableResult
    public func hasTransientState(_ value: Bool = true) -> Self {
        HasTransientStateViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HorizontalFadingEdgeEnabled

struct HorizontalFadingEdgeEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHorizontalFadingEdgeEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Define whether the horizontal edges should be faded when this view is scrolled horizontally.
    @discardableResult
    public func horizontalFadingEdgeEnabled(_ value: Bool = true) -> Self {
        HorizontalFadingEdgeEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HorizontalScrollBarEnabled

struct HorizontalScrollBarEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHorizontalScrollBarEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Define whether the horizontal scrollbar should be drawn or not.
    @discardableResult
    public func horizontalScrollBarEnabled(_ value: Bool = true) -> Self {
        HorizontalScrollBarEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: HorizontalScrollbarThumbDrawable

// TODO:

// MARK: HorizontalScrollbarTrackDrawable

// TODO:

// MARK: Hovered

struct HoveredViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setHovered
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether the view is currently hovered.
    @discardableResult
    public func hovered(_ value: Bool = true) -> Self {
        HoveredViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Id

// Inner implementation overrides it.

// MARK: ImportantForAccessibility

public enum ImportantForAccessibilityMode: Int32 {
    case auto = 0
    case yes = 1
    case no = 2
    case noHideDescendants = 4
}
struct ImportantForAccessibilityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setImportantForAccessibility
    let value: ImportantForAccessibilityMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets how to determine whether this view is important for accessibility which is if it fires accessibility events and if it is reported to accessibility services that query the screen.
    @discardableResult
    public func importantForAccessibility(_ value: ImportantForAccessibilityMode) -> Self {
        ImportantForAccessibilityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ImportantForAutofill

public enum ImportantForAutofillMode: Int32 {
    case auto = 0
    case captureNo = 2
    case captureNoExcludeDescendants = 8
    case captureYes = 1
    case captureYesExcludeDescendants = 4
}
struct ImportantForAutofillProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setImportantForAutofill
    let value: ImportantForAutofillMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets the mode for determining whether this view is considered important for autofill.
    @discardableResult
    public func importantForAutofill(_ value: ImportantForAutofillMode) -> Self {
        ImportantForAutofillProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ImportantForContentCapture

public enum ImportantForContentCaptureMode: Int32 {
    case auto = 0
    case captureNo = 2
    case captureNoExcludeDescendants = 8
    case captureYes = 1
    case captureYesExcludeDescendants = 4
}
struct ImportantForContentCaptureProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setImportantForContentCapture
    let value: ImportantForContentCaptureMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// 
    @discardableResult
    public func importantForContentCapture(_ value: ImportantForContentCaptureMode) -> Self {
        ImportantForContentCaptureProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: IsCredential

struct IsCredentialViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setIsCredential
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether this view is a credential for Credential Manager purposes.
    @discardableResult
    public func isCredential(_ value: Bool = true) -> Self {
        IsCredentialViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: IsHandwritingDelegate

struct IsHandwritingDelegateViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setIsHandwritingDelegate
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets this view to be a handwriting delegate.
    @discardableResult
    public func isHandwritingDelegate(_ value: Bool = true) -> Self {
        IsHandwritingDelegateViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Itself

extension AnyView {
    /// Assigns the view itself to the provided inout parameter and returns the view.
    @discardableResult
    public func itself(_ itself: inout Self?) -> Self {
        itself = self
        return self
    }
}

// MARK: KeepScreenOn

struct KeepScreenOnViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setKeepScreenOn
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Controls whether the screen should remain on, modifying the value of `KEEP_SCREEN_ON`.
    @discardableResult
    public func keepScreenOn(_ value: Bool = true) -> Self {
        KeepScreenOnViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: KeyboardNavigationCluster

struct KeyboardNavigationClusterViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setKeyboardNavigationCluster
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view is a root of a keyboard navigation cluster.
    @discardableResult
    public func keyboardNavigationCluster(_ value: Bool = true) -> Self {
        KeyboardNavigationClusterViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: LabelFor

struct LabelForProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLabelFor
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of a view for which this view serves as a label for accessibility purposes.
    @discardableResult
    public func labelFor(_ value: Int32) -> Self {
        LabelForProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: LayerPaint

// TODO:

// MARK: LayerType

// TODO:

// MARK: LayoutDirection

public enum LayoutDirection: Int32 {
    /// Horizontal layout direction of this view is from Left to Right.
    case ltr = 0
    /// Horizontal layout direction of this view is from Right to Left.
    case rtl = 1
    /// Horizontal layout direction of this view is inherited from its parent.
    case inherit = 2
    /// Horizontal layout direction of this view is from deduced from the default language script for the locale.
    case locale = 3
}
struct LayoutDirectionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLayoutDirection
    let value: LayoutDirection
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the layout direction for this view.
    @discardableResult
    public func layoutDirection(_ value: LayoutDirection) -> Self {
        LayoutDirectionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: LayoutParams

// Inner implementation overrides it.

// MARK: Left

struct LeftProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLeft
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the left position of this view relative to its parent.
    @discardableResult
    public func left(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        LeftProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: LeftTopRightBottom

struct LeftTopRightBottomProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLeftTopRightBottom
    let value: (Int, Int, Int, Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.4.toPixels(Int32(value.0)), value.4.toPixels(Int32(value.1)), value.4.toPixels(Int32(value.2)), value.4.toPixels(Int32(value.3)))
    }
}
extension View {
    /// Assign a size and position to this view.
    ///
    /// Low-level layout method that directly sets the view's bounding box coordinates. Use with caution.
    @discardableResult
    public func leftTopRightBottom(_ left: Int, _ top: Int, _ right: Int, _ bottom: Int, _ unit: DimensionUnit = .dp) -> Self {
        LeftTopRightBottomProperty(value: (left, top, right, bottom, unit)).applyOrAppend(nil, self)
    }
}

// MARK: LongClickable

struct LongClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLongClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enables or disables long click events for this view.
    @discardableResult
    public func longClickable(_ value: Bool = true) -> Self {
        LongClickableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: MinimumHeight

struct MinimumHeightProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setMinimumHeight
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the minimum height of the view.
    @discardableResult
    public func minimumHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MinimumHeightProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: MinimumWidth

struct MinimumWidthProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setMinimumWidth
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the minimum width of the view.
    @discardableResult
    public func minimumWidth(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        MinimumWidthProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: NestedScrollingEnabled

struct NestedScrollingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNestedScrollingEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Enable or disable nested scrolling for this view.
    @discardableResult
    public func nestedScrollingEnabled(_ value: Bool = true) -> Self {
        NestedScrollingEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextClusterForwardId

struct NextClusterForwardIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextClusterForwardId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use as the root of the next keyboard navigation cluster.
    @discardableResult
    public func nextClusterForwardId(_ value: Int32) -> Self {
        NextClusterForwardIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextFocusDownId

struct NextFocusDownIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextFocusDownId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use when the next focus is `FOCUS_DOWN`.
    @discardableResult
    public func nextFocusDownId(_ value: Int32) -> Self {
        NextFocusDownIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextFocusForwardId

struct NextFocusForwardIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextFocusForwardId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use when the next focus is `FOCUS_FORWARD`.
    @discardableResult
    public func nextFocusForwardId(_ value: Int32) -> Self {
        NextFocusForwardIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextFocusLeftId

struct NextFocusLeftIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextFocusLeftId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use when the next focus is `FOCUS_LEFT`.
    @discardableResult
    public func nextFocusLeftId(_ value: Int32) -> Self {
        NextFocusLeftIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextFocusRightId

struct NextFocusRightIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextFocusRightId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use when the next focus is `FOCUS_RIGHT`.
    @discardableResult
    public func nextFocusRightId(_ value: Int32) -> Self {
        NextFocusRightIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextFocusUpId

struct NextFocusUpIdProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNextFocusUpId
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the id of the view to use when the next focus is `FOCUS_UP`.
    @discardableResult
    public func nextFocusUpId(_ value: Int32) -> Self {
        NextFocusUpIdProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: OnApplyWindowInsetsListener

#if os(Android)
struct OnApplyWindowInsetsListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnApplyWindowInsetsListener
    let value: NativeOnApplyWindowInsetsListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnApplyWindowInsetsListener))
    }
}
#endif
extension View {
    public typealias ApplyWindowInsetsListenerEventHandler = @MainActor (NativeOnApplyWindowInsetsListenerEvent) -> WindowInsets
    /// Set an OnApplyWindowInsetsListener to take over the policy for applying window insets to this view.
    @discardableResult
    public func onApplyWindowInsets(_ handler: @escaping ApplyWindowInsetsListenerEventHandler) -> Self {
        #if os(Android)
        return OnApplyWindowInsetsListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return $0.insets }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnApplyWindowInsetsCompatListener

#if os(Android)
struct OnApplyWindowInsetsCompatListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnApplyWindowInsetsListener
    let value: NativeOnApplyWindowInsetsCompatListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        InnerLog.t("🌏🌏🌏 onApplyWindowInsetsCompat applyToInstance 1")
        if value.instance == nil {
            value.attach(to: instance)
        }
        InnerLog.t("🌏🌏🌏 onApplyWindowInsetsCompat applyToInstance 2")
        guard let view = instance.view else { return }
        InnerLog.t("🌏🌏🌏 onApplyWindowInsetsCompat applyToInstance 3")
        ViewCompat.onApplyWindowInsetsListener(view, value)
    }
}
#endif
extension View {
    public typealias ApplyWindowInsetsCompatListenerEventHandler = @MainActor (NativeOnApplyWindowInsetsCompatListenerEvent) -> WindowInsetsCompat
    /// Set an OnApplyWindowInsetsListener to take over the policy for applying window insets to this view.
    @discardableResult
    public func onApplyWindowInsetsCompat(_ handler: @escaping ApplyWindowInsetsCompatListenerEventHandler) -> Self {
        InnerLog.t("🌏🌏🌏 onApplyWindowInsetsCompat")
        #if os(Android)
        return OnApplyWindowInsetsCompatListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return $0.insets }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnCapturedPointerListener

#if os(Android)
struct OnCapturedPointerListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnCapturedPointerListener
    let value: NativeOnCapturedPointerListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewCapturedPointerListener))
    }
}
#endif
extension View {
    public typealias CapturedPointerListenerHandler = @MainActor () -> Bool
    public typealias CapturedPointerListenerEventHandler = @MainActor (NativeOnCapturedPointerListenerEvent) -> Bool
    /// Set a listener to receive callbacks when the pointer capture state of a view changes.
    @discardableResult
    public func onCapturedPointer(_ handler: @escaping CapturedPointerListenerHandler) -> Self {
        #if os(Android)
        return OnCapturedPointerListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Set a listener to receive callbacks when the pointer capture state of a view changes.
    @discardableResult
    public func onCapturedPointer(_ handler: @escaping CapturedPointerListenerEventHandler) -> Self {
        #if os(Android)
        return OnCapturedPointerListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor[weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnClickListener

#if os(Android)
struct OnClickListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnClickListener
    let value: NativeOnClickListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnClickListener))
    }
}
#endif
extension View {
    public typealias ClickListenerHandler = @MainActor () async -> Void
    public typealias ClickListenerEventHandler = @MainActor (NativeOnClickListenerEvent) async -> Void
    /// Register a callback to be invoked when this view is clicked.
    @discardableResult
    public func onClick(_ handler: @escaping ClickListenerHandler) -> Self {
        #if os(Android)
        return OnClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when this view is clicked.
    @discardableResult
    public func onClick(_ handler: @escaping ClickListenerEventHandler) -> Self {
        #if os(Android)
        return OnClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnContextClickListener

#if os(Android)
struct OnContextClickListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnContextClickListener
    let value: NativeOnContextClickListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnContextClickListener))
    }
}
#endif
extension View {
    public typealias ContextClickListenerHandler = @MainActor () -> Bool
    public typealias ContextClickListenerEventHandler = @MainActor (NativeOnContextClickListenerEvent) -> Bool
    /// Register a callback to be invoked when this view is context clicked. If the view is not context clickable, it becomes context clickable.
    @discardableResult
    public func onContextClick(_ handler: @escaping ContextClickListenerHandler) -> Self {
        #if os(Android)
        return OnContextClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when this view is context clicked. If the view is not context clickable, it becomes context clickable.
    @discardableResult
    public func onContextClick(_ handler: @escaping ContextClickListenerEventHandler) -> Self {
        #if os(Android)
        return OnContextClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnCreateContextMenuListener

// #if os(Android)
// struct OnCreateContextMenuListenerViewProperty: ViewPropertyToApply {
//     let key: ViewPropertyKey = .setOnCreateContextMenuListener
//     let value: NativeOnCreateContextMenuListener
//     func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
//         if value.instance == nil {
//             value.attach(to: instance)
//         }
//         guard let listener = value.instance else { return }
//         instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnCreateContextMenuListener))
//     }
// }
// #endif
// extension View {
//     #if os(Android)
//     public typealias CreateContextMenuListenerHandler = @MainActor () -> Void
//     public typealias CreateContextMenuListenerEventHandler = @MainActor (NativeOnCreateContextMenuListenerEvent) -> Void
//     #else
//     public typealias CreateContextMenuListenerHandler = () -> Void
//     public typealias CreateContextMenuListenerEventHandler = (NativeOnCreateContextMenuListenerEvent) -> Void
//     #endif
//     /// Register a callback to be invoked when the context menu for this view is being built. If this view is not long clickable, it becomes long clickable.
//     @discardableResult
//     public func onCreateContextMenu(_ handler: @escaping CreateContextMenuListenerHandler) -> Self {
//         #if os(Android)
//         return OnCreateContextMenuListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
//         #else
//         return self
//         #endif
//     }
//     /// Register a callback to be invoked when the context menu for this view is being built. If this view is not long clickable, it becomes long clickable.
//     @discardableResult
//     public func onCreateContextMenu(_ handler: @escaping CreateContextMenuListenerHandler) -> Self {
//         #if os(Android)
//         return OnCreateContextMenuListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
//             guard let self else { return false }
//             return handler($0)
//         }).applyOrAppend(nil, self)
//         #else
//         return self
//         #endif
//     }
// }

// MARK: OnDragListener

#if os(Android)
struct OnDragListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnDragListener
    let value: NativeOnDragListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnDragListener))
    }
}
#endif
extension View {
    public typealias DragListenerHandler = @MainActor () -> Bool
    public typealias DragListenerEventHandler = @MainActor (NativeOnDragListenerEvent) -> Bool
    /// Register a drag event listener callback object for this View.
    @discardableResult
    public func onDrag(_ handler: @escaping DragListenerHandler) -> Self {
        #if os(Android)
        return OnDragListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a drag event listener callback object for this View.
    @discardableResult
    public func onDrag(_ handler: @escaping DragListenerEventHandler) -> Self {
        #if os(Android)
        return OnDragListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnFocusChangeListener

#if os(Android)
struct OnFocusChangeListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnFocusChangeListener
    let value: NativeOnFocusChangeListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnFocusChangeListener))
    }
}
#endif
extension View {
    public typealias FocusChangeListenerHandler = @MainActor () -> Void
    public typealias FocusChangeListenerEventHandler = @MainActor (NativeOnFocusChangeListenerEvent) -> Void
    /// Register a callback to be invoked when the focus state of this view changes.
    @discardableResult
    public func onFocusChange(_ handler: @escaping FocusChangeListenerHandler) -> Self {
        #if os(Android)
        return OnFocusChangeListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when the focus state of this view changes.
    @discardableResult
    public func onFocusChange(_ handler: @escaping FocusChangeListenerEventHandler) -> Self {
        #if os(Android)
        return OnFocusChangeListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnGenericMotionListener

#if os(Android)
struct OnGenericMotionListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnGenericMotionListener
    let value: NativeOnGenericMotionListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnGenericMotionListener))
    }
}
#endif
extension View {
    public typealias GenericMotionListenerHandler = @MainActor () -> Bool
    public typealias GenericMotionListenerEventHandler = @MainActor (NativeOnGenericMotionListenerEvent) -> Bool
    /// Register a callback to be invoked when a generic motion event is sent to this view.
    @discardableResult
    public func onGenericMotion(_ handler: @escaping GenericMotionListenerHandler) -> Self {
        #if os(Android)
        return OnGenericMotionListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when a generic motion event is sent to this view.
    @discardableResult
    public func onGenericMotion(_ handler: @escaping GenericMotionListenerEventHandler) -> Self {
        #if os(Android)
        return OnGenericMotionListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnHoverListener

#if os(Android)
struct OnHoverListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnHoverListener
    let value: NativeOnHoverListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnHoverListener))
    }
}
#endif
extension View {
    public typealias HoverListenerHandler = @MainActor () -> Bool
    public typealias HoverListenerEventHandler = @MainActor (NativeOnHoverListenerEvent) -> Bool
    /// Register a callback to be invoked when a hover event is sent to this view.
    @discardableResult
    public func onHover(_ handler: @escaping HoverListenerHandler) -> Self {
        #if os(Android)
        return OnHoverListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when a hover event is sent to this view.
    @discardableResult
    public func onHover(_ handler: @escaping HoverListenerEventHandler) -> Self {
        #if os(Android)
        return OnHoverListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnKeyListener

#if os(Android)
struct OnKeyListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnKeyListener
    let value: NativeOnKeyListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnKeyListener))
    }
}
#endif
extension View {
    public typealias KeyListenerHandler = @MainActor () -> Bool
    public typealias KeyListenerEventHandler = @MainActor (NativeOnKeyListenerEvent) -> Bool
    /// Register a callback to be invoked when a hardware key is pressed in this view. Key presses in software input methods will generally not trigger the methods of this listener.
    @discardableResult
    public func onKey(_ handler: @escaping KeyListenerHandler) -> Self {
        #if os(Android)
        return OnKeyListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when a hardware key is pressed in this view. Key presses in software input methods will generally not trigger the methods of this listener.
    @discardableResult
    public func onKey(_ handler: @escaping KeyListenerEventHandler) -> Self {
        #if os(Android)
        return OnKeyListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnLongClickListener

#if os(Android)
struct OnLongClickListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnLongClickListener
    let value: NativeOnLongClickListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnLongClickListener))
    }
}
#endif
extension View {
    public typealias LongClickListenerBoolHandler = @MainActor () -> Bool
    public typealias LongClickListenerHandler = @MainActor () -> Void
    public typealias LongClickListenerEventBoolHandler = @MainActor (NativeOnLongClickListenerEvent) -> Bool
    public typealias LongClickListenerEventHandler = @MainActor (NativeOnLongClickListenerEvent) -> Void
    
    /// Register a callback to be invoked when this view is clicked and held. Return `true` if you catch the event. Returns `true` by default.
    @discardableResult
    public func onLongClick(_ handler: @escaping LongClickListenerBoolHandler) -> Self {
        #if os(Android)
        return OnLongClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when this view is clicked and held. Return `true` if you catch the event. Returns `true` by default.
    @discardableResult
    public func onLongClick(_ handler: @escaping LongClickListenerHandler) -> Self {
        onLongClick {
            handler()
            return true
        }
    }
    /// Register a callback to be invoked when this view is clicked and held. Return `true` if you catch the event. Returns `true` by default.
    @discardableResult
    public func onLongClick(_ handler: @escaping LongClickListenerEventBoolHandler) -> Self {
        #if os(Android)
        return OnLongClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when this view is clicked and held. Return `true` if you catch the event. Returns `true` by default.
    @discardableResult
    public func onLongClick(_ handler: @escaping LongClickListenerEventHandler) -> Self {
        onLongClick { e in
            handler(e)
            return true
        }
    }
}

// MARK: OnReceiveContentListener

#if os(Android)
struct OnReceiveContentListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnReceiveContentListener
    let value: NativeOnReceiveContentListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnReceiveContentListener))
    }
}
#endif
extension View {
    public typealias ReceiveContentListenerHandler = @MainActor () -> ContentInfo?
    public typealias ReceiveContentListenerEventHandler = @MainActor (NativeOnReceiveContentListenerEvent) -> ContentInfo?
    /// Sets the listener to be used to handle insertion of content into this view.
    @discardableResult
    public func onReceiveContent(_ handler: @escaping ReceiveContentListenerHandler) -> Self {
        #if os(Android)
        return OnReceiveContentListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Sets the listener to be used to handle insertion of content into this view.
    @discardableResult
    public func onReceiveContent(_ handler: @escaping ReceiveContentListenerEventHandler) -> Self {
        #if os(Android)
        return OnReceiveContentListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return nil }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnScrollChangeListener

#if os(Android)
struct OnScrollChangeListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnScrollChangeListener
    let value: NativeOnScrollChangeListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnScrollChangeListener))
    }
}
#endif
extension View {
    public typealias ScrollChangeListenerHandler = @MainActor () -> Void
    public typealias ScrollChangeListenerEventHandler = @MainActor (NativeOnScrollChangeListenerEvent) -> Void
    /// Register a callback to be invoked when the scroll X or Y positions of this view change.
    @discardableResult
    public func onScrollChange(_ handler: @escaping ScrollChangeListenerHandler) -> Self {
        #if os(Android)
        return OnScrollChangeListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when the scroll X or Y positions of this view change.
    @discardableResult
    public func onScrollChange(_ handler: @escaping ScrollChangeListenerEventHandler) -> Self {
        #if os(Android)
        return OnScrollChangeListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return }
            handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnSystemUiVisibilityChangeListener

#if os(Android)
struct OnSystemUiVisibilityChangeListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnSystemUiVisibilityChangeListener
    let value: NativeOnSystemUiVisibilityChangeListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnSystemUiVisibilityChangeListener))
    }
}
#endif
extension View {
    public typealias SystemUiVisibilityChangeListenerHandler = @MainActor (_ visibility: SystemUIFlag) -> Void
    /// Set a listener to receive callbacks when the visibility of the system bar changes.
    @discardableResult
    public func onSystemUIVisibilityChange(_ handler: @escaping SystemUiVisibilityChangeListenerHandler) -> Self {
        #if os(Android)
        return OnSystemUiVisibilityChangeListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnTouchListener

#if os(Android)
struct OnTouchListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOnTouchListener
    let value: NativeOnTouchListener
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: .android.view.ViewOnTouchListener))
    }
}
#endif
extension View {
    public typealias TouchListenerHandler = @MainActor () -> Bool
    public typealias TouchListenerEventHandler = @MainActor (NativeOnTouchListenerEvent) -> Bool
    /// Register a callback to be invoked when a touch event is sent to this view.
    @discardableResult
    public func onTouch(_ handler: @escaping TouchListenerHandler) -> Self {
        #if os(Android)
        return OnTouchListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Register a callback to be invoked when a touch event is sent to this view.
    @discardableResult
    public func onTouch(_ handler: @escaping TouchListenerEventHandler) -> Self {
        #if os(Android)
        return OnTouchListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @MainActor [weak self] in
            guard let self else { return false }
            return handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OutlineAmbientShadowColor

struct OutlineAmbientShadowColorProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOutlineAmbientShadowColor
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension View {
    /// Sets the color of the ambient shadow that is drawn when the view has a positive Z or elevation value.
    @discardableResult
    public func outlineAmbientShadowColor(_ value: GraphicsColor) -> Self {
        OutlineAmbientShadowColorProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: OutlineProvider

// TODO:

// MARK: OutlineSpotShadowColor

struct OutlineSpotShadowColorProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOutlineSpotShadowColor
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension View {
    /// Sets the color of the spot shadow that is drawn when the view has a positive Z or elevation value.
    @discardableResult
    public func outlineSpotShadowColor(_ value: GraphicsColor) -> Self {
        OutlineSpotShadowColorProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: OverScrollMode

public enum OverScrollMode: Int32 {
    /// Always allow a user to over-scroll this view, provided it is a view that can scroll.
    case always = 0
    /// Allow a user to over-scroll this view only if the content is large enough to meaningfully scroll, provided it is a view that can scroll.
    case ifContentScrolls = 1
    /// Never allow a user to over-scroll this view.
    case never = 2
}
struct OverScrollModeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setOverScrollMode
    let value: OverScrollMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the over-scroll mode for this view.
    @discardableResult
    public func overScrollMode(_ value: OverScrollMode) -> Self {
        OverScrollModeProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Padding

struct PaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPadding
    let value: (Int, Int, Int, Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.4.toPixels(Int32(value.0)), value.4.toPixels(Int32(value.1)), value.4.toPixels(Int32(value.2)), value.4.toPixels(Int32(value.3)))
    }
}
extension View {
    /// Sets the padding.
    @discardableResult
    public func padding(left: Int, top: Int, right: Int, bottom: Int, _ unit: DimensionUnit = .dp) -> Self {
        PaddingViewProperty(value: (left, top, right, bottom, unit)).applyOrAppend(nil, self)
    }
    /// Sets the padding.
    @discardableResult
    public func padding(h: Int, v: Int, _ unit: DimensionUnit = .dp) -> Self {
        padding(left: h, top: v, right: h, bottom: v, unit)
    }
    /// Sets the padding.
    @discardableResult
    public func padding(_ value: Int = 16, _ unit: DimensionUnit = .dp) -> Self {
        padding(left: value, top: value, right: value, bottom: value, unit)
    }
}

// MARK: PaddingRelative

struct PaddingRelativeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPaddingRelative
    let value: (Int, Int, Int, Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.4.toPixels(Int32(value.0)), value.4.toPixels(Int32(value.1)), value.4.toPixels(Int32(value.2)), value.4.toPixels(Int32(value.3)))
    }
}
extension View {
    /// Sets the relative padding.
    @discardableResult
    public func paddingRelative(left: Int, top: Int, right: Int, bottom: Int, _ unit: DimensionUnit = .dp) -> Self {
        PaddingRelativeViewProperty(value: (left, top, right, bottom, unit)).applyOrAppend(nil, self)
    }
    /// Sets the relative padding.
    @discardableResult
    public func paddingRelative(h: Int, v: Int, _ unit: DimensionUnit = .dp) -> Self {
        paddingRelative(left: h, top: v, right: h, bottom: v, unit)
    }
    /// Sets the relative padding.
    @discardableResult
    public func paddingRelative(_ value: Int = 16, _ unit: DimensionUnit = .dp) -> Self {
        paddingRelative(left: value, top: value, right: value, bottom: value, unit)
    }
}

// MARK: PendingCredentialRequest

// TODO:

// MARK: PivotX

struct PivotXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPivotX
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the `x` location of the point around which the view is rotated and scaled.
    @discardableResult
    public func pivotX(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        PivotXProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: PivotY

struct PivotYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPivotY
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the `y` location of the point around which the view is rotated and scaled.
    @discardableResult
    public func pivotY(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        PivotYProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// TODO:

// MARK: PointerIcon

// TODO:

// MARK: PreferKeepClear

struct PreferKeepClearViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPreferKeepClear
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set a preference to keep the bounds of this view clear from floating windows above this view's window.
    /// 
    /// This informs the system that the view is considered a vital area for the user and that ideally it should not be covered.
    /// Setting this is only appropriate for UI where the user would likely take action to uncover it.
    /// 
    /// The system will try to respect this preference, but when not possible will ignore it.
    @discardableResult
    public func preferKeepClear(_ value: Bool = true) -> Self {
        PreferKeepClearViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: PreferKeepClearRects

// TODO:

// MARK: Pressed

struct PressedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPressed
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the pressed state for this view.
    @discardableResult
    public func pressed(_ value: Bool = true) -> Self {
        PressedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RenderEffect

// TODO:

// MARK: RequestedFrameRate

public struct RequestedFrameRate: ExpressibleByIntegerLiteral, Sendable {
    public let value: Int32

    public init (integerLiteral value: Int32) {
        self.value = value
    }
    
    public static let high: Self = -4
    public static let low: Self = -2
    public static let normal: Self = -3
    public static let noPreference: Self = -1
}
struct RequestedFrameRateProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRequestedFrameRate
    let value: RequestedFrameRate
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension View {
    /// You can set the preferred frame rate for a View using a positive number or by specifying the preferred frame rate category using constants.
    @discardableResult
    public func requestedFrameRate(_ value: RequestedFrameRate) -> Self {
        RequestedFrameRateProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RevealOnFocusHint

struct RevealOnFocusHintViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRevealOnFocusHint
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets this view's preference for reveal behavior when it gains focus.
    @discardableResult
    public func revealOnFocusHint(_ value: Bool = true) -> Self {
        RevealOnFocusHintViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RequestApplyInsets

extension View {
    /// Ask that a new dispatch of `View.onApplyWindowInsets(WindowInsets)` be performed.
    public func requestApplyInsets() {
        instance?.callVoidMethod(name: "requestApplyInsets")
    }
}

// MARK: RequestLayout

extension View {
    /// Call this when something has changed which has invalidated the layout of this view. This will schedule a layout pass of the view tree.
    public func requestLayout() {
        instance?.callVoidMethod(name: "requestLayout")
    }
}

// MARK: Invalidate

extension View {
    /// Invalidate the whole view. If the view is visible, `onDraw(Canvas)` will be called at some point in the future.
    public func invalidate() {
        instance?.callVoidMethod(name: "invalidate")
    }
}

// MARK: Right

struct RightProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRight
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the right position of this view relative to its parent.
    @discardableResult
    public func right(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        RightProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Rotation

struct RotationProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRotation
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the degrees that the view is rotated around the pivot point.
    @discardableResult
    public func rotation(_ value: Float) -> Self {
        RotationProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RotationX

struct RotationXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRotationX
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the degrees that the view is rotated around the horizontal axis through the pivot point.
    @discardableResult
    public func rotationX(_ value: Float) -> Self {
        RotationXProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RotationY

struct RotationYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRotationY
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the degrees that the view is rotated around the vertical axis through the pivot point.
    @discardableResult
    public func rotationY(_ value: Float) -> Self {
        RotationYProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SaveEnabled

struct SaveEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSaveEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Controls whether the saving of this view's state is enabled (that is, whether its onSaveInstanceState() method will be called).
    @discardableResult
    public func saveEnabled(_ value: Bool = true) -> Self {
        SaveEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SaveFromParentEnabled

struct SaveFromParentEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSaveFromParentEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Controls whether the entire hierarchy under this view will save its state when a state saving traversal occurs from its parent.
    @discardableResult
    public func saveFromParentEnabled(_ value: Bool = true) -> Self {
        SaveFromParentEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScaleX

struct ScaleXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScaleX
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the amount that the view is scaled in x around the pivot point, as a proportion of the view's unscaled width.
    @discardableResult
    public func scaleX(_ value: Float) -> Self {
        ScaleXProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScaleY

struct ScaleYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScaleY
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the amount that the view is scaled in Y around the pivot point, as a proportion of the view's unscaled width.
    @discardableResult
    public func scaleY(_ value: Float) -> Self {
        ScaleYProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScreenReaderFocusable

struct ScreenReaderFocusableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScreenReaderFocusable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets whether this View should be a focusable element for screen readers and include non-focusable Views from its subtree when providing feedback.
    @discardableResult
    public func screenReaderFocusable(_ value: Bool = true) -> Self {
        ScreenReaderFocusableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarDefaultDelayBeforeFade

struct ScrollBarDefaultDelayBeforeFadeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollBarDefaultDelayBeforeFade
    let value: Double
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value * 1000))
    }
}
extension View {
    /// Define the delay before scrollbars fade (in seconds).
    @discardableResult
    public func scrollBarDefaultDelayBeforeFade(_ value: Double) -> Self {
        ScrollBarDefaultDelayBeforeFadeProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarFadeDuration

struct ScrollBarFadeDurationProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollBarFadeDuration
    let value: Double
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value * 1000))
    }
}
extension View {
    /// Define the scrollbar fade duration (in seconds).
    @discardableResult
    public func scrollBarFadeDuration(_ value: Double) -> Self {
        ScrollBarFadeDurationProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarSize

struct ScrollBarSizeProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollBarSize
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Define the scrollbar size.
    @discardableResult
    public func scrollBarSize(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        ScrollBarSizeProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarStyle

public enum ScrollBarStyle: Int32 {
    case insideInset = 0x01000000
    case insideOverlay = 0x00000000
    case outsideInset = 0x03000000
    case outsideOverlay = 0x02000000
}
struct ScrollBarStyleProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollBarStyle
    let value: ScrollBarStyle
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Specify the style of the scrollbars.
    @discardableResult
    public func scrollBarStyle(_ value: ScrollBarStyle) -> Self {
        ScrollBarStyleProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollCaptureCallback

// TODO:

// MARK: ScrollCaptureHint

public enum ScrollCaptureHint: Int32 {
    case auto = 0
    case exclude = 1
    case excludeDescendants = 4
    case include = 2
}
struct ScrollCaptureHintProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollCaptureHint
    let value: ScrollCaptureHint
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Sets the scroll capture hint for this View.
    @discardableResult
    public func scrollCaptureHint(_ value: ScrollCaptureHint) -> Self {
        ScrollCaptureHintProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollContainer

struct ScrollContainerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollContainer
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Change whether this view is one of the set of scrollable containers in its window.
    @discardableResult
    public func scrollContainer(_ value: Bool = true) -> Self {
        ScrollContainerViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollIndicators

public enum ScrollIndicator: Int32 {
    case top = 1
    case bottom = 2
    case left = 4
    case right = 8
    case start = 16
    case end = 32
}
struct ScrollIndicatorsProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollIndicators
    let value: (ScrollIndicator, ScrollIndicator?)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if let mask = value.1 {
            instance.callVoidMethod(env, name: key.rawValue, args: value.0.rawValue, mask.rawValue)
        } else {
            instance.callVoidMethod(env, name: key.rawValue, args: value.0.rawValue)
        }
    }
}
extension View {
    /// Sets the state of all scroll indicators.
    @discardableResult
    public func scrollIndicators(_ indicators: ScrollIndicator, _ mask: ScrollIndicator? = nil) -> Self { // TODO: add bitwise mask
        ScrollIndicatorsProperty(value: (indicators, mask)).applyOrAppend(nil, self)
    }
}

// MARK: ScrollX

struct ScrollXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollX
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Set the horizontal scrolled position of your view.
    @discardableResult
    public func scrollX(_ value: Int, _ unit: DimensionUnit = .px) -> Self {
        ScrollXProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: ScrollY

struct ScrollYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollY
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Set the vertical scrolled position of your view.
    @discardableResult
    public func scrollY(_ value: Int, _ unit: DimensionUnit = .px) -> Self {
        ScrollYProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: ScrollbarFadingEnabled

struct ScrollbarFadingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollbarFadingEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Define whether scrollbars will fade when the view is not scrolling.
    @discardableResult
    public func scrollbarFadingEnabled(_ value: Bool = true) -> Self {
        ScrollbarFadingEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Selected

struct SelectedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSelected
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Changes the selection state of this view.
    @discardableResult
    public func selected(_ value: Bool = true) -> Self {
        SelectedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SoundEffectsEnabled

struct SoundEffectsEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSoundEffectsEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set whether this view should have sound effects enabled for events such as clicking and touching.
    @discardableResult
    public func soundEffectsEnabled(_ value: Bool = true) -> Self {
        SoundEffectsEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: StateDescription

struct StateDescriptionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setStateDescription
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(.java.lang.CharSequence))])
        #endif
    }
}
extension View {
    /// Sets the View's state description.
    @discardableResult
    public func stateDescription(_ value: String) -> Self {
        StateDescriptionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: StateListAnimator

// TODO:

// MARK: SupplementalDescription

// struct SupplementalDescriptionProperty: ViewPropertyToApply {
//     let key: ViewPropertyKey = .setSupplementalDescription
//     let value: String
//     func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
//         #if os(Android)
//         guard
//             let env = env ?? JEnv.current(),
//             let string = JString(from: value)
//         else { return }
//         instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(.java.lang.CharSequence))])
//         #endif
//     }
// }
// extension View {
//     /// Sets the View's supplemental description.
//     @discardableResult
//     public func supplementalDescription(_ value: String) -> Self {
//         SupplementalDescriptionProperty(value: value).applyOrAppend(nil, self)
//     }
// }

// MARK: SystemGestureExclusionRects

// TODO:

// MARK: SystemUiVisibility

public enum SystemUIFlag: Int32 {
    case fullscreen = 4
    case hideNavigation = 2
    case immersive = 2048
    case immersiveSticky = 4096
    case layoutFullscreen = 1024
    case layoutHideNavigation = 512
    case layoutStable = 256
    case lightNavigationBar = 16
    case lightStatusBar = 8192
    case lowProfile = 1
    case visible = 0
    case layoutFlags = 1536
}
struct SystemUiVisibilityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSystemUiVisibility
    let value: SystemUIFlag
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// **This method was deprecated in API level 30.**
    /// SystemUiVisibility flags are deprecated.
    /// Use `WindowInsetsController` instead.
    @discardableResult
    public func systemUiVisibility(_ value: SystemUIFlag) -> Self { // TODO: add bitwise mask
        SystemUiVisibilityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Tag

// TODO:

// MARK: TextAlignment

public enum TextAlignment: Int32 {
    /// Default text alignment. The text alignment of this View is inherited from its parent. 
    case inherit = 0
    /// Default for the root view. The gravity determines the text alignment, `ALIGN_NORMAL`, `ALIGN_CENTER`, or `ALIGN_OPPOSITE`, which are relative to each paragraph's text direction.
    case gravity = 1
    /// Align to the start of the paragraph, e.g. `ALIGN_NORMAL`.
    case textStart = 2
    /// Align to the end of the paragraph, e.g. `ALIGN_OPPOSITE`.
    case textEnd = 3
    /// Center the paragraph, e.g. ALIGN_CENTER.
    case center = 4
    /// Align to the start of the view, which is `ALIGN_LEFT` if the view's resolved layoutDirection is LTR, and `ALIGN_RIGHT` otherwise.
    case viewStart = 5
    /// Align to the end of the view, which is `ALIGN_RIGHT` if the view's resolved layoutDirection is LTR, and `ALIGN_LEFT` otherwise.
    case viewEnd = 6
}
struct TextAlignmentProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTextAlignment
    let value: TextAlignment
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the text alignment.
    @discardableResult
    public func textAlignment(_ value: TextAlignment) -> Self {
        TextAlignmentProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TextDirection

public enum TextDirection: Int32 {
    /// Text direction is inherited through ViewGroup
    case inherit = 0
    /// Text direction is using "first strong algorithm".
    /// The first strong directional character determines the paragraph direction.
    /// If there is no strong directional character, the paragraph direction is the view's resolved layout direction.
    case firstStrong = 1
    /// Text direction is using "any-RTL" algorithm.
    /// The paragraph direction is RTL if it contains any strong RTL character,
    /// otherwise it is LTR if it contains any strong LTR characters.
    /// If there are neither, the paragraph direction is the view's resolved layout direction.
    case anyRTL = 2
    /// Text direction is forced to LTR.
    case ltr = 3
    /// Text direction is forced to RTL.
    case rtl = 4
    /// Text direction is coming from the system Locale.
    case locale = 5
    /// Text direction is using "first strong algorithm".
    /// The first strong directional character determines the paragraph direction.
    /// If there is no strong directional character, the paragraph direction is LTR.
    case firstStrongLTR = 6
    /// Text direction is using "first strong algorithm".
    /// The first strong directional character determines the paragraph direction.
    /// If there is no strong directional character, the paragraph direction is RTL.
    case firstStrongRTL = 7
}
struct TextDirectionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTextDirection
    let value: TextDirection
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the text direction.
    @discardableResult
    public func textDirection(_ value: TextDirection) -> Self {
        TextDirectionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TooltipText

struct TooltipTextProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTooltipText
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(.java.lang.CharSequence))])
        #endif
    }
}
extension View {
    /// Sets the top position of this view relative to its parent.
    @discardableResult
    public func tooltipText(_ value: String) -> Self {
        TooltipTextProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Top

struct TopProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTop
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the top position of this view relative to its parent.
    @discardableResult
    public func top(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
        TopProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: TouchDelegate

// TODO:

// MARK: TransitionAlpha

struct TransitionAlphaProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTransitionAlpha
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// This property is intended only for use by the Fade transition,
    /// which animates it to produce a visual translucency
    /// that does not side-effect (or get affected by) the real alpha property.
    @discardableResult
    public func transitionAlpha(_ value: Float) -> Self {
        TransitionAlphaProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TransitionName

struct TransitionNameProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTransitionName
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        #if os(Android)
        guard
            let env = env ?? JEnv.current(),
            let string = JString(from: value)
        else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: [(string.object, .object(JString.className))])
        #endif
    }
}
extension View {
    /// Sets the name of the View to be used to identify Views in Transitions.
    @discardableResult
    public func transitionName(_ value: String) -> Self {
        TransitionNameProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TransitionVisibility

struct TransitionVisibilityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTransitionVisibility
    let value: ViewVisibility
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Changes the visibility of this View without triggering any other changes.
    @discardableResult
    public func transitionVisibility(_ value: ViewVisibility) -> Self {
        TransitionVisibilityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TranslationX

struct TranslationXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTranslationX
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the horizontal location of this view relative to its left position.
    @discardableResult
    public func translationX(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        TranslationXProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: TranslationY

struct TranslationYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTranslationY
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the vertical location of this view relative to its top position.
    @discardableResult
    public func translationY(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        TranslationYProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: TranslationZ

struct TranslationZProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTranslationZ
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension View {
    /// Sets the depth location of this view relative to its elevation.
    @discardableResult
    public func translationZ(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        TranslationZProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: VerticalFadingEdgeEnabled

struct VerticalFadingEdgeEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVerticalFadingEdgeEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Define whether the vertical edges should be faded when this view is scrolled vertically.
    @discardableResult
    public func verticalFadingEdgeEnabled(_ value: Bool = true) -> Self {
        VerticalFadingEdgeEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: VerticalScrollBarEnabled

struct VerticalScrollBarEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVerticalScrollBarEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Set the position of the vertical scroll bar.
    @discardableResult
    public func verticalScrollBarEnabled(_ value: Bool = true) -> Self {
        VerticalScrollBarEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: VerticalScrollbarPosition

public enum VerticalScrollbarPosition: Int32 {
    /// Position the scroll bar at the default position as determined by the system.
    case `default` = 0
    /// Position the scroll bar along the left edge.
    case left = 1
    /// Position the scroll bar along the right edge.
    case right = 2
}
struct VerticalScrollbarPositionProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVerticalScrollbarPosition
    let value: VerticalScrollbarPosition
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the position of the vertical scroll bar.
    @discardableResult
    public func verticalScrollbarPosition(_ value: VerticalScrollbarPosition) -> Self {
        VerticalScrollbarPositionProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: VerticalScrollbarThumbDrawable

// TODO:

// MARK: VerticalScrollbarTrackDrawable

// TODO:

// MARK: ViewTranslationCallback

// TODO:

// MARK: Visibility

public enum ViewVisibility: Int32 {
    /// Visible on screen; the default value.
    case visible = 0
    /// Not displayed, but taken into account during layout (space is left for it).
    case invisible = 1
    /// Completely hidden, as if the view had not been added.
    case gone = 2
}
struct VisibilityProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVisibility
    let value: ViewVisibility
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension View {
    /// Set the visibility state of this view.
    @discardableResult
    public func visibility(_ value: ViewVisibility) -> Self {
        VisibilityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: WillNotCacheDrawing

struct WillNotCacheDrawingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setWillNotCacheDrawing
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// This method was deprecated in API level 28.
    /// The view drawing cache was largely made obsolete with the introduction of hardware-accelerated rendering in API 11.
    /// With hardware-acceleration, intermediate cache layers are largely unnecessary and can easily result in a net loss in performance due to the cost of creating and updating the layer.
    @discardableResult
    public func willNotCacheDrawing(_ value: Bool = true) -> Self {
        WillNotCacheDrawingViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: WillNotDraw

struct WillNotDrawViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setWillNotDraw
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// If this view doesn't do any drawing on its own, set this flag to allow further optimizations.
    @discardableResult
    public func willNotDraw(_ value: Bool = true) -> Self {
        WillNotDrawViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: WindowInsetsAnimationCallback

// TODO:

// MARK: X

struct XProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setX
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(value.0))
    }
}
extension View {
    /// Sets the visual x position of this view, in pixels.
    @discardableResult
    public func x(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        XProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Y

struct YProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setY
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(value.0))
    }
}
extension View {
    /// Sets the visual x position of this view, in pixels.
    @discardableResult
    public func y(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        YProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}

// MARK: Z

struct ZProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setZ
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(value.0))
    }
}
extension View {
    /// Sets the visual z position of this view, in pixels.
    @discardableResult
    public func z(_ value: Float, _ unit: DimensionUnit = .dp) -> Self {
        ZProperty(value: (value, unit)).applyOrAppend(nil, self)
    }
}
