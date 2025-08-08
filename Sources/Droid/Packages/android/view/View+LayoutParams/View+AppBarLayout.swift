// // MARK: AppBarLayout - Layout Params
// extension View {
//     // MARK: Scroll Flags

//     /// Sets the scroll behavior flags for the view in an AppBarLayout.
//     ///
//     /// Defines how the view should scroll in relation to sibling views.
//     ///
//     /// - Parameters:
//     ///    - value: Combination of scroll flags (SCROLL_FLAG_SCROLL, 
//     ///             SCROLL_FLAG_EXIT_UNTIL_COLLAPSED, etc.)
//     ///
//     /// Supported layouts:
//     /// - AppBarLayout: Exclusive to AppBarLayout children
//     @discardableResult
//     public func scrollFlags(_ value: String) -> Self { // TODO: ScrollFlag (should be combined as bitmask)
//         if let _ = instance {
//             // TODO:
//         } else {
//             _layoutParamsToApply.append(ScrollFlagsLayoutParam()) // TODO: ScrollFlag (should be combined as bitmask)
//         }
//         return self
//     }

//     // MARK: Collapse

//     /// Sets the scroll effect behavior for the view in an AppBarLayout.
//     ///
//     /// Controls how the view responds to scrolling gestures and collapsing.
//     ///
//     /// - Parameters:
//     ///    - value: Scroll effect type (ChildScrollEffect)
//     ///
//     /// Supported layouts:
//     /// - AppBarLayout: Exclusive to AppBarLayout children
//     @discardableResult
//     public func scrollEffect(_ value: String) -> Self { // TODO: AppBarLayout.ChildScrollEffect
//         if let _ = instance {
//             // TODO:
//         } else {
//             _layoutParamsToApply.append(ScrollEffectLayoutParam()) // TODO: AppBarLayout.ChildScrollEffect
//         }
//         return self
//     }

//     /// Enables or disables the lift-on-scroll effect for the view.
//     ///
//     /// When enabled, the view will elevate when scrolling content.
//     ///
//     /// - Parameters:
//     ///    - value: Boolean to enable/disable the effect
//     ///
//     /// Supported layouts:
//     /// - AppBarLayout: Exclusive to AppBarLayout children
//     @discardableResult
//     public func liftOnScroll(_ value: Bool) -> Self {
//         if let _ = instance {
//             // TODO:
//         } else {
//             _layoutParamsToApply.append(LiftOnScrollLayoutParam(value: value))
//         }
//         return self
//     }

//     // MARK: Minimum/Maximum Height

//     /// Sets the minimum height constraint for the view.
//     ///
//     /// The view will never be rendered smaller than this height value.
//     ///
//     /// - Parameters:
//     ///    - value: Height in density-independent pixels
//     ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
//     ///
//     /// Supported layouts:
//     /// - AbsoluteLayout: Uses absolute pixel values
//     /// - ConstraintLayout: Works with constraint-based layout system
//     /// - FlexboxLayout: Applied as minimum cross-size in flex container
//     /// - FrameLayout: Enforces minimum height for child views
//     /// - LinearLayout: Respects minimum height in both orientations
//     /// - RelativeLayout: Applies minimum height to positioned views
//     /// - TableLayout: Affects cell minimum height
//     /// - ViewGroup: Base implementation for all layouts
//     @discardableResult
//     public func minHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
//         if let _ = instance {
//             // TODO:
//         } else {
//             _layoutParamsToApply.append(MinHeightLayoutParam(value: (value, unit)))
//         }
//         return self
//     }

//     /// Sets the maximum height constraint for the view.
//     ///
//     /// The view will never be rendered larger than this height value.
//     ///
//     /// - Parameters:
//     ///    - value: Height in density-independent pixels
//     ///    - unit: The measurement unit: px, dp, sp, pt, inch, mm (default: .dp)
//     ///
//     /// Supported layouts:
//     /// - AbsoluteLayout: Uses absolute pixel values
//     /// - ConstraintLayout: Works with constraint-based layout system
//     /// - FlexboxLayout: Applied as maximum cross-size in flex container
//     /// - FrameLayout: Enforces maximum height for child views
//     /// - LinearLayout: Respects maximum height in both orientations
//     /// - RelativeLayout: Applies maximum height to positioned views
//     /// - TableLayout: Affects cell maximum height
//     /// - ViewGroup: Base implementation for all layouts
//     @discardableResult
//     public func maxHeight(_ value: Int, _ unit: DimensionUnit = .dp) -> Self {
//         if let _ = instance {
//             // TODO:
//         } else {
//             _layoutParamsToApply.append(MaxHeightLayoutParam(value: (value, unit)))
//         }
//         return self
//     }
// }