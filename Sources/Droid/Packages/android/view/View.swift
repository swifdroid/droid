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
    public class OnApplyWindowInsetsListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnApplyWindowInsetsListener: OnApplyWindowInsetsListenerClass { .init(parent: self, name: "View$OnApplyWindowInsetsListener") }
    public class OnClickListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnClickListener: OnClickListenerClass { .init(parent: self, name: "View$OnClickListener") }
    public class OnLongClickListenerClass: JClassName, @unchecked Sendable {}
    public var ViewOnLongClickListener: OnLongClickListenerClass { .init(parent: self, name: "View$OnLongClickListener") }
}

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public protocol AnyView: AnyObject, ViewInstanceable {
    static var gradleDependencies: [String] { get }
}
protocol _AnyView: AnyView {
    var _propertiesToApply: [any ViewPropertyToApply] { get set }
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

open class View: _AnyView, JClassNameable, @unchecked Sendable {
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

    open func applicableLayoutParams() -> [LayoutParamKey] {
        [
            .width,
            .height,
            .setMargins,
            .startMargin,
            .endMargin
        ]
    }

    public func filteredLayoutParams() -> [any LayoutParamToApply] {
        var applicableKeys = applicableLayoutParams()
        return _layoutParamsToApply.filter {
            if let index = applicableKeys.firstIndex(of: $0.key) {
                applicableKeys.remove(at: index)
                return true
            }
            return false
        }
    }
    
    open func processLayoutParams(_ context: ViewInstance, _ lp: LayoutParams, for subview: View) {
        let params = subview.filteredLayoutParams()
        let env = JEnv.current()
        params.forEach { $0.apply(env, context, lp) }
    }

    open func processProperties(_ propertiesToSkip: [ViewPropertyKey], _ instance: View.ViewInstance) {
        guard let env = JEnv.current() else { return }
        for property in _propertiesToApply {
            if propertiesToSkip.contains(property.key) { continue }
            property.applyToInstance(env, instance)
        }
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
        // InnerLog.d("view(id: \(id)) didMoveToParent 1")
        if let instance {
            // InnerLog.d("view(id: \(id)) didMoveToParent 2")
            processProperties([], instance)
            if subviews.count > 0 {
                // InnerLog.d("view(id: \(id)) didMoveToParent iterating subviews")
                for (i, subview) in subviews.filter({ v in
                    switch v.status {
                        case .new, .floating: return true
                        default: return false
                    }
                }).enumerated() {
                    // InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 1")
                    if let subviewInstance = subview.setStatusInParent(self, instance.context) {
                        // InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 2")
                        subview.willMoveToParent()
                        instance.addView(subviewInstance)
                        subview.didMoveToParent()
                    } else {
                        // InnerLog.d("view(id: \(id)) didMoveToParent iterating, subview(#\(i) id:\(subview.id)) 3")
                        InnerLog.c("🟥 Unable to initialize ViewInstance for `addView` in `didMoveToParent`")
                    }
                }
            }
            proceedSubviewsLayoutParams(instance)
        }
    }

    /// Triggered before this view removed from its parent view
    open func willMoveFromParent() {}
    /// Triggered after this view removed from its parent view
    open func didMoveFromParent() {
        setStatusFloating()
    }

    func setStatusAsContentView(_ context: ActivityContext) -> ViewInstance? {
        // InnerLog.d("view(id: \(id)) setStatusAsContentView 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.d("🟨 Attempt to `setAsContentView` when view is already has parent")
                return nil
        }
        // InnerLog.d("view(id: \(id)) setStatusAsContentView 2")
        guard let instance: ViewInstance = ViewInstance(Self.className, self, context, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setAsContentView`")
            return nil
        }
        // InnerLog.d("view(id: \(id)) setStatusAsContentView 3")
        status = .asContentView(instance)
        return instance
    }
    
    func setStatusInParent(_ parent: View, _ context: ActivityContext) -> ViewInstance? {
        // InnerLog.d("view(id: \(id)) setStatusInParent 1")
        switch status {
            case .new, .floating: break
            default:
                InnerLog.d("🟨 Attempt to `setStatusInParent` when view is already has parent")
                return nil
        }
        // InnerLog.d("view(id: \(id)) setStatusInParent 2")
        guard let instance = ViewInstance(Self.className, self, context, id) else {
            InnerLog.c("🟥 Unable to initialize ViewInstance for `setStatusInParent`")
            return nil
        }
        status = .inParent(parent, instance)
        // InnerLog.d("view(id: \(id)) setStatusInParent 3")
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
    
    var _propertiesToApply: [any ViewPropertyToApply] = []
    var _layoutParamsToApply: [any LayoutParamToApply] = []

    func proceedSubviewsLayoutParams(_ context: ViewInstance) {
        // InnerLog.d("view(id: \(id)) proceedSubviewsLayoutParams")
        for subview in subviews.filter({ v in
            switch v.status {
                case .inParent: return true
                default: return false
            }
        }) {
            if let lp = layoutParamsForSubviews() {
                processLayoutParams(context, lp, for: subview)
                subview.setLayoutParams(lp)
            }
        }
    }
    
    // public func background(Object) -> Self {}

    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        addItem(block())
        return self
    }
    
    func addItem(_ item: BodyBuilderItemable, at index: Int? = nil) {
        addItem(item.bodyBuilderItem, at: index)
    }
    
    func addItem(_ item: BodyBuilderItem, at index: Int? = nil) {
        // InnerLog.d("view(id: \(id)) addItem 1")
        switch item {
        case .single(let view):
            // InnerLog.d("view(id: \(id)) addItem 2 (single)")
            add(views: [view], at: index)
        case .multiple(let views):
            // InnerLog.d("view(id: \(id)) addItem 3 (multiple)")
            add(views: views, at: index)
        case .forEach(let fr):
            InnerLog.d("view(id: \(id)) addItem 4 (forEach)")
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
            // InnerLog.d("view(id: \(id)) addItem 5 (nested)")
            items.forEach { addItem($0, at: index) }
            break
        case .none:
            // InnerLog.d("view(id: \(id)) addItem 6 (none)")
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

// MARK: AnimationMatrix

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

// MARK: AutofillId

// MARK: Background

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

// MARK: BackgroundTintList

// MARK: BackgroundTintMode

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
    public func Enabled(_ value: Bool = true) -> Self {
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

// MARK: ForegroundTintList

// MARK: ForegroundTintMode

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

// MARK: HorizontalScrollbarTrackDrawable

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
    /// Sets the mode for determining whether this view is considered important for content capture.
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

// MARK: LayerType

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
    #if canImport(AndroidLooper)
    public typealias ApplyWindowInsetsListenerHandler = @UIThreadActor () -> Void
    public typealias ApplyWindowInsetsListenerEventHandler = @UIThreadActor (NativeOnApplyWindowInsetsListenerEvent) -> Void
    #else
    public typealias ApplyWindowInsetsListenerHandler = () -> Void
    public typealias ApplyWindowInsetsListenerEventHandler = (NativeOnApplyWindowInsetsListenerEvent) -> Void
    #endif
    /// Set an OnApplyWindowInsetsListener to take over the policy for applying window insets to this view.
    @discardableResult
    public func onApplyWindowInsets(_ handler: @escaping ApplyWindowInsetsListenerHandler) -> Self {
        #if os(Android)
        return OnApplyWindowInsetsListenerViewProperty(value: .init(id, viewId: id).setHandler(self, handler)).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
    /// Set an OnApplyWindowInsetsListener to take over the policy for applying window insets to this view.
    @discardableResult
    public func onApplyWindowInsets(_ handler: @escaping ApplyWindowInsetsListenerEventHandler) -> Self {
        #if os(Android)
        return OnApplyWindowInsetsListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @UIThreadActor [weak self] in
            guard let self else { return }
            handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnCapturedPointerListener

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
    #if canImport(AndroidLooper)
    public typealias ClickListenerHandler = @UIThreadActor () -> Void
    public typealias ClickListenerEventHandler = @UIThreadActor (NativeOnClickListenerEvent) -> Void
    #else
    public typealias ClickListenerHandler = () -> Void
    public typealias ClickListenerEventHandler = (NativeOnClickListenerEvent) -> Void
    #endif
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
        return OnClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @UIThreadActor [weak self] in
            guard let self else { return }
            handler($0)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: OnContextClickListener

// MARK: OnCreateContextMenuListener

// MARK: OnDragListener

// MARK: OnFocusChangeListener

// MARK: OnGenericMotionListener

// MARK: OnHoverListener

// MARK: OnKeyListener

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
    #if canImport(AndroidLooper)
    public typealias LongClickListenerBoolHandler = @UIThreadActor () -> Bool
    public typealias LongClickListenerHandler = @UIThreadActor () -> Void
    public typealias LongClickListenerEventBoolHandler = @UIThreadActor (NativeOnLongClickListenerEvent) -> Bool
    public typealias LongClickListenerEventHandler = @UIThreadActor (NativeOnLongClickListenerEvent) -> Void
    #else
    public typealias LongClickListenerBoolHandler = () -> Bool
    public typealias LongClickListenerHandler = () -> Void
    public typealias LongClickListenerEventBoolHandler = (NativeOnLongClickListenerEvent) -> Bool
    public typealias LongClickListenerEventHandler = (NativeOnLongClickListenerEvent) -> Void
    #endif

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
        return OnLongClickListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { @UIThreadActor [weak self] in
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

// MARK: OnScrollChangeListener

// MARK: OnSystemUiVisibilityChangeListener

// MARK: OnTouchListener

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

// MARK: PivotX

struct PivotXProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPivotX
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the `x` location of the point around which the view is rotated and scaled.
    @discardableResult
    public func pivotX(_ value: Float) -> Self {
        PivotXProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: PivotY

struct PivotYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPivotY
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the `y` location of the point around which the view is rotated and scaled.
    @discardableResult
    public func pivotY(_ value: Float) -> Self {
        PivotYProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: PointerIcon

// MARK: PreferKeepClear

struct PreferKeepClearViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setPreferKeepClear
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the pressed state for this view.
    @discardableResult
    public func preferKeepClear(_ value: Bool = true) -> Self {
        PreferKeepClearViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: PreferKeepClearRects

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

// MARK: RequestedFrameRate

public enum RequestedFrameRate {
    case high
    case low
    case normal
    case noPreference
    case custom(Float)

    var rawValue: Float {
        switch self {
            case .high: return -4
            case .low: return -2
            case .normal: return -3
            case .noPreference: return -1
            case .custom(let value): return value
        }
    }
}
struct RequestedFrameRateProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRequestedFrameRate
    let value: RequestedFrameRate
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
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
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension View {
    /// Define the delay before scrollbars fade.
    @discardableResult
    public func scrollBarDefaultDelayBeforeFade(_ value: Int) -> Self {
        ScrollBarDefaultDelayBeforeFadeProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarFadeDuration

struct ScrollBarFadeDurationProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollBarFadeDuration
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension View {
    /// Define the scrollbar fade duration.
    @discardableResult
    public func scrollBarFadeDuration(_ value: Int) -> Self {
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
    public func scrollIndicators(_ indicators: ScrollIndicator, _ mask: ScrollIndicator? = nil) -> Self {
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
    public func systemUiVisibility(_ value: SystemUIFlag) -> Self {
        SystemUiVisibilityProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Tag

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
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the horizontal location of this view relative to its left position.
    @discardableResult
    public func translationX(_ value: Float) -> Self {
        TranslationXProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TranslationY

struct TranslationYProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTranslationY
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the vertical location of this view relative to its top position.
    @discardableResult
    public func translationY(_ value: Float) -> Self {
        TranslationYProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: TranslationZ

struct TranslationZProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setTranslationZ
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    /// Sets the depth location of this view relative to its elevation.
    @discardableResult
    public func translationZ(_ value: Float) -> Self {
        TranslationZProperty(value: value).applyOrAppend(nil, self)
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

// MARK: VerticalScrollbarTrackDrawable

// MARK: ViewTranslationCallback

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
