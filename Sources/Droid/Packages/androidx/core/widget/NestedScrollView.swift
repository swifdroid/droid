//
//  NestedScrollView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidXPackage.CorePackage.WidgetPackage {
    public class NestedScrollViewClass: JClassName, @unchecked Sendable {}
    
    public var NestedScrollView: NestedScrollViewClass { .init(parent: self, name: "NestedScrollView") }
}

/// NestedScrollView is just like `ScrollView`, but it supports acting as both
/// a nested scrolling parent and child on both new and old versions of Android.
/// 
/// Nested scrolling is enabled by default.
/// 
/// [Learn more](https://developer.android.com/reference/androidx/core/widget/NestedScrollView)
public final class NestedScrollView: FrameLayout {
    /// The JNI class name
    public override class var className: JClassName { .androidx.core.widget.NestedScrollView }

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }
}

// TODO: arrowScroll
// TODO: computeScroll
// TODO: dispatchKeyEvent
// TODO: dispatchNestedFling
// TODO: dispatchNestedPreFling
// TODO: dispatchNestedPreScroll
// TODO: dispatchNestedPreScroll
// TODO: dispatchNestedScroll
// TODO: executeKeyEvent
// TODO: fling
// TODO: fullScroll
// TODO: getMaxScrollAmount
// TODO: getNestedScrollAxes
// TODO: hasNestedScrollingParent
// TODO: isFillViewport
// TODO: isNestedScrollingEnabled
// TODO: isSmoothScrollingEnabled
// TODO: onInterceptTouchEvent
// TODO: onNestedFling
// TODO: onNestedPreFling
// TODO: onNestedPreScroll
// TODO: onNestedScroll
// TODO: onNestedScrollAccepted
// TODO: onStartNestedScroll
// TODO: onStopNestedScroll
// TODO: onTouchEvent
// TODO: pageScroll
// TODO: requestChildFocus
// TODO: requestChildRectangleOnScreen
// TODO: requestDisallowInterceptTouchEvent
// TODO: requestLayout
// TODO: scrollTo
// TODO: setFillViewport
// TODO: setNestedScrollingEnabled
// TODO: setOnScrollChangeListener
// TODO: setSmoothScrollingEnabled
// TODO: shouldDelayChildPressedState
// TODO: smoothScrollBy
// TODO: smoothScrollTo
// TODO: startNestedScroll
// TODO: stopNestedScroll
// TODO: computeScrollDeltaToGetChildRectOnScreen
// TODO: getBottomFadingEdgeStrength
// TODO: getTopFadingEdgeStrength
// TODO: measureChild
// TODO: measureChildWithMargins
// TODO: onLayout
// TODO: onMeasure
// TODO: onOverScrolled
// TODO: onRequestFocusInDescendants
// TODO: onRestoreInstanceState
// TODO: onSaveInstanceState
// TODO: onScrollChanged
// TODO: onSizeChanged
