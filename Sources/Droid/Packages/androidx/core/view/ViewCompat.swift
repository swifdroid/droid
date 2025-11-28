//
//  ViewCompat.swift
//  Droid
//
//  Created by Mihael Isaev on 20.11.2025.
//

/// Helper for accessing features in View.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/core/view/ViewCompat)
@MainActor
public final class ViewCompat: JObjectable, @unchecked Sendable {
    /// The JNI class name
    nonisolated public static let className: JClassName = "androidx/core/view/ViewCompat"

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension ViewCompat {
    public enum AccessibilityLiveRegion: Int32 {
        /// Live region mode specifying that accessibility services
        /// should interrupt ongoing speech to immediately announce changes to this view.
        case assertive = 2
        /// Live region mode specifying that accessibility services
        // should not automatically announce changes to this view.
        // This is the default live region mode for most views.
        case none = 0
        /// Live region mode specifying that accessibility services should announce changes to this view.
        case polite = 1
    }

    public enum ImportantForContentCapture: Int32 {
        /// Automatically determine whether a view is important for content capture.
        case auto = 0
        /// The view is not important for content capture, but its children (if any) will be traversed.
        case no = 2
        /// The view is not important for content capture, and its children (if any) will not be traversed.
        case noExcludeDescendants = 8
        /// The view is important for content capture, and its children (if any) will be traversed.
        case yes = 1
        /// The view is important for content capture, but its children (if any) will not be traversed.
        case yesExcludeDescendants = 4
    }

    public enum ScrollAxis: Int32 {
        /// Indicates scrolling along the horizontal axis.
        case horizontal = 1
        /// Indicates no axis of view scrolling.
        case none = 0
        /// Indicates scrolling along the vertical axis.
        case vertical = 2
    }

    public enum ScrollIndicator: Int32 {
        /// Scroll indicator direction for the bottom edge of the view.
        case bottom = 2
        /// Scroll indicator direction for the ending edge of the view.
        case end = 32
        /// Scroll indicator direction for the left edge of the view.
        case left = 4
        /// Scroll indicator direction for the right edge of the view.
        case right = 8
        /// Scroll indicator direction for the starting edge of the view.
        case start = 16
        /// Scroll indicator direction for the top edge of the view.
        case top = 1
    }

    public enum InputType: Int32 {
        /// Indicates that the input type for the gesture is caused by something
        // which is not a user touching a screen. This is usually from a fling which is settling.
        case nonTouch = 1
        /// Indicates that the input type for the gesture is from a user touching the screen.
        case touch = 0
    }

    // TODO: addAccessibilityAction
    // TODO: addKeyboardNavigationClusters
    // TODO: addOnUnhandledKeyEventListener
    
    /// Convenience method to add overlay to overlayHost's overlay and assign the disjointParent in the overlay hierarchy.
    public static func addOverlayView(_ overlayHost: View, _ overlayView: View) {
        guard
            let overlayHostInstance = overlayHost.instance,
            let overlayViewInstance = overlayView.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "addOverlayView",
            args: overlayHostInstance.signed(as: ViewGroup.className), overlayViewInstance.signed(as: View.className)
        )
    }

    /// Cancel the drag and drop operation.
    public static func cancelDragAndDrop(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "cancelDragAndDrop", args: instance.signed(as: View.className))
    }

    /// Compute insets that should be consumed by this view and the ones that should propagate to those under it.
    public static func computeSystemWindowInsets(
        _ view: View,
        _ insets: WindowInsetsCompat,
        _ outLocalInsets: Rect
    ) -> WindowInsetsCompat {
        guard
            let viewInstance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let returningClazz = JClass.load(WindowInsetsCompat.className),
            let resultInstance = clazz.staticObjectMethod(
                name: "computeSystemWindowInsets",
                args: viewInstance.signed(as: View.className),
                insets.signed(as: WindowInsetsCompat.className),
                outLocalInsets.signed(as: Rect.className),
                returningClass: returningClazz
            )
        else { return insets }
        return WindowInsetsCompat(resultInstance)
    }

    /// Request to apply the given window insets to this view or another view in its subtree.
    ///
    /// This method should be called by clients wishing to apply insets corresponding to areas
    /// obscured by window decorations or overlays. This can include the status and navigation bars,
    /// action bars, input methods and more. New inset categories may be added in the future.
    /// The method returns the insets provided minus any that were applied by this view or its children.
    public static func dispatchApplyWindowInsets(_ view: View, _ insets: WindowInsetsCompat) -> WindowInsetsCompat {
        guard
            let viewInstance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let returningClazz = JClass.load(WindowInsetsCompat.className),
            let resultInstance = clazz.staticObjectMethod(
                name: "dispatchApplyWindowInsets",
                args: viewInstance.signed(as: View.className),
                insets.signed(as: WindowInsetsCompat.className),
                returningClass: returningClazz
            )
        else { return insets }
        return WindowInsetsCompat(resultInstance)
    }

    /// Notify a view that its temporary detach has ended; the view is now reattached.
    public static func dispatchFinishTemporaryDetach(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "dispatchFinishTemporaryDetach", args: instance.signed(as: View.className))
    }

    /// Dispatch a fling to a nested scrolling parent.
    ///
    /// This method should be used to indicate that a nested scrolling child
    /// has detected suitable conditions for a fling. Generally this means that
    /// a touch scroll has ended with a `velocity` in the direction of scrolling that
    /// meets or exceeds the `minimum fling velocity` along a scrollable axis.
    ///
    /// If a nested scrolling child view would normally fling but it is at the edge
    /// of its own content, it can use this method to delegate the fling to its nested
    /// scrolling parent instead. The parent may optionally consume the fling or observe a child fling.
    public static func dispatchNestedFling(
        _ view: View,
        _ velocityX: Float,
        _ velocityY: Float,
        _ consumed: Bool
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedFling",
            args: instance.signed(as: View.className),
            velocityX,
            velocityY,
            consumed
        ) ?? false
    }

    /// Dispatch a fling to a nested scrolling parent before it is processed by this view.
    ///
    /// Nested pre-fling events are to nested fling events what touch intercept is to touch and what nested pre-scroll is to nested scroll. dispatchNestedPreFling offsets an opportunity for the parent view in a nested fling to fully consume the fling before the child view consumes it. If this method returns true, a nested parent view consumed the fling and this view should not scroll as a result.
    ///
    /// For a better user experience, only one view in a nested scrolling chain should consume the fling at a time. If a parent view consumed the fling this method will return false. Custom view implementations should account for this in two ways:
    ///
    /// If a custom view is paged and needs to settle to a fixed page-point, do not call dispatchNestedPreFling; consume the fling and settle to a valid position regardless.
    /// If a nested parent does consume the fling, this view should not scroll at all, even to settle back to a valid idle position.
    /// Views should also not offer fling velocities to nested parent views along an axis where scrolling is not currently supported; a ScrollView should not offer a horizontal fling velocity to its parents since scrolling along that axis is not permitted and carrying velocity along that motion does not make sense.
    public static func dispatchNestedPreFling(
        _ view: View,
        _ velocityX: Float,
        _ velocityY: Float
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedPreFling",
            args: instance.signed(as: View.className),
            velocityX,
            velocityY
        ) ?? false
    }

    /// Dispatch one step of a nested scroll in progress before this view consumes any portion of it.
    ///
    /// This version of the method just calls `dispatchNestedPreScroll` using the touch input type.
    public static func dispatchNestedPreScroll(
        _ view: View,
        _ dx: Int32,
        _ dy: Int32,
        _ consumed: [Int32]?,
        _ offsetInWindow: [Int32]?
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedPreScroll",
            args: instance.signed(as: View.className),
            dx,
            dy,
            consumed,
            offsetInWindow
        ) ?? false
    }

    /// Dispatch one step of a nested scroll in progress before this view consumes any portion of it.
    ///
    /// Nested pre-scroll events are to nested scroll events what touch intercept is to touch.
    /// `dispatchNestedPreScroll` offers an opportunity for the parent view
    /// in a nested scrolling operation to consume some or all of the scroll operation
    /// before the child view consumes it.
    public static func dispatchNestedPreScroll(
        _ view: View,
        _ dx: Int32,
        _ dy: Int32,
        _ consumed: [Int32]?,
        _ offsetInWindow: [Int32]?,
        _ type: InputType
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedPreScroll",
            args: instance.signed(as: View.className),
            dx,
            dy,
            consumed,
            offsetInWindow,
            type.rawValue
        ) ?? false
    }

    /// Dispatch one step of a nested scroll in progress.
    ///
    /// This version of the method just calls `dispatchNestedScroll` using the touch input type.
    public static func dispatchNestedScroll(
        _ view: View,
        _ dxConsumed: Int32,
        _ dyConsumed: Int32,
        _ dxUnconsumed: Int32,
        _ dyUnconsumed: Int32,
        _ offsetInWindow: [Int32]?
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedScroll",
            args: instance.signed(as: View.className),
            dxConsumed,
            dyConsumed,
            dxUnconsumed,
            dyUnconsumed,
            offsetInWindow
        ) ?? false
    }

    /// Dispatch one step of a nested scroll in progress.
    ///
    /// Implementations of views that support nested scrolling
    /// should call this to report info about a scroll in progress
    /// to the current nested scrolling parent. If a nested scroll is not
    /// currently in progress or nested scrolling is not enabled
    /// for this view this method does nothing.
    ///
    /// Compatible View implementations should also call `dispatchNestedPreScroll`
    /// before consuming a component of the scroll event themselves.
    public static func dispatchNestedScroll(
        _ view: View,
        _ dxConsumed: Int32,
        _ dyConsumed: Int32,
        _ dxUnconsumed: Int32,
        _ dyUnconsumed: Int32,
        _ offsetInWindow: [Int32]?,
        _ type: InputType
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedScroll",
            args: instance.signed(as: View.className),
            dxConsumed,
            dyConsumed,
            dxUnconsumed,
            dyUnconsumed,
            offsetInWindow,
            type.rawValue
        ) ?? false
    }

    /// Dispatch one step of a nested scroll in progress.
    ///
    /// Implementations of views that support nested scrolling should call this
    /// to report info about a scroll in progress to the current nested scrolling parent.
    /// If a nested scroll is not currently in progress or nested scrolling
    /// is not enabled for this view this method does nothing.
    ///
    /// Compatible View implementations should also call `dispatchNestedPreScroll`
    /// before consuming a component of the scroll event themselves.
    ///
    /// A non-null consumed int array of length 2 may be passed in to enable nested scrolling
    /// parents to report how much of the scroll distance was consumed.
    /// The original caller (where the input event was received to start the scroll)
    /// should initialize the values to be 0, in order to tell how much was actually
    /// consumed up the hierarchy of scrolling parents.
    public static func dispatchNestedScroll(
        _ view: View,
        _ dxConsumed: Int32,
        _ dyConsumed: Int32,
        _ dxUnconsumed: Int32,
        _ dyUnconsumed: Int32,
        _ offsetInWindow: [Int32]?,
        _ type: InputType,
        _ consumed: [Int32]
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "dispatchNestedScroll",
            args: instance.signed(as: View.className),
            dxConsumed,
            dyConsumed,
            dxUnconsumed,
            dyUnconsumed,
            offsetInWindow,
            type.rawValue,
            consumed
        ) ?? false
    }

    /// Notify a view that it is being temporarily detached.
    public static func dispatchStartTemporaryDetach(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "dispatchStartTemporaryDetach", args: instance.signed(as: View.className))
    }

    /// Allow accessibility services to find and activate clickable spans in the application.
    ///
    /// `android.text.style.ClickableSpan` is automatically supported from API 26.
    /// For compatibility back to API 19, this should be enabled.
    ///
    /// `android.text.style.URLSpan`, a subclass of `ClickableSpans`,
    /// is automatically supported and does not need this enabled.
    ///
    /// Do not put `ClickableSpans` in `setContentDescription` or `setStateDescription`.
    /// These links are only visible to accessibility services in getText,
    /// which should be modifiable using helper methods on UI elements.
    /// For example, use setText to modify the text of TextViews.
    public static func enableAccessibleClickableSpanSupport(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "enableAccessibleClickableSpanSupport", args: instance.signed(as: View.className))
    }

    // TODO: getAccessibilityDelegate
    // TODO: getAccessibilityNodeProvider
    // TODO: getAccessibilityPaneTitle
    // TODO: getAutofillId
    // TODO: getBackgroundTintList
    // TODO: getBackgroundTintMode
    // TODO: getContentCaptureSession

    /// Returns the base elevation of this view.
    public static func elevation(_ view: View, _ unit: DimensionUnit = .dp) -> Float {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return 0.0 }
        let pixels = clazz.staticFloatMethod(name: "getElevation", args: instance.signed(as: View.className)) ?? 0.0
        return unit.fromPixels(pixels)
    }

    /// Gets the mode for determining whether this view is important for autofill.
    public static func importantForAutofill(_ view: View) -> Int32 {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return 0 }
        let value = clazz.staticIntMethod(name: "getImportantForAutofill", args: instance.signed(as: View.className)) ?? 0
        return value
    }

    /// Gets the mode for determining whether this view is important for content capture.
    public static func importantForContentCapture(_ view: View) -> ImportantForContentCapture {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return .auto }
        let value = clazz.staticIntMethod(name: "getImportantForContentCapture", args: instance.signed(as: View.className)) ?? 0
        return ImportantForContentCapture(rawValue: value) ?? .auto
    }

    /// Gets the ID of the next keyboard navigation cluster root.
    public static func nextClusterForwardId(_ view: View) -> Int32? {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return nil }
        let value = clazz.staticIntMethod(name: "getNextClusterForwardId", args: instance.signed(as: View.className))
        return value
    }

    // TODO: getOnReceiveContentMimeTypes

    /// Provide original `WindowInsetsCompat` that are dispatched to the view hierarchy.
    /// The insets are only available if the view is attached.
    public static func getRootWindowInsets(_ view: View) -> WindowInsetsCompat? {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let returningClazz = JClass.load(WindowInsetsCompat.className),
            let resultInstance = clazz.staticObjectMethod(
                name: "getRootWindowInsets",
                args: instance.signed(as: View.className),
                returningClass: returningClazz
            )
        else { return nil }
        return WindowInsetsCompat(resultInstance)
    }

    /// Returns a bitmask representing the enabled scroll indicators.
    ///
    /// For example, if the top and left scroll indicators are enabled and all
    /// other indicators are disabled, the return value
    /// will be `ViewCompat.SCROLL_INDICATOR_TOP | ViewCompat.SCROLL_INDICATOR_LEFT`.
    ///
    /// To check whether the bottom scroll indicator is enabled,
    /// use the value of `(ViewCompat.getScrollIndicators(view) & ViewCompat.SCROLL_INDICATOR_BOTTOM) != 0`.
    public static func getScrollIndicators(_ view: View) -> Int32 {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return 0 }
        let value = clazz.staticIntMethod(name: "getScrollIndicators", args: instance.signed(as: View.className)) ?? 0
        return value
    }

    // TODO: getStateDescription
    // TODO: getSystemGestureExclusionRects
    // TODO: getTransitionName

    /// The depth location of this view relative to its `elevation`.
    public static func getTranslationZ(_ view: View, _ unit: DimensionUnit = .dp) -> Float {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return 0.0 }
        let pixels = clazz.staticFloatMethod(name: "getTranslationZ", args: instance.signed(as: View.className)) ?? 0.0
        return unit.fromPixels(pixels)
    }

    /// The visual z position of this view.
    /// This is equivalent to the `translationZ` property plus the current `elevation` property.
    public static func getZ(_ view: View, _ unit: DimensionUnit = .dp) -> Float {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return 0.0 }
        let pixels = clazz.staticFloatMethod(name: "getZ", args: instance.signed(as: View.className)) ?? 0.0
        return unit.fromPixels(pixels)
    }

    /// Checks whether provided View has an accessibility delegate attached to it.
    public static func hasAccessibilityDelegate(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "hasAccessibilityDelegate", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns `true` if this view is focusable or if it contains a reachable View
    /// for which `hasExplicitFocusable` returns `true`. A "reachable `hasExplicitFocusable()`"
    /// is a view whose parents do not block descendants focus.
    /// Only `VISIBLE` views for which getFocusable would return `FOCUSABLE` are considered focusable.
    ///
    /// This method preserves the pre-O behavior of hasFocusable in that only views explicitly set focusable
    /// will cause this method to return `true`. A view set to `FOCUSABLE_AUTO` that resolves to focusable will not.
    public static func hasExplicitFocusable(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "hasExplicitFocusable", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns true if this view has a nested scrolling parent.
    public static func hasNestedScrollingParent(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "hasNestedScrollingParent",
            args: instance.signed(as: View.className)
        ) ?? false
    }
    
    /// Returns true if this view has a nested scrolling parent.
    ///
    /// The presence of a nested scrolling parent indicates that this view has initiated
    /// a nested scroll and it was accepted by an ancestor view further up the view hierarchy.
    public static func hasNestedScrollingParent(_ view: View, _ type: InputType) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "hasNestedScrollingParent",
            args: instance.signed(as: View.className),
            type.rawValue
        ) ?? false
    }

    /// Gets whether this view is a heading for accessibility purposes.
    public static func isAccessibilityHeading(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isAccessibilityHeading", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns whether view should receive focus when the focus is restored
    /// for the view hierarchy containing it. Returns false on API <26.
    ///
    /// Focus gets restored for a view hierarchy when the root of the hierarchy
    /// gets added to a window or serves as a target of cluster navigation.
    public static func isFocusedByDefault(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isFocusedByDefault", args: instance.signed(as: View.className)) ?? false
    }

    /// Computes whether this view should be exposed for accessibility. In general, views that are interactive or provide information are exposed while views that serve only as containers are hidden.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/core/view/ViewCompat#isImportantForAccessibility(android.view.View))
    public static func isImportantForAccessibility(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isImportantForAccessibility", args: instance.signed(as: View.className)) ?? false
    }

    /// Hints the Android System whether the `android.app.assist.AssistStructure.ViewNode`
    /// associated with this view is considered important for autofill purposes.
    ///
    /// [Learn more](https://developer.android.com/reference/androidx/core/view/ViewCompat#isImportantForAutofill(android.view.View))
    public static func isImportantForAutofill(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isImportantForAutofill", args: instance.signed(as: View.className)) ?? false
    }

    /// Hints the Android System whether this view is considered important for content capture,
    /// based on the value explicitly set by `setImportantForContentCapture`
    /// and heuristics when it's `IMPORTANT_FOR_CONTENT_CAPTURE_AUTO`.
    public static func isImportantForContentCapture(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isImportantForContentCapture", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns whether view is a root of a keyboard navigation cluster.
    /// Always returns false on API <26.
    public static func isKeyboardNavigationClusterRoot(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isKeyboardNavigationClusterRoot", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns true if nested scrolling is enabled for this view.
    ///
    /// If nested scrolling is enabled and this View class implementation supports it,
    /// this view will act as a nested scrolling child view when applicable,
    /// forwarding data about the scroll operation in progress
    /// to a compatible and cooperating nested scrolling parent.
    public static func isNestedScrollingEnabled(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isNestedScrollingEnabled", args: instance.signed(as: View.className)) ?? false
    }

    /// Returns whether the view should be treated as a focusable unit by screen reader accessibility tools.
    public static func isScreenReaderFocusable(_ view: View) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(name: "isScreenReaderFocusable", args: instance.signed(as: View.className)) ?? false
    }

    /// Find the nearest keyboard navigation cluster in the specified direction.
    /// This does not actually give focus to that cluster.
    public static func keyboardNavigationClusterSearch(
        _ view: View,
        _ currentCluster: View?,
        _ direction: Int32
    ) {
        guard
            let viewInstance = view.instance,
            let currentClusterInstance = currentCluster?.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "keyboardNavigationClusterSearch",
            args: viewInstance.signed(as: View.className),
            currentClusterInstance.signed(as: View.className),
            direction
        )
    }

    /// Offset this view's horizontal location by the specified amount of pixels.
    public static func offsetLeftAndRight(_ view: View, _ offset: Int, _ unit: DimensionUnit = .dp) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        let pixels = unit.toPixels(Int32(offset))
        clazz.staticVoidMethod(
            name: "offsetLeftAndRight",
            args: instance.signed(as: View.className), pixels
        )
    }

    /// Offset this view's vertical location by the specified number of pixels.
    public static func offsetTopAndBottom(_ view: View, _ offset: Int, _ unit: DimensionUnit = .dp) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        let pixels = unit.toPixels(Int32(offset))
        clazz.staticVoidMethod(
            name: "offsetTopAndBottom",
            args: instance.signed(as: View.className), pixels
        )
    }

    /// Called when the view should apply WindowInsetsCompat according to its internal policy.
    ///
    /// Clients may supply an OnApplyWindowInsetsListener to a view.
    /// If one is set it will be called during dispatch instead of this method.
    /// The listener may optionally call this method from its own implementation
    /// if it wishes to apply the view's default insets policy in addition to its own.
    public static func onApplyWindowInsets(
        _ view: View,
        _ insets: WindowInsetsCompat
    ) -> WindowInsetsCompat {
        guard
            let viewInstance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let returningClazz = JClass.load(WindowInsetsCompat.className),
            let resultInstance = clazz.staticObjectMethod(
                name: "onApplyWindowInsets",
                args: viewInstance.signed(as: View.className),
                insets.signed(as: WindowInsetsCompat.className),
                returningClass: returningClazz
            )
        else { return insets }
        return WindowInsetsCompat(resultInstance)
    }

    /// Perform a haptic feedback to the user for the view.
    ///
    /// The framework will provide haptic feedback for some built in actions,
    /// such as long presses, but you may wish to provide feedback for your own widget.
    ///
    /// The feedback will only be performed if `isHapticFeedbackEnabled` is true.
    /// Note: Check compatibility support for each feedback constant described at `HapticFeedbackConstantsCompat`.
    public static func performHapticFeedback(
        _ view: View,
        _ feedbackConstant: HapticFeedbackConstant
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "performHapticFeedback",
            args: instance.signed(as: View.className),
            feedbackConstant.value
        ) ?? false
    }

    /// Perform a haptic feedback to the user for the view.
    ///
    /// The framework will provide haptic feedback for some built in actions,
    /// such as long presses, but you may wish to provide feedback for your own widget.
    ///
    /// The feedback will only be performed if `isHapticFeedbackEnabled` is true.
    /// Note: Check compatibility support for each feedback constant described at `HapticFeedbackConstantsCompat`.
    public static func performHapticFeedback(
        _ view: View,
        _ feedbackConstant: HapticFeedbackConstant,
        _ flags: Int32
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "performHapticFeedback",
            args: instance.signed(as: View.className),
            feedbackConstant.value,
            flags
        ) ?? false
    }

    // TODO: performReceiveContent

    /// Removes an accessibility action that can be performed on a node
    /// associated with a view. If the action was not already added
    /// to the view, calling this method has no effect.
    public static func removeAccessibilityAction(
        _ view: View,
        _ actionId: Int32
    ) -> Bool {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return false }
        return clazz.staticBoolMethod(
            name: "removeAccessibilityAction",
            args: instance.signed(as: View.className),
            actionId
        ) ?? false
    }

    // TODO: removeOnUnhandledKeyEventListener
    // TODO: replaceAccessibilityAction

    /// Ask that a new dispatch of `View.onApplyWindowInsets(WindowInsets)` be performed.
    /// This falls back to `View.requestFitSystemWindows()` where available.
    public static func requestApplyInsets(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "requestApplyInsets", args: instance.signed(as: View.className))
    }

    /// Gives focus to the default-focus view in the view hierarchy rooted at view.
    /// If the default-focus view cannot be found or if API <26, this falls back to calling `requestFocus`.
    public static func restoreDefaultFocus(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(name: "restoreDefaultFocus", args: instance.signed(as: View.className))
    }

    // TODO: saveAttributeDataForStyleable
    // TODO: setAccessibilityDelegate

    /// Set if view is a heading for a section of content for accessibility purposes.
    public static func accessibilityHeading(_ view: View, _ isHeading: Bool) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setAccessibilityHeading",
            args: instance.signed(as: View.className),
            isHeading
        )
    }

    // TODO: setAccessibilityPaneTitle
    // TODO: setAutofillHints
    // TODO: setAutofillId
    // TODO: setBackgroundTintList
    // TODO: setBackgroundTintMode
    // TODO: setContentCaptureSession

    public static func elevation(
        _ view: View,
        _ elevation: Float,
        _ unit: DimensionUnit = .dp
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        let pixels = unit.toPixels(elevation)
        clazz.staticVoidMethod(
            name: "setElevation",
            args: instance.signed(as: View.className),
            pixels
        )
    }

    /// Sets whether view should receive focus when the focus
    /// is restored for the view hierarchy containing it.
    ///
    /// Focus gets restored for a view hierarchy when the root
    /// of the hierarchy gets added to a window or serves as a target of cluster navigation.
    ///
    /// Does nothing on API <26.
    public static func focusedByDefault(_ view: View, _ focusedByDefault: Bool) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setFocusedByDefault",
            args: instance.signed(as: View.className),
            focusedByDefault
        )
    }

    // TODO: setImportantForAutofill
    // TODO: setImportantForContentCapture

    /// Enable or disable nested scrolling for this view.
    ///
    /// If this property is set to `true` the view will be permitted to initiate
    /// nested scrolling operations with a compatible parent view in the current hierarchy.
    /// If this view does not implement nested scrolling this will have no effect.
    /// Disabling nested scrolling while a nested scroll is in progress has the effect of stopping the nested scroll.
    public static func nestedScrollingEnabled(
        _ view: View,
        _ enabled: Bool
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setNestedScrollingEnabled",
            args: instance.signed(as: View.className),
            enabled
        )
    }

    /// Sets the ID of the next keyboard navigation cluster root view.
    /// Does nothing if view is not a keyboard navigation cluster or if API <26.
    public static func nextClusterForwardId(
        _ view: View,
        _ nextClusterForwardId: Int32
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setNextClusterForwardId",
            args: instance.signed(as: View.className),
            nextClusterForwardId
        )
    }

    /// Set an `OnApplyWindowInsetsListener` to take over the policy
    /// for applying window insets to this view.
    /// This will only take effect on devices with API 21 or above.
    public static func onApplyWindowInsetsListener(
        _ view: View,
        _ handler: @escaping View.ApplyWindowInsetsCompatListenerEventHandler
    ) {
        #if os(Android)
        let listener = NativeOnApplyWindowInsetsCompatListener(view.id, viewId: view.id).setHandler(view) { @MainActor in
            return handler($0)
        }
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let listenerInstance = listener.instance
        else { return }
        clazz.staticVoidMethod(
            name: "setOnApplyWindowInsetsListener",
            args: instance.signed(as: View.className),
            listenerInstance.object.signed(as: "androidx/core/view/OnApplyWindowInsetsListener")
        )
        #endif
    }

    #if os(Android)
    /// Set an `OnApplyWindowInsetsListener` to take over the policy
    /// for applying window insets to this view.
    /// This will only take effect on devices with API 21 or above.
    static func onApplyWindowInsetsListener(
        _ view: View,
        _ listener: NativeOnApplyWindowInsetsCompatListener
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className),
            let listenerInstance = listener.instance
        else { return }
        clazz.staticVoidMethod(
            name: "setOnApplyWindowInsetsListener",
            args: instance.signed(as: View.className),
            listenerInstance.object.signed(as: "androidx/core/view/OnApplyWindowInsetsListener")
        )
    }
    #endif

    // TODO: setOnReceiveContentListener
    // TODO: setPointerIcon

    /// Sets whether this View should be a focusable element for screen readers
    /// and include non-focusable Views from its subtree when providing feedback.
    public static func screenReaderFocusable(
        _ view: View,
        _ screenReaderFocusable: Bool
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "setScreenReaderFocusable",
            args: instance.signed(as: View.className),
            screenReaderFocusable
        )
    }

    // TODO: setScrollIndicators
    // TODO: setStateDescription
    // TODO: setSystemGestureExclusionRects
    // TODO: setTooltipText
    // TODO: setTransitionName

    /// Sets the depth location of this view relative to its elevation.
    public static func translationZ(
        _ view: View,
        _ translationZ: Float,
        _ unit: DimensionUnit = .dp
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        let pixels = unit.toPixels(translationZ)
        clazz.staticVoidMethod(
            name: "setTranslationZ",
            args: instance.signed(as: View.className),
            pixels
        )
    }

    // TODO: setWindowInsetsAnimationCallback

    /// Sets the visual z position of this view, in pixels.
    /// This is equivalent to setting the translationZ property to be the difference
    /// between the x value passed in and the current elevation property.
    public static func z(
        _ view: View,
        _ z: Float,
        _ unit: DimensionUnit = .dp
    ) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        let pixels = unit.toPixels(z)
        clazz.staticVoidMethod(
            name: "setZ",
            args: instance.signed(as: View.className),
            pixels
        )
    }

    // TODO: startDragAndDrop
    // TODO: startNestedScroll
    // TODO: startNestedScroll

    /// Stop a nested scroll in progress.
    public static func stopNestedScroll(_ view: View) {
        guard
            let instance = view.instance,
            let clazz = JClass.load(ViewCompat.className)
        else { return }
        clazz.staticVoidMethod(
            name: "stopNestedScroll",
            args: instance.signed(as: View.className)
        )
    }

    // TODO: transformMatrixToGlobal
    // TODO: updateDragShadow
}

public struct HapticFeedbackConstant: ExpressibleByIntegerLiteral, Sendable {
    public let value: Int32

    public init(integerLiteral value: Int32) {
        self.value = value
    }

    /// The user has pressed either an hour or minute tick of a Clock.
    ///
    /// API <21: No-op
    public static let clockTick: Self = 4

    /// A haptic effect to signal the confirmation or successful completion of a user interaction.
    ///
    /// API <30: Same feedback as `VIRTUAL_KEY`
    public static let confirm: Self = 16

    /// The user has performed a context click on an object.
    ///
    /// API <23: Same feedback as `CLOCK_TICK`
    /// API <21: No-op
    public static let contextClick: Self = 6

    /// The user has started a drag-and-drop gesture.
    ///
    /// API <34: Same feedback as `LONG_PRESS`
    public static let dragStart: Self = 25

    /// Flag for performHapticFeedback: Ignore the setting in the view for whether to perform haptic feedback, do it always.
    public static let flagIgnoreViewSetting: Self = 1

    /// The user has finished a gesture (e.g. on the soft keyboard).
    ///
    /// API <30: Same feedback as `CONTEXT_CLICK`
    /// API <21: No-op
    public static let gestureEnd: Self = 13

    /// The user has started a gesture (e.g. on the soft keyboard).
    ///
    /// API <30: Same feedback as `VIRTUAL_KEY`
    public static let gestureStart: Self = 12

    /// The user is executing a swipe/drag-style gesture, such as pull-to-refresh, where the gesture action is “eligible” at a certain threshold of movement, and can be cancelled by moving back past the threshold.
    ///
    /// API <34: Same feedback as `CONTEXT_CLICK`
    /// API <21: No-op
    public static let gestureThresholdActivate: Self = 23

    /// The user is executing a swipe/drag-style gesture, such as pull-to-refresh, where the gesture action is “eligible” at a certain threshold of movement, and can be cancelled by moving back past the threshold.
    ///
    /// API <34: Same feedback as `CONTEXT_CLICK`
    /// API <21: No-op
    public static let gestureThresholdDeactivate: Self = 24

    /// The user has pressed a virtual or software keyboard key.
    ///
    /// API <27: Same feedback as `KEYBOARD_TAP`
    public static let keyboardPress: Self = 3

    /// The user has released a virtual keyboard key.
    ///
    /// API <27: No-op
    public static let keyboardRelease: Self = 7

    /// The user has pressed a soft keyboard key.
    public static let keyboardTap: Self = 3

    /// The user has performed a long press on an object that is resulting in an action being performed.
    public static let longPress: Self = 0

    /// No haptic feedback should be performed.
    ///
    /// API <34: Same behavior, immediately returns false
    public static let noHaptics: Self = -1

    /// A haptic effect to signal the rejection or failure of a user interaction.
    ///
    /// API <30: Same feedback as `LONG_PRESS`
    public static let reject: Self = 17

    /// The user is switching between a series of many potential choices, for example minutes on a clock face, or individual percentages.
    ///
    /// API <34: Same feedback as `CLOCK_TICK`
    /// API <21: No-op
    public static let segmentFrequentTick: Self = 27

    /// The user is switching between a series of potential choices, for example items in a list or discrete points on a slider.
    ///
    /// API <34: Same feedback as `CONTEXT_CLICK`
    /// API <21: No-op
    public static let segmentTick: Self = 26

    /// The user has performed a selection/insertion handle move on text field.
    ///
    /// API <27: No-op
    public static let textHandleMove: Self = 9

    /// The user has toggled a switch or button into the off position.
    ///
    /// API <34: Same feedback as `CLOCK_TICK`
    /// API <21: No-op
    public static let toggleOff: Self = 22

    /// The user has toggled a switch or button into the on position.
    ///
    /// API <34: Same feedback as CLOCK_TICK
    /// API <21: No-op
    public static let toggleOn: Self = 21

    /// The user has pressed on a virtual on-screen key.
    public static let virtualKey: Self = 1

    /// The user has released a virtual key.
    ///
    /// API <27: No-op
    public static let virtualKeyRelease: Self = 8
}