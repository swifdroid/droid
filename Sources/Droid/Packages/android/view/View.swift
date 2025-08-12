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
            processProperties([], instance)
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
    
    var _propertiesToApply: [any ViewPropertyToApply] = []
    var _layoutParamsToApply: [any LayoutParamToApply] = []

    func proceedSubviewsLayoutParams(_ context: ViewInstance) {
        InnerLog.d("view(id: \(id)) proceedSubviewsLayoutParams")
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
    @discardableResult
    public func accessibilityHeading(_ value: Bool = true) -> Self {
        AccessibilityHeadingViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AccessibilityLiveRegion

// MARK: AccessibilityPaneTitle

// MARK: AccessibilityTraversalAfter

// MARK: AccessibilityTraversalBefore

// MARK: Activated

struct ActivatedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setActivated
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func Activated(_ value: Bool = true) -> Self {
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
    @discardableResult
    public func allowClickWhenDisabled(_ value: Bool = true) -> Self {
        AllowClickWhenDisabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: AllowedHandwritingDelegatePackage

// MARK: AllowedHandwritingDelegatorPackage

// MARK: Alpha

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
    @discardableResult
    public func backgroundColor(_ color: GraphicsColor) -> Self {
        BackgroundColorViewProperty(value: color).applyOrAppend(nil, self)
        return self
    }
}

// MARK: BackgroundResource

// MARK: BackgroundTintBlendMode

// MARK: BackgroundTintList

// MARK: BackgroundTintMode

// MARK: Bottom

// MARK: CameraDistance

// MARK: Clickable

struct ClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func clipToOutline(_ value: Bool = true) -> Self {
        ClipToOutlineViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ContentCaptureSession

// MARK: ContentDescription

// MARK: ContentSensitivity

// MARK: ContextClickable

struct ContextClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setContextClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func defaultFocusHighlightEnabled(_ value: Bool = true) -> Self {
        DefaultFocusHighlightEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DrawingCacheBackgroundColor

// MARK: DrawingCacheEnabled

struct DrawingCacheEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDrawingCacheEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func drawingCacheEnabled(_ value: Bool = true) -> Self {
        DrawingCacheEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: DrawingCacheQuality

// MARK: DuplicateParentStateEnabled

struct DuplicateParentStateEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setDuplicateParentStateEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func duplicateParentStateEnabled(_ value: Bool = true) -> Self {
        DuplicateParentStateEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Elevation

// MARK: Enabled

struct EnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func Enabled(_ value: Bool = true) -> Self {
        EnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: FadingEdgeLength

// MARK: FilterTouchesWhenObscured

struct FilterTouchesWhenObscuredViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setFilterTouchesWhenObscured
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func forceDarkAllowed(_ value: Bool = true) -> Self {
        ForceDarkAllowedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Foreground

// MARK: ForegroundGravity

// MARK: ForegroundTintBlendMode

// MARK: ForegroundTintList

// MARK: ForegroundTintMode

// MARK: FrameContentVelocity

// MARK: HandwritingBoundsOffsets

// MARK: HandwritingDelegateFlags

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
    @discardableResult
    public func hovered(_ value: Bool = true) -> Self {
        HoveredViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Id

// MARK: ImportantForAccessibility

// MARK: ImportantForAutofill

// MARK: ImportantForContentCapture

// MARK: IsCredential

struct IsCredentialViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setIsCredential
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func keyboardNavigationCluster(_ value: Bool = true) -> Self {
        KeyboardNavigationClusterViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: LabelFor

// MARK: LayerPaint

// MARK: LayerType

// MARK: LayoutDirection

// MARK: LayoutParams

// MARK: Left

// MARK: LeftTopRightBottom

// MARK: LongClickable

struct LongClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setLongClickable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func longClickable(_ value: Bool = true) -> Self {
        LongClickableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: MinimumWidth

// MARK: MinimumHeight

// MARK: NestedScrollingEnabled

struct NestedScrollingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setNestedScrollingEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func nestedScrollingEnabled(_ value: Bool = true) -> Self {
        NestedScrollingEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: NextClusterForwardId

// MARK: NextFocusDownId

// MARK: NextFocusForwardId

// MARK: NextFocusLeftId

// MARK: NextFocusRightId

// MARK: NextFocusUpId

// MARK: OnApplyWindowInsetsListener

// MARK: OnCapturedPointerListener

// MARK: OnClickListener

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
extension View {
    @discardableResult
    public func onClick(_ handler: @escaping () async -> Void) -> Self {
        OnClickListenerViewProperty(value: .init(handler)).applyOrAppend(nil, self)
    }

    @discardableResult
    public func onClick(_ handler: @escaping (Self) async -> Void) -> Self {
        #if canImport(AndroidLooper)
        return OnClickListenerViewProperty(value: .init({ @UIThreadActor [weak self] in
            guard let self else { return }
            await handler(self)
        })).applyOrAppend(nil, self)
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

// MARK: OnReceiveContentListener

// MARK: OnScrollChangeListener

// MARK: OnSystemUiVisibilityChangeListener

// MARK: OnTouchListener

// MARK: OutlineAmbientShadowColor

// MARK: OutlineProvider

// MARK: OutlineSpotShadowColor

// MARK: OverScrollMode

// MARK: Padding

// MARK: PaddingRelative

// MARK: PendingCredentialRequest

// MARK: PivotX

// MARK: PivotY

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
    @discardableResult
    public func pressed(_ value: Bool = true) -> Self {
        PressedViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: RenderEffect

// MARK: RequestedFrameRate

// MARK: RevealOnFocusHint

struct RevealOnFocusHintViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setRevealOnFocusHint
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func revealOnFocusHint(_ value: Bool = true) -> Self {
        RevealOnFocusHintViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: Right

// MARK: Rotation

// MARK: RotationX

// MARK: RotationY

// MARK: SaveEnabled

struct SaveEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setSaveEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func saveFromParentEnabled(_ value: Bool = true) -> Self {
        SaveFromParentEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScaleX

// MARK: ScaleY

// MARK: ScreenReaderFocusable

struct ScreenReaderFocusableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScreenReaderFocusable
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func screenReaderFocusable(_ value: Bool = true) -> Self {
        ScreenReaderFocusableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollBarDefaultDelayBeforeFade

// MARK: ScrollBarFadeDuration

// MARK: ScrollBarSize

// MARK: ScrollBarStyle

// MARK: ScrollCaptureCallback

// MARK: ScrollCaptureHint

// MARK: ScrollContainer

struct ScrollContainerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollContainer
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
    @discardableResult
    public func scrollContainer(_ value: Bool = true) -> Self {
        ScrollContainerViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: ScrollIndicators

// MARK: ScrollX

// MARK: ScrollY

// MARK: ScrollbarFadingEnabled

struct ScrollbarFadingEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setScrollbarFadingEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func soundEffectsEnabled(_ value: Bool = true) -> Self {
        SoundEffectsEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: StateDescription

// MARK: StateListAnimator

// MARK: SupplementalDescription

// MARK: SystemGestureExclusionRects

// MARK: SystemUiVisibility

// MARK: Tag

// MARK: TextAlignment

// MARK: TextDirection

// MARK: TooltipText

// MARK: Top

// MARK: TouchDelegate

// MARK: TransitionAlpha

// MARK: TransitionName

// MARK: TransitionVisibility

// MARK: TranslationX

// MARK: TranslationY

// MARK: TranslationZ

// MARK: VerticalFadingEdgeEnabled

struct VerticalFadingEdgeEnabledViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setVerticalFadingEdgeEnabled
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func verticalScrollBarEnabled(_ value: Bool = true) -> Self {
        VerticalScrollBarEnabledViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: VerticalScrollbarPosition

// MARK: VerticalScrollbarThumbDrawable

// MARK: VerticalScrollbarTrackDrawable

// MARK: ViewTranslationCallback

// MARK: Visibility

// MARK: WillNotCacheDrawing

struct WillNotCacheDrawingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = .setWillNotCacheDrawing
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension View {
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
    @discardableResult
    public func willNotDraw(_ value: Bool = true) -> Self {
        WillNotDrawViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: WindowInsetsAnimationCallback

// MARK: X

// MARK: Y

// MARK: Z
