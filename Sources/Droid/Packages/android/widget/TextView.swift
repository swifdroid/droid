//
//  TextView.swift
//  Droid
//
//  Created by Mihael Isaev on 15.01.2022.
//

#if os(Android)
import Android
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#endif

extension AndroidPackage.WidgetPackage {
    public class TextViewClass: JClassName, @unchecked Sendable {}
    public var TextView: TextViewClass { .init(parent: self, name: "TextView") }
}

/// A user interface element that displays text to the user.
///
/// [Learn more](https://developer.android.com/reference/android/widget/TextView)
open class TextView: View, @unchecked Sendable {
    /// The JNI class name
    open override class var className: JClassName { .android.widget.TextView }

    var textState: State<String>?

    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public init (id: Int32? = nil, _ text: String) {
        super.init(id: id)
        self.text(text)
    }

    @discardableResult
    public init (id: Int32? = nil, _ state: State<String>) {
        super.init(id: id)
        self.text(state)
    }
}

extension TextView: _SetTextable {}

// MARK: - Constants

extension TextView {
    public enum AutoSizeTextType: Int32, Sendable {
        /// The TextView does not auto-size text (default).
        case none = 0
        /// The TextView scales text size both horizontally and vertically to fit within the container.
        case uniform = 1
    }

    public static let focusedSearchResultIndexNone: Int32 = -1
}

// MARK: - Properties

// MARK: AddExtraDataToAccessibilityNodeInfo

extension ViewPropertyKey {
    static let addExtraDataToAccessibilityNodeInfo: Self = "addExtraDataToAccessibilityNodeInfo"
}
// struct AddExtraDataToAccessibilityNodeInfoViewProperty: ViewPropertyToApply {
//     let key: ViewPropertyKey = .addExtraDataToAccessibilityNodeInfo
//     let value: (AccessibilityNodeInfo, String, Bundle)
//     func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
//         guard
//             let lmInstance = value.instantiate(env, instance.context)
//         else {
//             return
//         }
//         instance.callVoidMethod(env, name: key.rawValue, args: lmInstance.object.signed(as: LayoutManager.className))
//     }
// }
extension TextView {
    /// Adds extra data to an AccessibilityNodeInfo based on an explicit request for the additional data.
    /// 
    /// This method only needs overloading if the node is marked as having extra data available.
    // public func extraDataToAccessibilityNodeInfo(_ info: AccessibilityNodeInfo, extraDataKey: String, arguments: Bundle) -> Self {
    //     // TODO: extraDataToAccessibilityNodeInfo
    // }
}

// MARK: AddTextChangedListener

#if os(Android)
struct TextChangedListenerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "addTextChangedListener"
    let value: NativeTextWatcher
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        if value.instance == nil {
            value.attach(to: instance)
        }
        guard let listener = value.instance else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: listener.object.signed(as: NativeTextWatcher.originalClassName))
    }
}
#endif
extension TextView {
    #if canImport(AndroidLooper)
    public typealias BeforeTextChangedEventHandler = @UIThreadActor (NativeTextWatcherBeforeTextChangedEvent) -> Void
    public typealias OnTextChangedEventHandler = @UIThreadActor (NativeTextWatcherOnTextChangedEvent) -> Void
    public typealias AfterTextChangedEventHandler = @UIThreadActor (NativeTextWatcherAfterTextChangedEvent) -> Void
    #else
    public typealias BeforeTextChangedEventHandler = (NativeTextWatcherBeforeTextChangedEvent) -> Void
    public typealias OnTextChangedEventHandler = (NativeTextWatcherOnTextChangedEvent) -> Void
    public typealias AfterTextChangedEventHandler = (NativeTextWatcherAfterTextChangedEvent) -> Void
    #endif
    /// Register a callback to be invoked when the text is changed.
    @discardableResult
    public func textChangedListener(
        beforeTextChanged: BeforeTextChangedEventHandler?,
        onTextChanged: @escaping OnTextChangedEventHandler,
        afterTextChanged: AfterTextChangedEventHandler?
    ) -> Self {
        #if os(Android)
        return TextChangedListenerViewProperty(value: .init(id, viewId: id).setHandler(self) { event in
            beforeTextChanged?(event)
        } _: { event in
            onTextChanged(event)
        } _: { event in
            afterTextChanged?(event)
        }).applyOrAppend(nil, self)
        #else
        return self
        #endif
    }
}

// MARK: Append

extension TextView {
    /// Convenience method to append the specified text to the TextView's display buffer,
    /// upgrading it to `.editable`` if it was not already editable.
    public func append(_ text: String) {
        guard let str = text.wrap() else { return }
        instance?.callVoidMethod(name: "append", args: str.signedAsCharSequence())
    }

    /// Convenience method to append the specified text to the TextView's display buffer,
    /// upgrading it to `.editable` if it was not already editable.
    public func append(_ text: String, start: Int, end: Int) {
        guard let str = text.wrap() else { return }
        instance?.callVoidMethod(name: "append", args: str.signedAsCharSequence(), Int32(start), Int32(end))
    }
}

// MARK: Autofill

extension TextView {
    /// Automatically fills the content of this view with the value.
    ///
    /// Views support the Autofill Framework mainly by:
    ///
    /// - Providing the metadata defining what the view means and how it can be autofilled.
    /// - Implementing the methods that autofill the view.
    ///
    /// `onProvideAutofillStructure(android.view.ViewStructure, int)`
    /// is responsible for the former, this method is responsible for latter.
    ///
    /// This method does nothing by default, but when overridden it typically:
    /// 
    /// 1. Checks if the provided value matches the expected type (which is defined by getAutofillType()).
    /// 2. Checks if the view is editable - if it isn't, it should return right away.
    /// 3. Call the proper getter method on AutofillValue to fetch the actual value.
    /// 4. Pass the actual value to the equivalent setter in the view.
    /// 
    /// For example, a text-field view could implement the method this way:
    ///
    /// ```swift
    /// override func autofill(_ value: AutofillValue) {
    ///     if value.type != .text { return }
    ///     if !isEditable { return }
    ///     let text = value.textValue
    ///     setText(text)
    /// }
    /// ```
    /// 
    /// [Learn more](https://developer.android.com/reference/android/view/View#autofill(android.view.autofill.AutofillValue))
    public func autofill(_ value: AutofillValue) {
        instance?.callVoidMethod(name: "autofill", args: value.object.signed(as: AutofillValue.className))
    }
}

// MARK: BatchEdit

extension TextView {
    /// Begins a batch edit on the text view.
    public func beginBatchEdit() {
        instance?.callVoidMethod(name: "beginBatchEdit")
    }

    /// Ends a batch edit on the text view.
    public func endBatchEdit() {
        instance?.callVoidMethod(name: "endBatchEdit")
    }
}

// MARK: BringPointIntoView

extension TextView {
    /// Move the point, specified by the offset, into the view if it is needed. This has to be called after layout.
    /// 
    /// Returns true if anything changed.
    public func bringPointIntoView(_ offset: Int) -> Bool {
        instance?.callBoolMethod(name: "bringPointIntoView", args: Int32(offset)) ?? false
    }

    /// Move the insertion position of the given offset into visible area of the View.
    /// If the View is focused or requestRectWithoutFocus is set to true, this API
    /// may call `View.requestRectangleOnScreen(Rect)` to bring the point to the visible area if necessary.
    /// 
    /// Returns true if anything changed, otherwise false.
    public func bringPointIntoView(_ offset: Int, requestRectWithoutFocus: Bool) -> Bool {
        instance?.callBoolMethod(name: "bringPointIntoView", args: Int32(offset), requestRectWithoutFocus) ?? false
    }
}

// MARK: CancelLongPress

extension TextView {
    /// Cancels a pending long press.
    /// 
    /// Your subclass can use this if you want the context menu to come up if the user presses and holds at the same place,
    /// but you don't want it to come up if they press and then move around enough to cause scrolling.
    public func cancelLongPress() {
        instance?.callVoidMethod(name: "cancelLongPress")
    }
}

// MARK: ClearComposingText

extension TextView {
    /// Clear any composing state that the IME has put the text view in.
    /// 
    /// This will stop any ongoing input method state, such as a multi-character
    /// input sequence, and take the text out of the composing state.
    public func clearComposingText() {
        instance?.callVoidMethod(name: "clearComposingText")
    }
}

// MARK: ComputeScroll

extension TextView {
    /// Called by a parent to request that a child update its values for `mScrollX` and `mScrollY` if necessary.
    /// 
    /// This will typically be done if the child is animating a scroll using a Scroller object.
    public func computeScroll() -> Bool {
        instance?.callBoolMethod(name: "computeScroll") ?? false
    }
}

// MARK: Debug

extension TextView {
    /// Print to the log the current state of the text view.
    public func debug(_ depth: Int) {
        instance?.callVoidMethod(name: "debug", args: Int32(depth))
    }
}

// MARK: DidTouchFocusSelect

extension TextView {
    /// Returns true, only while processing a touch gesture, if the initial touch down event caused focus to move to the text view and as a result its selection changed.
    /// 
    /// Only valid while processing the touch gesture of interest, in an editable text view.
    public func didTouchFocusSelect() {
        instance?.callVoidMethod(name: "didTouchFocusSelect")
    }
}

// MARK: DrawableHotspotChanged

extension TextView {
    /// This function is called whenever the view hotspot changes and needs to be propagated to drawables or child views managed by the view.
    ///
    /// Dispatching to child views is handled by `dispatchDrawableHotspotChanged(float, float)`.
    ///
    /// Be sure to call through to the superclass when overriding this function.
    /// 
    /// If you override this method you must call through to the superclass implementation.
    public func drawableHotspotChanged(x: Float, y: Float) {
        instance?.callVoidMethod(name: "drawableHotspotChanged", args: x, y)
    }
}

// MARK: ExtractText

extension TextView {
    /// Extracts text from the TextView for use in an input method.
    /// 
    /// The default implementation copies the text from the TextView into the given ExtractedText object.
    /// If the TextView is editable, it also sets the input type and selection information.
    /// 
    /// You can override this method to provide a different implementation,
    /// for example if you want to limit the amount of text that is copied into the ExtractedText object.
    // public func extractText(_ request: ExtractedTextRequest, outText: ExtractedText) -> Bool {
    //     instance?.callBoolMethod(name: "extractText", args: request.object.signed(as: ExtractedTextRequest.className), outText.object.signed(as: ExtractedText.className)) ?? 0
    // } // TODO: extractText
}

// TODO: findViewsWithText

// MARK: GetAutoLinkMask

extension TextView {
    /// Gets the autolink mask of the text.
    public func autoLinkMask() -> Int {
        Int(instance?.callIntMethod(name: "getAutoLinkMask") ?? 0)
    }
}

// MARK: GetAutoSizeMaxTextSize

extension TextView {
    /// Returns the current auto-size maximum text size in pixels (the default is 112sp).
    /// 
    /// Note that if auto-size has not been configured this function returns -1.
    public func autoSizeMaxTextSize() -> Int {
        Int(instance?.callIntMethod(name: "getAutoSizeMaxTextSize") ?? -1)
    }
}

// MARK: GetAutoSizeMinTextSize

extension TextView {
    /// Returns the current auto-size minimum text size in pixels (the default is 12sp).
    /// 
    /// Note that if auto-size has not been configured this function returns -1.
    public func autoSizeMinTextSize() -> Int {
        Int(instance?.callIntMethod(name: "getAutoSizeMinTextSize") ?? -1)
    }
}

// MARK: GetAutoSizeStepGranularity

extension TextView {
    /// Returns the current auto-size step granularity in pixels.
    public func autoSizeStepGranularity() -> Int {
        Int(instance?.callIntMethod(name: "getAutoSizeStepGranularity") ?? 0)
    }
}

// MARK: GetAutoSizeTextAvailableSizes

// extension TextView { // TODO: autoSizeTextAvailableSizes
//     /// Returns the current auto-size int sizes array (in pixels).
//     public func autoSizeTextAvailableSizes() -> [Int] {
//         guard let arr = instance?.callObjectMethod(name: "getAutoSizeTextAvailableSizes") else { return [] }
//         return JArray<Int32>(arr).toArray().map { Int($0) } ?? []
//     }
// }

// MARK: GetAutoSizeTextType

extension TextView {
    /// Returns the type of auto-size set for this widget.
    public func autoSizeTextType() -> AutoSizeTextType {
        guard let value = instance?.callIntMethod(name: "getAutoSizeTextType") else { return .none }
        return AutoSizeTextType(rawValue: value) ?? .none
    }
}

// MARK: GetAutofillHints

extension TextView {
    /// Gets the hints that help an `AutofillService` determine how to autofill the view with the user's data.
    public func autofillHints() -> [String] {
        guard
            let env = JEnv.current(),
            let arrayClazz = JClass.load(Drawable.className.asArray()),
            let arrayObject = instance?.callObjectMethod(env, name: "getAutofillHints", returningClass: arrayClazz)
        else { return [] }
        return JObjectArray(env, arrayObject).toArray().compactMap { JString($0).string() }
    }
}

// MARK: GetAutofillType

extension TextView {
    /// Describes the autofill type of this view, so an `AutofillService` can create the proper `AutofillValue` when autofilling the view.
    ///
    /// By default returns `.none`, but views should override it to properly support the Autofill Framework.
    public func autofillType() -> AutofillType {
        guard let value = instance?.callIntMethod(name: "getAutofillType") else { return .none }
        return AutofillType(rawValue: value) ?? .none
    }
}

// MARK: GetAutofillValue

extension TextView {
    /// Gets the TextView's current text for `AutoFill`.
    /// 
    /// The value is trimmed to **100K** chars if longer.
    public func autofillValue() -> AutofillValue? {
        guard
            let returningClazz = JClass.load(AutofillValue.className),
            let obj = instance?.callObjectMethod(name: "getAutofillValue", returningClass: returningClazz)
        else { return nil }
        return AutofillValue(obj)
    }
}

// MARK: GetBaseline

extension TextView {
    /// Returns the offset of the widget's text baseline from the widget's top boundary.
    /// 
    /// If this widget does not support baseline alignment, this method returns -1.
    public func baseline() -> Int {
        Int(instance?.callIntMethod(name: "getBaseline") ?? -1)
    }
}

// MARK: GetBreakStrategy

public enum BreakStrategy: Int32, Sendable {
    /// Value for break strategy indicating simple line breaking.
    /// The line breaker puts words to the line as much as possible and breaks line if no more words can fit into the same line.
    /// Automatic hyphens are only added when a line has a single word and that word is longer than line width.
    /// This is the fastest break strategy and ideal for editor.
    case simple = 0
    /// Value for break strategy indicating high quality line breaking.
    /// With this option line breaker does whole-paragraph optimization for more readable text, and also applies automatic hyphenation when required.
    case highQuality = 1
    /// Value for break strategy indicating balanced line breaking.
    /// The line breaker does whole-paragraph optimization for making all lines similar length, and also applies automatic hyphenation when required.
    /// This break strategy is good for small screen devices such as watch screens.
    case balanced = 2
}

extension TextView {
    /// Gets the current strategy for breaking paragraphs into lines.
    public func breakStrategy() -> BreakStrategy {
        guard let value = instance?.callIntMethod(name: "getBreakStrategy") else { return .simple }
        return BreakStrategy(rawValue: value) ?? .simple
    }
}

// MARK: GetCompoundDrawablePadding

extension TextView {
    /// Returns the padding between the compound drawables and the text.
    public func compoundDrawablePadding() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundDrawablePadding") ?? 0)
    }
}

// TODO: implement getCompoundDrawableTintBlendMode https://developer.android.com/reference/android/graphics/BlendMode

// TODO: implement getCompoundDrawableTintList https://developer.android.com/reference/android/content/res/ColorStateList

// TODO: implement getCompoundDrawableTintMode https://developer.android.com/reference/android/graphics/PorterDuff.Mode

// MARK: GetCompoundDrawables

extension TextView {
    /// Returns drawables for the left, top, right, and bottom borders.
    public func compoundDrawables() -> [Drawable] {
        guard
            let env = JEnv.current(),
            let arrayClazz = JClass.load(Drawable.className.asArray()),
            let arrayObject = instance?.callObjectMethod(env, name: "getCompoundDrawables", returningClass: arrayClazz)
        else { return [] }
        return JObjectArray(env, arrayObject).toArray().map { Drawable($0) }
    }
}

// MARK: GetCompoundDrawablesRelative

extension TextView {
    /// Returns drawables for the start, top, end, and bottom borders.
    public func compoundDrawablesRelative() -> [Drawable] {
        guard
            let env = JEnv.current(),
            let arrayClazz = JClass.load(Drawable.className.asArray()),
            let arrayObject = instance?.callObjectMethod(env, name: "getCompoundDrawablesRelative", returningClass: arrayClazz)
        else { return [] }
        return JObjectArray(env, arrayObject).toArray().map { Drawable($0) }
    }
}

// MARK: Paddings

extension TextView {
    /// Returns the bottom padding of the view, plus space for the bottom Drawable if any.
    public func compoundPaddingBottom() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingBottom") ?? 0)
    }

    /// Returns the end padding of the view, plus space for the end Drawable if any.
    public func compoundPaddingEnd() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingEnd") ?? 0)
    }

    /// Returns the left padding of the view, plus space for the left Drawable if any.
    public func compoundPaddingLeft() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingLeft") ?? 0)
    }

    /// Returns the right padding of the view, plus space for the right Drawable if any.
    public func compoundPaddingRight() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingRight") ?? 0)
    }

    /// Returns the start padding of the view, plus space for the start Drawable if any.
    public func compoundPaddingStart() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingStart") ?? 0)
    }

    /// Returns the top padding of the view, plus space for the top Drawable if any.
    public func compoundPaddingTop() -> Int {
        Int(instance?.callIntMethod(name: "getCompoundPaddingTop") ?? 0)
    }

    /// Returns the extended bottom padding of the view, including both the bottom Drawable if any and any extra space to keep more than maxLines of text from showing.
    ///
    /// It is only valid to call this after measuring.
    public func extendedPaddingBottom() -> Int {
        Int(instance?.callIntMethod(name: "getExtendedPaddingBottom") ?? 0)
    }

    /// Returns the extended top padding of the view, including both the top Drawable if any and any extra space to keep more than maxLines of text from showing.
    /// 
    /// It is only valid to call this after measuring.
    public func getExtendedPaddingTop() -> Int {
        Int(instance?.callIntMethod(name: "getExtendedPaddingTop") ?? 0)
    }
}

// MARK: GetCurrentHintTextColor

extension TextView {
    /// Returns the current color of the hint text.
    public func currentHintTextColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getCurrentHintTextColor") ?? 0)
    }
}

// MARK: GetCurrentTextColor

extension TextView {
    /// Return the current color selected for normal text.
    public func currentTextColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getCurrentTextColor") ?? 0)
    }
}

// TODO: getCustomInsertionActionModeCallback

// TODO: getCustomSelectionActionModeCallback

// MARK: GetEditableText

extension TextView {
    /// Returns the text that is currently being edited.
    /// 
    /// If the text is not editable, null is returned.
    public func editableText() -> String? { // TODO: switch to Editable?
        guard
            let returningClazz = JClass.load("android/text/Editable"),
            let obj = instance?.callObjectMethod(name: "getEditableText", returningClass: returningClazz) else { return nil }
        return JString(obj).string()
    }
}

// TODO: getEllipsize

// MARK: GetError

extension TextView {
    /// Returns the error string that was set to be displayed with `setError(String)`.
    public func error() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getError", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// TODO: getFilters

// MARK: GetFirstBaselineToTopHeight

extension TextView {
    /// Returns the distance between the first text baseline and the top of this TextView.
    public func firstBaselineToTopHeight() -> Int {
        Int(instance?.callIntMethod(name: "getFirstBaselineToTopHeight") ?? 0)
    }
}

// TODO: getFocusedRect

// MARK: GetFocusedSearchResultHighlightColor

extension TextView {
    /// Gets focused search result highlight color.
    public func focusedSearchResultHighlightColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getFocusedSearchResultHighlightColor") ?? 0)
    }
}

// MARK: GetFocusedSearchResultIndex

extension TextView {
    /// Gets the focused search result index.
    public func focusedSearchResultIndex() -> Int {
        Int(instance?.callIntMethod(name: "getFocusedSearchResultIndex") ?? Int32(TextView.focusedSearchResultIndexNone))
    }
}

// MARK: GetFontFeatureSettings

extension TextView {
    /// Returns the font feature settings.
    /// 
    /// The format is the same as the CSS font-feature-settings attribute: https://www.w3.org/TR/css-fonts-3/#font-feature-settings-prop
    public func fontFeatureSettings() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getFontFeatureSettings", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// MARK: GetFontVariationSettings

extension TextView {
    /// Returns the font variation settings.
    public func fontVariationSettings() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getFontVariationSettings", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// MARK: GetFreezesText

extension TextView {
    /// Return whether this text view is including its entire text contents in frozen icicles.
    /// 
    /// For EditText it always returns true.
    /// 
    /// Returns true if text is included, false if it isn't.
    public func freezesText() -> Bool {
        instance?.callBoolMethod(name: "getFreezesText") ?? false
    }
}

// MARK: GetGravity

extension TextView {
    /// Returns the horizontal and vertical alignment of this TextView.
    public func gravity() -> Gravity {
        guard let value = instance?.callIntMethod(name: "getGravity") else { return .noGravity }
        return Gravity(rawValue: Int(value))
    }
}

// MARK: GetHighlightColor

extension TextView {
    /// Returns the color of the selection highlight.
    public func highlightColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getHighlightColor") ?? 0)
    }
}

// TODO: implement getHighlights

// MARK: GetHint

extension TextView {
    /// Returns the current hint text.
    public func hint() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getHint", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// TODO: getHintTextColors

// MARK: GetHyphenationFrequency

extension TextView {
    /// Gets the current frequency of automatic hyphenation to be used when determining word breaks.
    public func hyphenationFrequency() -> HyphenationFrequency {
        guard let value = instance?.callIntMethod(name: "getHyphenationFrequency") else { return .none }
        return HyphenationFrequency(rawValue: value) ?? .none
    }
}

public enum HyphenationFrequency: Int32, Sendable {
    /// Indicating the full amount of automatic hyphenation, typical in typography.
    /// Useful for running text and where it's important to put the maximum amount of text in a screen with limited space.
    case full = 2
    /// Indicating the full amount of automatic hyphenation with using faster algorithm.
    /// This option is useful for running text and where it's important to put the maximum amount of text in a screen with limited space. To make text rendering faster with hyphenation, this algorithm ignores some hyphen character related typographic features, e.g. kerning.
    case fullFast = 4
    /// Indicating no automatic hyphenation. Useful for backward compatibility, and for cases where the automatic hyphenation algorithm results in incorrect hyphenation. Mid-word breaks may still happen when a word is wider than the layout and there is otherwise no valid break.
    /// Soft hyphens are ignored and will not be used as suggestions for potential line breaks.
    case none = 0
    /// Indicating a light amount of automatic hyphenation, which is a conservative default.
    /// Useful for informal cases, such as short sentences or chat messages.
    case normal = 1
    /// Indicating a light amount of automatic hyphenation with using faster algorithm.
    /// This option is useful for informal cases, such as short sentences or chat messages.
    /// To make text rendering faster with hyphenation, this algorithm ignores some hyphen character related typographic features, e.g. kerning.
    case normalFast = 3
}

// MARK: GetImeActionId

extension TextView {
    /// Get the IME action ID.
    public func imeActionId() -> Int32 {
        instance?.callIntMethod(name: "getImeActionId") ?? 0
    }
}

// MARK: GetImeActionLabel

extension TextView {
    /// Get the IME action label.
    public func imeActionLabel() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getImeActionLabel", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// TODO: getImeHintLocales

// MARK: GetImeOptions

extension TextView {
    /// Get the type of the Input Method Editor (IME).
    public func imeOptions() -> Int32 {
        instance?.callIntMethod(name: "getImeOptions") ?? 0
    }
}

// MARK: GetIncludeFontPadding

extension TextView {
    /// Gets whether the TextView includes extra top and bottom padding to make room for accents that go above the normal ascent and descent.
    public func includeFontPadding() -> Bool {
        instance?.callBoolMethod(name: "getIncludeFontPadding") ?? true
    }
}

// MARK: GetInputExtras

extension TextView {
    /// Retrieve the input extras currently associated with the text view, which can be viewed as well as modified.
    /// 
    /// If `true`, the extras will be created if they don't already exist.
    /// Otherwise, null will be returned if none have been created.
    public func inputExtras() -> Bundle? {
        guard
            let returningClazz = JClass.load(Bundle.className),
            let obj = instance?.callObjectMethod(name: "getInputExtras", returningClass: returningClazz)
        else { return nil }
        return Bundle(obj)
    }
}

// TODO: getInputType

// MARK: GetJustificationMode

public enum JustificationMode: Int32, Sendable {
    /// Indicating no justification.
    case none = 0
    /// Indicating the text is justified by stretching word spacing.
    case interWord = 1
    /// Indicating the text is justified by stretching letter spacing.
    case interCharacter = 2
}

extension TextView {
    /// Gets the current justification mode.
    public func justificationMode() -> JustificationMode {
        guard let value = instance?.callIntMethod(name: "getJustificationMode") else { return .none }
        return JustificationMode(rawValue: value) ?? .none
    }
}

// TODO: getKeyListener

// MARK: GetLastBaselineToBottomHeight

extension TextView {
    /// Returns the distance between the last text baseline and the bottom of this TextView.
    public func lastBaselineToBottomHeight() -> Int {
        Int(instance?.callIntMethod(name: "getLastBaselineToBottomHeight") ?? 0)
    }
}

// TODO: getLayout

// MARK: GetLetterSpacing

extension TextView {
    /// Gets the text letter-space value, which determines the spacing between characters. 
    /// 
    /// The value returned is in ems. Normally, this value is 0.0.
    public func letterSpacing() -> Float {
        instance?.callFloatMethod(name: "getLetterSpacing") ?? 0
    }
}

// MARK: GetLineBounds

extension TextView {
    /// Return the baseline for the specified line (0...getLineCount() - 1).
    /// If bounds is not null, return the top, left, right, bottom extents of the specified line in it.
    /// If the internal Layout has not been built, return 0 and set bounds to (0, 0, 0, 0).
    /// 
    /// The `lineBounds` parameter is optional. If not null, it returns the extent of the line
    /// 
    /// Returns the Y-coordinate of the baseline.
    public func lineBounds(line: Int, lineBounds: Rect?) -> Int? {
        guard let instance else { return nil }
        if let lineBounds {
            guard let value = instance.callIntMethod(name: "getLineBounds", args: Int32(line), lineBounds.object.signed(as: Rect.className)) else { return nil }
            return Int(value)
        } else {
            guard let value = instance.callIntMethod(name: "getLineBounds", args: Int32(line)) else { return nil }
            return Int(value)
        }
    }
}

// MARK: GetLineBreakStyle

public enum LineBreakStyle: Int32, Sendable {
    /// No line-break rules are used for line breaking.
    case none = 0
    /// The least restrictive line-break rules are used for line breaking. This setting is typically used for short lines.
    case loose = 1
    /// The most common line-break rules are used for line breaking.
    case normal = 2
    /// The most strict line-break rules are used for line breaking.
    case strict = 3
    /// The line break style that used for preventing automatic line breaking. This is useful when you want to preserve some words in the same line by using LineBreakConfigSpan or LineBreakConfigSpan.createNoBreakSpan() as a shorthand. Note that even if this style is specified, the grapheme based line break is still performed for preventing clipping text.
    case noBreak = 4
    /// A special value for the line breaking style option.
    ///
    /// The auto option for the line break style set the line break style based on the locale of the text rendering context. You can specify the context locale by TextView.setTextLocales(LocaleList) or Paint.setTextLocales(LocaleList).
    ///
    /// Note: future versions may have special line breaking style rules for other locales.
    case auto = 5
}

public enum LineBreakWordStyle: Int32, Sendable {
    /// No line-break word style is used for line breaking.
    case none = 0
    /// Line breaking is based on phrases, which results in text wrapping only on meaningful words.
    ///
    /// Support for this line-break word style depends on locale. If the current locale does not support phrase-based text wrapping, this setting has no effect.
    case phrase = 1
    /// A special value for the line breaking word style option.
    ///
    /// The auto option for the line break word style does some heuristics based on locales and line count.
    ///
    /// Note: future versions may have special line breaking word style rules for other locales.
    case auto = 2
}

extension TextView {
    /// Gets the current line-break style for text wrapping.
    public func lineBreakStyle() -> LineBreakStyle {
        guard let value = instance?.callIntMethod(name: "getLineBreakStyle") else { return .none }
        return LineBreakStyle(rawValue: value) ?? .none
    }

    /// Gets the current line-break word style for text wrapping.
    public func lineBreakWordStyle() -> LineBreakWordStyle {
        guard let value = instance?.callIntMethod(name: "getLineBreakWordStyle") else { return .none }
        return LineBreakWordStyle(rawValue: value) ?? .none
    }
}

// MARK: GetLineCount

extension TextView {
    /// Return the number of lines of text, or 0 if the internal Layout has not been built.
    public func lineCount() -> Int {
        Int(instance?.callIntMethod(name: "getLineCount") ?? 0)
    }
}

// MARK: GetLineHeight

extension TextView {
    /// Gets the vertical distance between lines of text, in pixels.
    /// 
    /// Note that markup within the text can cause individual lines to be taller or shorter than this height,
    /// and the layout may contain additional first-or last-line padding.
    public func lineHeight() -> Int {
        Int(instance?.callIntMethod(name: "getLineHeight") ?? 0)
    }
}

// MARK: GetLineSpacingExtra

extension TextView {
    /// Returns the extra space that is added to the height of each lines of this TextView.
    public func lineSpacingExtra() -> Float {
        instance?.callFloatMethod(name: "getLineSpacingExtra") ?? 0
    }
}

// MARK: GetLineSpacingMultiplier

extension TextView {
    /// Returns the value by which each line's height is multiplied to get its actual height.
    public func lineSpacingMultiplier() -> Float {
        instance?.callFloatMethod(name: "getLineSpacingMultiplier") ?? 1
    }
}

// TODO: getLinkTextColors, implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList

// MARK: GetLinksClickable

extension TextView {
    /// Returns whether the movement method will automatically be set
    /// to `LinkMovementMethod` if `setAutoLinkMask(int)` has been set
    /// to nonzero and links are detected in `setText(char, int, int)`.
    /// 
    /// The default is true.
    public func linksClickable() -> Bool {
        instance?.callBoolMethod(name: "getLinksClickable") ?? true
    }
}

// MARK: GetMarqueeRepeatLimit

extension TextView {
    /// Gets the number of times the marquee animation is repeated.
    /// 
    /// Only meaningful if the TextView has marquee enabled.
    /// 
    /// Returns the number of times the marquee animation is repeated. -1 if the animation repeats indefinitely
    public func marqueeRepeatLimit() -> Int {
        Int(instance?.callIntMethod(name: "getMarqueeRepeatLimit") ?? 0)
    }
}

// MARK: GetMaxEms

extension TextView {
    /// Returns the maximum width of TextView in terms of ems
    /// or -1 if the maximum width was set using `setMaxWidth(int)` or `setWidth(int)`.
    /// 
    /// Returns the maximum width of TextView in terms of ems or -1 if the maximum width is not defined in ems
    public func maxEms() -> Int {
        Int(instance?.callIntMethod(name: "getMaxEms") ?? -1)
    }
}

// MARK: GetMaxHeight

extension TextView {
    /// Returns the maximum height of TextView in terms of pixels
    /// or -1 if the maximum height was set using `setMaxLines(int)` or `setHeight(int)`.
    /// 
    /// Returns the maximum height of TextView in terms of pixels or -1 if the maximum height is not defined in pixels.
    public func maxHeight() -> Int {
        Int(instance?.callIntMethod(name: "getMaxHeight") ?? -1)
    }
}

// MARK: GetMaxLines

extension TextView {
    /// Returns the maximum number of lines displayed in this TextView or -1 if the maximum number of lines is not defined.
    public func maxLines() -> Int {
        Int(instance?.callIntMethod(name: "getMaxLines") ?? -1)
    }
}

// MARK: GetMaxWidth

extension TextView {
    /// Returns the maximum width of TextView in terms of pixels. -1 if the maximum width is not defined in pixels.
    public func maxWidth() -> Int {
        Int(instance?.callIntMethod(name: "getMaxWidth") ?? -1)
    }
}

// MARK: GetMinEms

extension TextView {
    /// Returns the minimum width of TextView in terms of ems. -1 if the minimum width is not defined in ems.
    public func minEms() -> Int {
        Int(instance?.callIntMethod(name: "getMinEms") ?? -1)
    }
}

// MARK: GetMinHeight

extension TextView {
    /// Returns the minimum height of TextView in terms of pixels or -1 if the minimum height is not defined in pixels.
    public func minHeight() -> Int {
        Int(instance?.callIntMethod(name: "getMinHeight") ?? -1)
    }
}

// MARK: GetMinLines

extension TextView {
    /// Returns the minimum height of TextView in terms of number of lines or -1 if the minimum height is not defined in lines.
    public func minLines() -> Int {
        Int(instance?.callIntMethod(name: "getMinLines") ?? -1)
    }
}

// MARK: GetMinWidth

extension TextView {
    /// Returns the minimum width of TextView in terms of pixels or -1 if the minimum width is not defined in pixels.
    public func minWidth() -> Int {
        Int(instance?.callIntMethod(name: "getMinWidth") ?? -1)
    }
}

// TODO: getMinimumFontMetrics: implement Paint.FontMetrics https://developer.android.com/reference/android/graphics/Paint.FontMetrics
// TODO: getMovementMethod: implement MovementMethod https://developer.android.com/reference/android/text/method/MovementMethod

// MARK: GetOffsetForPosition

extension TextView {
    /// Get the character offset closest to the specified absolute position.
    /// 
    /// A typical use case is to pass the result of `MotionEvent.getX()` and `MotionEvent.getY()` to this method.
    ///
    /// Parameters:
    /// - x: The horizontal absolute position of a point on screen
    /// - y: The vertical absolute position of a point on screen
    ///
    /// Returns the character offset for the character whose position is closest to the specified position. Returns -1 if there is no layout.
    public func offsetForPosition(x: Float, y: Float) -> Int {
        Int(instance?.callIntMethod(name: "getOffsetForPosition", args: x, y) ?? 0)
    }
}

// TODO: getPaint: implement TextPaint https://developer.android.com/reference/android/text/TextPaint
// TODO: getPaintFlags

// MARK: GetPrivateImeOptions

extension TextView {
    /// Get the private type of the content.
    public func privateImeOptions() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getPrivateImeOptions", returningClass: returningClazz)
        else { return nil }
        return JString(obj).string()
    }
}

// MARK: GetSearchResultHighlightColor

extension TextView {
    /// Gets the search result highlight color.
    public func searchResultHighlightColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getSearchResultHighlightColor") ?? 0)
    }
}

// MARK: GetSearchResultHighlights

extension TextView {
    /// Gets the current search result ranges.
    ///
    /// Returns a flatten search result ranges. Empty array if not available.
    public func searchResultHighlights() -> [Rect] {
        guard
            let env = JEnv.current(),
            let arrayClazz = JClass.load(Rect.className.asArray()),
            let arrayObject = instance?.callObjectMethod(env, name: "getSearchResultHighlights", returningClass: arrayClazz)
        else { return [] }
        return JObjectArray(env, arrayObject).toArray().map { Rect($0) }
    }
}

// MARK: Selection

extension TextView {
    /// Convenience for `Selection.getSelectionEnd`.
    public func selectionEnd() -> Int {
        Int(instance?.callIntMethod(name: "getSelectionEnd") ?? -1)
    }

    /// Convenience for `Selection.getSelectionStart`.
    public func selectionStart() -> Int {
        Int(instance?.callIntMethod(name: "getSelectionStart") ?? -1)
    }
}

// MARK: GetShadowColor

extension TextView {
    /// Gets the color of the shadow layer.
    public func shadowColor() -> GraphicsColor {
        GraphicsColor(integerLiteral: instance?.callIntMethod(name: "getShadowColor") ?? 0)
    }
}

// MARK: GetShadowDx

extension TextView {
    /// Gets the horizontal offset of the shadow layer.
    public func shadowDx() -> Float {
        instance?.callFloatMethod(name: "getShadowDx") ?? 0
    }
}

// MARK: GetShadowDy

extension TextView {
    /// Gets the vertical offset of the shadow layer.
    public func shadowDy() -> Float {
        instance?.callFloatMethod(name: "getShadowDy") ?? 0
    }
}

// MARK: GetShadowRadius

extension TextView {
    /// Gets the radius of the shadow layer. If 0, the shadow layer is not visible
    public func shadowRadius() -> Float {
        instance?.callFloatMethod(name: "getShadowRadius") ?? 0
    }
}

// MARK: GetShiftDrawingOffsetForStartOverhang

extension TextView {
    /// Returns true if shifting the drawing x offset for start overhang.
    public func shiftDrawingOffsetForStartOverhang() -> Bool {
        instance?.callBoolMethod(name: "getShiftDrawingOffsetForStartOverhang") ?? false
    }
}

// MARK: GetShowSoftInputOnFocus

extension TextView {
    /// Returns whether the soft input method will be made visible when this view gets focused.
    /// 
    /// The default is true.
    public func showSoftInputOnFocus() -> Bool {
        instance?.callBoolMethod(name: "getShowSoftInputOnFocus") ?? true
    }
}

// MARK: GetText

extension TextView {
    /// Returns the text that TextView is displaying.
    /// 
    /// If `setText()` was called with an argument of `BufferType.EDITABLE`,
    /// you can cast the return value to `Editable` and use it to modify the text.
    /// 
    /// Returns the text displayed by the TextView.
    public func text() -> String { // TODO: switch to CharSequence to be able to cast to Editable
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let obj = instance?.callObjectMethod(name: "getText", returningClass: returningClazz)
        else { return "" }
        return JString(obj).string() ?? "" // may fail if the original object is Editable
    }
}

// TOOD: getTextClassifier: implement TextClassifier https://developer.android.com/reference/android/view/textclassifier/TextClassifier

// TODO: getTextColors: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList

// MARK: GetTextCursorDrawable

extension TextView {
    /// Returns the Drawable corresponding to the text cursor.
    /// 
    /// Note that any change applied to the cursor Drawable will not be visible until the cursor is hidden and then drawn again.
    public func textCursorDrawable() -> [Drawable] {
        guard
            let env = JEnv.current(),
            let arrayClazz = JClass.load(Drawable.className.asArray()),
            let arrayObject = instance?.callObjectMethod(env, name: "getTextCursorDrawable", returningClass: arrayClazz)
        else { return [] }
        return JObjectArray(env, arrayObject).toArray().map { Drawable($0) }
    }
}

// TODO: getTextDirectionHeuristic: implement TextDirectionHeuristic https://developer.android.com/reference/android/text/TextDirectionHeuristic
// TODO: getTextLocale: implement TextLocale https://developer.android.com/reference/android/graphics/Locale
// TODO: getTextLocales: implement LocaleList https://developer.android.com/reference/android/os/LocaleList
// TODO: getTextMetricsParams: implement PrecomputedText.Params https://developer.android.com/reference/android/text/PrecomputedText.Params

// MARK: GetTextScaleX

extension TextView {
    /// Gets the extent by which text should be stretched horizontally.
    /// 
    /// This will usually be 1.0.
    /// 
    /// Returns the horizontal scale factor.
    public func textScaleX() -> Float {
        instance?.callFloatMethod(name: "getTextScaleX") ?? 1
    }
}

// MARK: GetTextSelectHandle

extension TextView {
    /// Returns the Drawable corresponding to the selection handle used for positioning the cursor within text.
    /// 
    /// Note that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandle() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let obj = instance?.callObjectMethod(name: "getTextSelectHandle", returningClass: returningClazz)
        else { return nil }
        return Drawable(obj)
    }
}

// MARK: GetTextSelectHandleLeft

extension TextView {
    /// Returns the Drawable corresponding to the left handle used for selecting text.
    /// 
    /// Note that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleLeft() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let obj = instance?.callObjectMethod(name: "getTextSelectHandleLeft", returningClass: returningClazz)
        else { return nil }
        return Drawable(obj)
    }
}

// MARK: GetTextSelectHandleRight

extension TextView {
    /// Returns the Drawable corresponding to the right handle used for selecting text.
    /// 
    /// Note that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleRight() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let obj = instance?.callObjectMethod(name: "getTextSelectHandleRight", returningClass: returningClazz)
        else { return nil }
        return Drawable(obj)
    }
}

// MARK: GetTextSize

extension TextView {
    /// Returns the size (in pixels) of the default text size in this TextView.
    public func textSize() -> Float {
        instance?.callFloatMethod(name: "getTextSize") ?? 0
    }
}

// MARK: GetTextSizeUnit

extension TextView {
    /// Returns the unit of the default text size in this TextView.
    public func textSizeUnit() -> DimensionUnit {
        instance?.callIntMethod(name: "getTextSizeUnit").flatMap { DimensionUnit(rawValue: $0) } ?? .px
    }
}

// MARK: GetTotalPaddingBottom

extension TextView {
    /// Returns the total bottom padding of the view, including the bottom Drawable if any,
    // the extra space to keep more than maxLines from showing, and the vertical offset for gravity, if any.
    public func totalPaddingBottom() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingBottom") ?? 0)
    }
}

// MARK: GetTotalPaddingEnd

extension TextView {
    /// Returns the total end padding of the view, including the end Drawable if any.
    public func totalPaddingEnd() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingEnd") ?? 0)
    }
}

// MARK: GetTotalPaddingLeft

extension TextView {
    /// Returns the total left padding of the view, including the left Drawable if any.
    public func totalPaddingLeft() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingLeft") ?? 0)
    }
}

// MARK: GetTotalPaddingRight

extension TextView {
    /// Returns the total right padding of the view, including the right Drawable if any.
    public func totalPaddingRight() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingRight") ?? 0)
    }
}

// MARK: GetTotalPaddingStart

extension TextView {
    /// Returns the total start padding of the view, including the start Drawable if any.
    public func totalPaddingStart() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingStart") ?? 0)
    }
}

// MARK: GetTotalPaddingTop

extension TextView {
    /// Returns the total top padding of the view, including the top Drawable if any,
    /// the extra space to keep more than maxLines from showing, and the vertical offset for gravity, if any.
    public func totalPaddingTop() -> Int {
        Int(instance?.callIntMethod(name: "getTotalPaddingTop") ?? 0)
    }
}

// MARK: GetTransformationMethod

// TODO: getTransformationMethod: implement TransformationMethod https://developer.android.com/reference/android/text/method/TransformationMethod

// TODO: getTypeface: implement Typeface https://developer.android.com/reference/android/graphics/Typeface

// TODO: getUrls: implement URLSpan https://developer.android.com/reference/android/text/style/URLSpan

// MARK: GetUseBoundsForWidth

extension TextView {
    /// Returns true if using bounding box as a width, false for using advance as a width.
    public func useBoundsForWidth() -> Bool {
        instance?.callBoolMethod(name: "getUseBoundsForWidth") ?? false
    }
}

// MARK: HasOverlappingRendering

extension TextView {
    /// Returns whether this View has content which overlaps.
    ///
    /// This function, intended to be overridden by specific View types, is an optimization when alpha is set on a view.
    /// If rendering overlaps in a view with alpha < 1, that view is drawn to an offscreen buffer and then composited into place, which can be expensive.
    /// If the view has no overlapping rendering, the view can draw each primitive with the appropriate alpha value directly. An example of overlapping rendering
    /// is a TextView with a background image, such as a Button. An example of non-overlapping rendering is a TextView with no background,
    /// or an ImageView with only the foreground image. The default implementation returns true; subclasses should override if they have cases which can be optimized.
    ///
    /// Note: The return value of this method is ignored if forceHasOverlappingRendering(boolean) has been called on this view.
    public func hasOverlappingRendering() -> Bool {
        instance?.callBoolMethod(name: "hasOverlappingRendering") ?? true
    }
}

// MARK: HasSelection

extension TextView {
    /// Return true iff there is a selection of nonzero length inside this text view.
    public func hasSelection() -> Bool {
        instance?.callBoolMethod(name: "hasSelection") ?? false
    }
}

// MARK: InvalidateDrawable

extension TextView {
    /// Invalidates the specified Drawable.
    public func invalidateDrawable(_ drawable: Drawable) {
        instance?.callVoidMethod(name: "invalidateDrawable", args: drawable.object.signed(as: Drawable.className))
    }
}

// MARK: IsAllCaps

extension TextView {
    /// Checks whether the transformation method applied to this TextView is set to ALL CAPS.
    public func isAllCaps() -> Bool {
        instance?.callBoolMethod(name: "isAllCaps") ?? false
    }
}

// MARK: IsAutoHandwritingEnabled

extension TextView {
    /// Return whether the View allows automatic handwriting initiation.
    /// Returns true if automatic handwriting initiation is enabled, and vice versa.
    public func isAutoHandwritingEnabled() -> Bool {
        instance?.callBoolMethod(name: "isAutoHandwritingEnabled") ?? false
    }
}

// MARK: IsCursorVisible

extension TextView {
    /// Returns whether the cursor is visible.
    ///
    /// Whether or not the cursor is visible (assuming this TextView is editable).
    /// This method may return false when the IME is consuming the input even if the mEditor.mCursorVisible attribute is true or #setCursorVisible(true) is called.
    public func isCursorVisible() -> Bool {
        instance?.callBoolMethod(name: "isCursorVisible") ?? false
    }
}

// MARK: IsElegantTextHeight

extension TextView {
    /// Get the value of the TextView's elegant height metrics flag.
    /// This setting selects font variants that have not been compacted to fit Latin-based vertical metrics, and also increases top and bottom bounds to provide more space.
    public func isElegantTextHeight() -> Bool {
        instance?.callBoolMethod(name: "isElegantTextHeight") ?? false
    }
}

// MARK: IsFallbackLineSpacing

extension TextView {
    /// Returns true if fallback line spacing is enabled.
    public func isFallbackLineSpacing() -> Bool {
        instance?.callBoolMethod(name: "isFallbackLineSpacing") ?? true
    }
}

// MARK: IsHorizontallyScrollable

extension TextView {
    /// Returns whether the text is allowed to be wider than the View.
    /// If false, the text will be wrapped to the width of the View.
    public func isHorizontallyScrollable() -> Bool {
        instance?.callBoolMethod(name: "isHorizontallyScrollable") ?? false
    }
}

// MARK: IsInputMethodTarget

extension TextView {
    /// Returns whether this text view is a current input method target.
    /// The default implementation just checks with `InputMethodManager`.
    public func isInputMethodTarget() -> Bool {
        instance?.callBoolMethod(name: "isInputMethodTarget") ?? false
    }
}

// MARK: IsLocalePreferredLineHeightForMinimumUsed

extension TextView {
    /// Returns true if the locale preferred line height is used for the minimum line height.
    public func isLocalePreferredLineHeightForMinimumUsed() -> Bool {
        instance?.callBoolMethod(name: "isLocalePreferredLineHeightForMinimumUsed") ?? false
    }
}

// MARK: IsSingleLine

extension TextView {
    /// Returns if the text is constrained to a single horizontally scrolling line ignoring new line characters instead of letting it wrap onto multiple lines.
    public func isSingleLine() -> Bool {
        instance?.callBoolMethod(name: "isSingleLine") ?? false
    }
}

// MARK: IsSuggestionsEnabled

extension TextView {
    /// Return whether or not suggestions are enabled on this TextView.
    /// 
    /// The suggestions are generated by the IME or by the spell checker as the user types.
    /// This is done by adding SuggestionSpans to the text.
    /// When suggestions are enabled (default), this list of suggestions will be displayed when the user asks for them on these parts of the text.
    /// This value depends on the inputType of this TextView.
    /// The class of the input type must be InputType.TYPE_CLASS_TEXT. In addition, the type variation must be one of InputType.TYPE_TEXT_VARIATION_NORMAL, InputType.TYPE_TEXT_VARIATION_EMAIL_SUBJECT, InputType.TYPE_TEXT_VARIATION_LONG_MESSAGE, InputType.TYPE_TEXT_VARIATION_SHORT_MESSAGE or InputType.TYPE_TEXT_VARIATION_WEB_EDIT_TEXT. And finally, the InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS flag must not be set.
    public func isSuggestionsEnabled() -> Bool {
        instance?.callBoolMethod(name: "isSuggestionsEnabled") ?? true
    }
}

// MARK: IsTextSelectable

extension TextView {
    /// Returns the state of the textIsSelectable flag (See setTextIsSelectable()).
    /// 
    /// Although you have to set this flag to allow users to select and copy text in a non-editable TextView,
    /// the content of an EditText can always be selected, independently of the value of this flag.
    public func isTextSelectable() -> Bool {
        instance?.callBoolMethod(name: "isTextSelectable") ?? false
    }
}

// MARK: JumpDrawablesToCurrentState

extension TextView {
    /// Call Drawable.jumpToCurrentState() on all Drawable objects associated with this view.
    ///
    /// Also calls StateListAnimator.jumpToCurrentState() if there is a StateListAnimator attached to this view.
    /// If you override this method you must call through to the superclass implementation.
    public func jumpDrawablesToCurrentState() {
        instance?.callVoidMethod(name: "jumpDrawablesToCurrentState")
    }
}

// MARK: Length

extension TextView {
    /// Returns the length, in characters, of the text managed by this TextView
    public func length() -> Int {
        Int(instance?.callIntMethod(name: "length") ?? 0)
    }
}

// MARK: MoveCursorToVisibleOffset

extension TextView {
    /// Move the cursor, if needed, so that it is at an offset that is visible to the user.
    /// 
    /// This will not move the cursor if it represents more than one character (a selection range).
    /// This will only work if the TextView contains spannable text; otherwise it will do nothing.
    public func moveCursorToVisibleOffset() -> Bool {
        instance?.callBoolMethod(name: "moveCursorToVisibleOffset") ?? false
    }
}

// TODO: onBeginBatchEdit
// TODO: onCheckIsTextEditor
// TODO: onCommitCompletion
// TODO: onCommitCorrection
// TODO: onCreateInputConnection
// TODO: onCreateViewTranslationRequest
// TODO: onDragEvent
// TODO: onEditorAction
// TODO: onEndBatchEdit
// TODO: onGenericMotionEvent
// TODO: onKeyDown
// TODO: onKeyMultiple
// TODO: onKeyPreIme
// TODO: onKeyShortcut
// TODO: onKeyUp
// TODO: onPreDraw
// TODO: onPrivateIMECommand
// TODO: onReceiveContent
// TODO: onResolvePointerIcon
// TODO: onRestoreInstanceState
// TODO: onRtlPropertiesChanged
// TODO: onSaveInstanceState
// TODO: onScreenStateChanged
// TODO: onTextContextMenuItem
// TODO: onTouchEvent
// TODO: onTrackballEvent
// TODO: onVisibilityAggregated
// TODO: onWindowFocusChanged

// MARK: PerformLongClick

extension TextView {
    /// Calls this view's OnLongClickListener, if it is defined.
    /// 
    /// Invokes the context menu if the OnLongClickListener did not consume the event.
    @discardableResult
    public func performLongClick() -> Bool {
        instance?.callBoolMethod(name: "performLongClick") ?? false
    }
}

// MARK: RemoveTextChangedListener

// extension TextView {
//     /// Removes the specified TextWatcher from the list of those
//     /// whose methods are called whenever this TextView's text changes.
//     public func removeTextChangedListener(_ watcher: NativeTextWatcher) {
//         guard let watcherObject = watcher.instance?.object else { return }
//         instance?.callVoidMethod(name: "removeTextChangedListener", args: watcherObject.signed(as: NativeTextWatcher.originalClassName))
//     }
// } // TODO: make NativeTextWatcher public?

// MARK: SendAccessibilityEventUnchecked

// extension TextView {
//     /// This method behaves exactly as sendAccessibilityEvent(int) but takes as an argument an empty AccessibilityEvent and does not perform a check whether accessibility is enabled.
//     ///
//     /// If an AccessibilityDelegate has been specified via calling setAccessibilityDelegate(android.view.View.AccessibilityDelegate) its AccessibilityDelegate.sendAccessibilityEventUnchecked(View, AccessibilityEvent) is responsible for handling this call.
//     public func sendAccessibilityEventUnchecked(_ event: AccessibilityEvent) {
//         instance?.callVoidMethod(name: "sendAccessibilityEventUnchecked", args: event.object.signed(as: AccessibilityEvent.className))
//     }
// } // TODO: implement AccessibilityEvent https://developer.android.com/reference/android/view/accessibility/AccessibilityEvent

// MARK: SetAllCaps

private struct AllCapsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setAllCaps"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets the properties of this field to transform input to ALL CAPS display.
    /// 
    /// This may use a "small caps" formatting if available.
    /// This setting will be ignored if this field is editable or selectable.
    /// This call replaces the current transformation method.
    /// Disabling this will not necessarily restore the previous behavior from before this was enabled.
    public func setAllCaps(_ value: Bool = true) -> Self {
        AllCapsViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetAutoLinkMask

private struct AutoLinkMaskViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setAutoLinkMask"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the autolink mask of the text.
    /// 
    /// See Linkify.ALL and peers for possible values.
    public func autoLinkMask(_ mask: Int) -> Self {
        AutoLinkMaskViewProperty(value: mask).applyOrAppend(nil, self)
    }
}

// MARK: SetAutoSizeTextTypeUniformWithConfiguration

private struct AutoSizeTextTypeUniformViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setAutoSizeTextTypeUniformWithConfiguration"
    let value: (Int, Int, Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value.0), Int32(value.1), Int32(value.2), value.3.rawValue)
    }
}
extension TextView {
    /// Specify whether this widget should automatically scale the text to try to perfectly fit within the layout bounds.
    /// 
    /// If all the configuration params are valid the type of auto-size is set to `AUTO_SIZE_TEXT_TYPE_UNIFORM`.
    /// 
    /// Parameters:
    /// - autoSizeMinTextSize: The minimum text size in pixels
    /// - autoSizeMaxTextSize: The maximum text size in pixels
    /// - autoSizeStepGranularity: The step size in pixels
    /// - unit: The unit of the parameters. One of COMPLEX_UNIT_*
    public func autoSizeTextTypeUniform(minTextSize: Int, maxTextSize: Int, stepGranularity: Int, unit: DimensionUnit = .px) -> Self {
        AutoSizeTextTypeUniformViewProperty(value: (minTextSize, maxTextSize, stepGranularity, unit)).applyOrAppend(nil, self)
    }
}

// MARK: SetAutoSizeTextTypeUniformWithPresetSizes

// extension TextView {
//     /// Specify whether this widget should automatically scale the text to try to perfectly fit within the layout bounds.
//     /// 
//     /// If at least one value from the presetSizes is valid then the type of auto-size is set to `AUTO_SIZE_TEXT_TYPE_UNIFORM`.
//     /// 
//     /// Parameters:
//     /// - presetSizes: The array of preset sizes in pixels
//     /// - unit: The unit of the parameters. One of COMPLEX_UNIT_*
//     public func autoSizeTextTypeUniform(presetSizes: [Int], unit: DimensionUnit = .px) -> Self {
//         guard
//             let env = JEnv.current(),
//             let arrayClazz = JClass.load(),
//             let arrayObject = JIntArray(env, presetSizes.map { Int32($0) }).object
//         else { return }
//         instance?.callVoidMethod(name: "setAutoSizeTextTypeUniformWithPresetSizes", args: arrayObject.signed(as: arrayClazz), unit.rawValue)
//     } // TODO: array of Int32
// }

// MARK: SetAutoSizeTextTypeWithDefaults

private struct AutoSizeTextTypeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setAutoSizeTextTypeWithDefaults"
    let value: TextView.AutoSizeTextType
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Specify whether this widget should automatically scale the text to try to perfectly fit within the layout bounds by using the default auto-size configuration.
    public func autoSizeTextType(_ autoSizeTextType: AutoSizeTextType) -> Self {
        AutoSizeTextTypeViewProperty(value: autoSizeTextType).applyOrAppend(nil, self)
    }
}

// MARK: SetBreakStrategy

private struct BreakStrategyViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setBreakStrategy"
    let value: LineBreakStyle
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Sets the break strategy for breaking paragraphs into lines.
    /// The default value for TextView is `.highQuality`, and the default value for EditText is `.simple`, the latter to avoid the text "dancing" when being edited.
    ///
    /// Enabling hyphenation with either using `.normal` or `.full` while line breaking is set to one of `.balanced`, `.highQuality`
    /// improves the structure of text layout however has performance impact and requires more time to do the text layout.
    ///
    /// Compared with setLineBreakStyle(int), line break style with different strictness is evaluated in the ICU to identify the potential breakpoints.
    /// In setBreakStrategy(int), line break strategy handles the post processing of ICU's line break result. It aims to evaluate ICU's breakpoints and break the lines based on the constraint.
    public func breakStrategy(_ breakStrategy: LineBreakStyle) -> Self {
        BreakStrategyViewProperty(value: breakStrategy).applyOrAppend(nil, self)
    }
}

// MARK: SetCompoundDrawablePadding

private struct CompoundDrawablePaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompoundDrawablePadding"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension TextView {
    /// Sets the size of the padding between the compound drawables and the text.
    public func compoundDrawablePadding(_ pad: Int, _ dimension: DimensionUnit = .dp) -> Self {
        CompoundDrawablePaddingViewProperty(value: (pad, dimension)).applyOrAppend(nil, self)
    }
}

// MARK: SetCompoundDrawableTintBlendMode

// extension TextView {
//     /// Specifies the blending mode used to apply the tint specified by setCompoundDrawableTintList(android.content.res.ColorStateList) to the compound drawables.
//     /// 
//     /// The default mode is PorterDuff.Mode.SRC_IN.
//     public func setCompoundDrawableTintBlendMode(_ blendMode: BlendMode) -> Self {
//         instance?.callVoidMethod(name: "setCompoundDrawableTintBlendMode", args: blendMode.rawValue)
//     }
// } // TODO: implement BlendMode https://developer.android.com/reference/android/graphics/BlendMode

// MARK: SetCompoundDrawableTintList

// extension TextView {
//     /// Specifies a tint to apply to the compound drawables.
//     /// 
//     /// By default no tint is applied.
//     public func compoundDrawableTintList(_ tint: ColorStateList) -> Self {
//         let arg: JObject? = tint != nil ? ColorStateList.valueOf(tint!)?.object : nil
//         instance?.callVoidMethod(name: "setCompoundDrawableTintList", args: arg?.signed(as: ColorStateList.className))
//     }
// } // TODO: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList

// MARK: SetCompoundDrawableTintMode

// extension TextView {
//     /// Specifies the blending mode used to apply the tint specified by setCompoundDrawableTintList(android.content.res.ColorStateList) to the compound drawables.
//     /// 
//     /// The default mode is PorterDuff.Mode.SRC_IN.
//     public func compoundDrawableTintMode(_ tintMode: PorterDuff.Mode) -> Self {
//         instance?.callVoidMethod(name: "setCompoundDrawableTintMode", args: tintMode.rawValue)
//     } // TODO: implement PorterDuff.Mode https://developer.android.com/reference/android/graphics/PorterDuff.Mode
// }

// MARK: SetCompoundDrawables

private struct CompoundDrawablesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompoundDrawables"
    let value: (Drawable?, Drawable?, Drawable?, Drawable?)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(
            env,
            name: key.rawValue,
            args:
                value.0.signed(as: Drawable.className),
                value.1.signed(as: Drawable.className),
                value.2.signed(as: Drawable.className),
                value.3.signed(as: Drawable.className)
        )
    }
}
extension TextView {
    /// Sets the Drawables (if any) to appear to the left of, above, to the right of, and below the text.
    /// Use null if you do not want a Drawable there.
    /// The Drawables must already have had Drawable.setBounds called.
    ///
    /// Calling this method will overwrite any Drawables previously set using setCompoundDrawablesRelative(Drawable, Drawable, Drawable, Drawable) or related methods.
    public func compoundDrawables(left: Drawable?, top: Drawable?, right: Drawable?, bottom: Drawable?) -> Self {
        CompoundDrawablesViewProperty(value: (left, top, right, bottom)).applyOrAppend(nil, self)
    }
}

// MARK: SetCompoundDrawablesRelative

private struct CompoundDrawablesRelativeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompoundDrawablesRelative"
    let value: (Drawable?, Drawable?, Drawable?, Drawable?)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(
            env,
            name: key.rawValue,
            args:
                value.0.signed(as: Drawable.className),
                value.1.signed(as: Drawable.className),
                value.2.signed(as: Drawable.className),
                value.3.signed(as: Drawable.className)
        )
    }
}
extension TextView {
    /// Sets the Drawables (if any) to appear to the start of, above, to the end of, and below the text. Use null if you do not want a Drawable there.
    /// The Drawables must already have had Drawable.setBounds called.
    ///
    /// Calling this method will overwrite any Drawables previously set using setCompoundDrawables(Drawable, Drawable, Drawable, Drawable) or related methods.
    public func compoundDrawablesRelative(start: Drawable?, top: Drawable?, end: Drawable?, bottom: Drawable?) -> Self {
        CompoundDrawablesRelativeViewProperty(value: (start, top, end, bottom)).applyOrAppend(nil, self)
    }
}

// MARK: SetCompoundDrawablesRelativeWithIntrinsicBounds

private struct CompoundDrawablesRelativeWithIntrinsicBoundsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCompoundDrawablesRelativeWithIntrinsicBounds"
    enum Values {
        case drawables(Drawable?, Drawable?, Drawable?, Drawable?)
        case resourceIds(Int32, Int32, Int32, Int32)
    }
    let value: Values
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
            case .drawables(let start, let top, let end, let bottom):
                instance.callVoidMethod(
                    env,
                    name: key.rawValue,
                    args:
                        start.signed(as: Drawable.className),
                        top.signed(as: Drawable.className),
                        end.signed(as: Drawable.className),
                        bottom.signed(as: Drawable.className)
                )
            case .resourceIds(let startId, let topId, let endId, let bottomId):
                instance.callVoidMethod(
                    env,
                    name: key.rawValue,
                    args:
                        startId,
                        topId,
                        endId,
                        bottomId
                )
        }
    }
}
extension TextView {
    /// Sets the Drawables (if any) to appear to the start of, above, to the end of, and below the text. Use null if you do not want a Drawable there.
    /// The Drawables will have had their bounds set to their intrinsic bounds.
    ///
    /// Calling this method will overwrite any Drawables previously set using setCompoundDrawables(Drawable, Drawable, Drawable, Drawable) or related methods.
    public func compoundDrawablesRelativeWithIntrinsicBounds(start: Drawable?, top: Drawable?, end: Drawable?, bottom: Drawable?) -> Self {
        CompoundDrawablesRelativeWithIntrinsicBoundsViewProperty(value: .drawables(start, top, end, bottom)).applyOrAppend(nil, self)
    }
}

// MARK: SetCompoundDrawablesRelativeWithIntrinsicBounds

extension TextView {
    /// Sets the Drawables (if any) to appear to the start of, above, to the end of, and below the text. Use 0 if you do not want a Drawable there.
    /// The Drawables will have had their bounds set to their intrinsic bounds.
    ///
    /// Calling this method will overwrite any Drawables previously set using setCompoundDrawables(Drawable, Drawable, Drawable, Drawable) or related methods.
    /// 
    /// Parameters:
    /// - start: Resource identifier of the drawable to be drawn to the start of the text
    /// - top: Resource identifier of the drawable to be drawn above the text
    /// - end: Resource identifier of the drawable to be drawn to the end of the text
    /// - bottom: Resource identifier of the drawable to be drawn below the text
    public func compoundDrawablesRelativeWithIntrinsicBounds(start: Int32, top: Int32, end: Int32, bottom: Int32) -> Self {
        CompoundDrawablesRelativeWithIntrinsicBoundsViewProperty(value: .resourceIds(start, top, end, bottom)).applyOrAppend(nil, self)
    }
}

// MARK: SetCursorVisible

private struct CursorVisibleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setCursorVisible"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set whether the cursor is visible. The default is true.
    /// 
    /// Note that this property only makes sense for editable TextView.
    /// 
    /// If IME is consuming the input, the cursor will always be invisible, visibility will be updated as the last state when IME does not consume the input anymore.
    public func cursorVisible(_ visible: Bool = true) -> Self {
        CursorVisibleViewProperty(value: visible).applyOrAppend(nil, self)
    }
}

// TODO: setCustomInsertionActionModeCallback: implement ActionMode.Callback https://developer.android.com/reference/android/view/ActionMode.Callback
// TODO: setCustomSelectionActionModeCallback: implement ActionMode.Callback https://developer.android.com/reference/android/view/ActionMode.Callback
// TODO: setEditableFactory: implement Editable.Factory https://developer.android.com/reference/android/text/Editable.Factory

// MARK: SetElegantTextHeight

private struct ElegantTextHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setElegantTextHeight"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set the TextView's elegant height metrics flag.
    /// This setting selects font variants that have not been compacted to fit Latin-based vertical metrics, and also increases top and bottom bounds to provide more space.
    public func elegantTextHeight(_ elegant: Bool = true) -> Self {
        ElegantTextHeightViewProperty(value: elegant).applyOrAppend(nil, self)
    }
}

// TODO: setEllipsize: implement TextUtils.TruncateAt https://developer.android.com/reference/android/text/TextUtils.TruncateAt

// MARK: SetEms

private struct EmsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setEms"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the width of the TextView to be exactly ems wide.
    /// 
    /// This value is used for width calculation if LayoutParams does not force TextView to have an exact width.
    /// 
    /// Setting this value overrides previous minimum/maximum configurations such as `setMinEms(int)` or `setMaxEms(int)`.
    public func ems(_ ems: Int) -> Self {
        EmsViewProperty(value: ems).applyOrAppend(nil, self)
    }
}

// MARK: SetError

private struct ErrorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setError"
    let value: (String, Drawable?)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard let str = JString(from: value.0) else { return }
        if let drawable = value.1 {
            instance.callVoidMethod(
                env,
                name: key.rawValue,
                args:
                    str.signedAsCharSequence(),
                    drawable.signed(as: Drawable.className)
            )
        } else {
            instance.callVoidMethod(
                env,
                name: key.rawValue,
                args:
                    str.signedAsCharSequence()
            )
        }
    }
}
extension TextView {
    /// Sets the right-hand compound drawable of the TextView to the specified icon and sets an error message that will be displayed in a popup when the TextView has focus.
    /// 
    /// The icon and error message will be reset to null when any key events cause changes to the TextView's text.
    /// The drawable must already have had Drawable.setBounds set on it. If the error is null, the error message will be cleared (and you should provide a null icon as well).
    public func error(_ error: String, icon: Drawable? = nil) -> Self {
        ErrorViewProperty(value: (error, icon)).applyOrAppend(nil, self)
    }
}

// MARK: SetExtractedText

// private struct ExtractedTextViewProperty: ViewPropertyToApply {
//     let key: ViewPropertyKey = "setExtractedText"
//     let value: ExtractedText
//     func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
//         instance.callVoidMethod(env, name: key.rawValue, args: value.object.signed(as: ExtractedText.className))
//     }
// }
// extension TextView {
//     /// Apply to this text view the given extracted text, as previously returned by extractText(android.view.inputmethod.ExtractedTextRequest, android.view.inputmethod.ExtractedText).
//     public func extractedText(_ text: ExtractedText) -> Self {
//         ExtractedTextViewProperty(value: text).applyOrAppend(nil, self)
//     }
// } // TODO: implement ExtractedText https://developer.android.com/reference/android/view/inputmethod/ExtractedText

// MARK: SetFallbackLineSpacing

private struct FallbackLineSpacingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFallbackLineSpacing"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set whether to respect the ascent and descent of the fallback fonts that are used in displaying the text (which is needed to avoid text from consecutive lines running into each other).
    /// If set, fallback fonts that end up getting used can increase the ascent and descent of the lines that they are used on.
    ///
    /// It is required to be true if text could be in languages like Burmese or Tibetan where text is typically much taller or deeper than Latin text.
    public func fallbackLineSpacing(_ enabled: Bool = true) -> Self {
        FallbackLineSpacingViewProperty(value: enabled).applyOrAppend(nil, self)
    }
}

// TODO: implement setFilters: implement InputFilter https://developer.android.com/reference/android/text/InputFilter

// MARK: SetFirstBaselineToTopHeight

private struct FirstBaselineToTopHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFirstBaselineToTopHeight"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension TextView {
    /// Updates the top padding of the TextView so that firstBaselineToTopHeight is the distance between the top of the TextView and first line's baseline.
    ///
    /// **Note** that if FontMetrics.top or FontMetrics.ascent was already greater than firstBaselineToTopHeight, the top padding is not updated.
    /// Moreover since this function sets the top padding, if the height of the TextView is less than the sum of top padding, line height and bottom padding, top of the line will be pushed down and bottom will be clipped.
    public func firstBaselineToTopHeight(_ firstBaselineToTopHeight: Int, _ dimension: DimensionUnit = .dp) -> Self {
        FirstBaselineToTopHeightViewProperty(value: (firstBaselineToTopHeight, dimension)).applyOrAppend(nil, self)
    }
}

// MARK: SetFocusedSearchResultHighlightColor

private struct FocusedSearchResultHighlightColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFocusedSearchResultHighlightColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets focused search result highlight color.
    public func focusedSearchResultHighlightColor(_ color: GraphicsColor) -> Self {
        FocusedSearchResultHighlightColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// MARK: SetFocusedSearchResultIndex

private struct FocusedSearchResultIndexViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFocusedSearchResultIndex"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the index of the focused search result.
    /// 
    /// The index is 0 based and should be between 0 and getSearchResultsCount() - 1.
    /// If there are no search results, the index should be -1.
    public func focusedSearchResultIndex(_ index: Int) -> Self {
        FocusedSearchResultIndexViewProperty(value: index).applyOrAppend(nil, self)
    }
}

// MARK: SetFontFeatureSettings

private struct FontFeatureSettingsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFontFeatureSettings"
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard let str = JString(from: value) else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: str.signedAsString())
    }
}
extension TextView {
    /// Sets font feature settings.
    /// 
    /// The format is the same as the CSS font-feature-settings attribute: https://www.w3.org/TR/css-fonts-3/#font-feature-settings-prop
    public func fontFeatureSettings(_ settings: String) -> Self {
        FontFeatureSettingsViewProperty(value: settings).applyOrAppend(nil, self)
    }
}

// MARK: SetFontVariationSettings

extension TextView {
    /// Sets TrueType or OpenType font variation settings.
    /// 
    /// The settings string is constructed from multiple pairs of axis tag and style values.
    /// The axis tag must contain four ASCII characters and must be wrapped with single quotes (U+0027) or double quotes (U+0022).
    /// Axis strings that are longer or shorter than four characters, or contain characters outside of U+0020..U+007E are invalid.
    /// If a specified axis name is not defined in the font, the settings will be ignored.
    ///
    /// Returns true if the given settings is effective to at least one font file underlying this TextView.
    /// This function also returns true for empty settings string. Otherwise returns false.
    public func fontVariationSettings(_ settings: String) -> Bool {
        guard let str = JString(from: settings) else { return false }
        return instance?.callBoolMethod(name: "setFontVariationSettings", args: str.signedAsString()) ?? false
    }
}

// MARK: SetFreezesText

private struct FreezesTextViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setFreezesText"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Control whether this text view saves its entire text contents when freezing to an icicle, in addition to dynamic state such as cursor position.
    /// 
    /// By default this is false, not saving the text.
    /// 
    /// Set to true if the text in the text view is not being saved somewhere else in persistent storage (such as in a content provider) so that if the view is later thawed the user will not lose their data.
    /// For EditText it is always enabled, regardless of the value of the attribute.
    public func freezesText(_ freezes: Bool = true) -> Self {
        FreezesTextViewProperty(value: freezes).applyOrAppend(nil, self)
    }
}

// MARK: SetGravity

extension TextView {
    /// Sets the horizontal alignment of the text and the vertical gravity that will be used when there is extra space in the TextView beyond what is required for the text itself.
    public func gravity(_ gravity: Gravity) -> Self {
        GravityViewProperty(value: gravity).applyOrAppend(nil, self)
    }
}

// MARK: SetHighlightColor

private struct HighlightColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHighlightColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets the color used to display the selection highlight.
    public func highlightColor(_ color: GraphicsColor) -> Self {
        HighlightColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// TODO: setHighlights: implement Highlights https://developer.android.com/reference/android/text/Highlights

// MARK: SetHint

private struct HintViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHint"
    enum Value {
        case string(String)
        case resourceId(Int32)
    }
    let value: Value
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
        case .string(let str):
            guard let str = JString(from: str) else { return }
            instance.callVoidMethod(env, name: key.rawValue, args: str.signedAsCharSequence())
        case .resourceId(let id):
            instance.callVoidMethod(env, name: key.rawValue, args: id)
        }
    }
}
extension TextView {
    /// Sets the text to be displayed when the text of the TextView is empty.
    /// Null means to use the normal empty text.
    /// The hint does not currently participate in determining the size of the view.
    public func hint(_ hint: String) -> Self {
        HintViewProperty(value: .string(hint)).applyOrAppend(nil, self)
    }

    /// Sets the text to be displayed when the text of the TextView is empty, from a resource.
    public func hint(resourceId: Int32) -> Self {
        HintViewProperty(value: .resourceId(resourceId)).applyOrAppend(nil, self)
    }
}

// TODO: setHintTextColor: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList

// MARK: SetHintTextColor

private struct HintTextColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHintTextColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets the color of the hint text for all the states (disabled, focussed, selected...) of this TextView.
    public func hintTextColor(_ color: GraphicsColor) -> Self {
        HintTextColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// MARK: SetHorizontallyScrolling

private struct HorizontallyScrollingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHorizontallyScrolling"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets whether the text should be allowed to be wider than the View is.
    /// 
    /// If false, it will be wrapped to the width of the View.
    public func horizontallyScrolling(_ whether: Bool = true) -> Self {
        HorizontallyScrollingViewProperty(value: whether).applyOrAppend(nil, self)
    }
}

// MARK: SetHyphenationFrequency

private struct HyphenationFrequencyViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setHyphenationFrequency"
    let value: HyphenationFrequency
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Sets the frequency of automatic hyphenation to use when determining word breaks.
    /// The default value for both TextView and EditText is Layout.HYPHENATION_FREQUENCY_NONE. Note that the default hyphenation frequency value is set from the theme.
    ///
    /// Enabling hyphenation with either using Layout.HYPHENATION_FREQUENCY_NORMAL or Layout.HYPHENATION_FREQUENCY_FULL
    /// while line breaking is set to one of Layout.BREAK_STRATEGY_BALANCED, Layout.BREAK_STRATEGY_HIGH_QUALITY improves the structure of text layout
    /// however has performance impact and requires more time to do the text layout.
    /// 
    /// **Note**: Before Android Q, in the theme hyphenation frequency is set to Layout.HYPHENATION_FREQUENCY_NORMAL.
    /// The default value is changed into Layout.HYPHENATION_FREQUENCY_NONE on Q.
    public func hyphenationFrequency(_ hyphenationFrequency: HyphenationFrequency) -> Self {
        HyphenationFrequencyViewProperty(value: hyphenationFrequency).applyOrAppend(nil, self)
    }
}

// MARK: SetImeActionLabel

private struct ImeActionLabelViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setImeActionLabel"
    let value: (String, Int)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard let str = JString(from: value.0) else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: str.signedAsCharSequence(), Int32(value.1))
    }
}
extension TextView {
    /// Change the custom IME action associated with the text view, which will be reported to an IME with EditorInfo.actionLabel and EditorInfo.actionId when it has focus.
    public func imeActionLabel(_ label: String, actionId: Int) -> Self {
        ImeActionLabelViewProperty(value: (label, actionId)).applyOrAppend(nil, self)
    }
}

// TODO: setImeHintLocales: implement LocaleList https://developer.android.com/reference/android/os/LocaleList

// MARK: SetImeOptions

private struct ImeOptionsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setImeOptions"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Change the editor type integer associated with the text view, which is reported to an Input Method Editor (IME) with EditorInfo.imeOptions when it has focus.
    public func imeOptions(_ options: Int) -> Self {
        ImeOptionsViewProperty(value: options).applyOrAppend(nil, self)
    }
}

// MARK: SetIncludeFontPadding

private struct IncludeFontPaddingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setIncludeFontPadding"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set whether the TextView includes extra top and bottom padding to make room for accents that go above the normal ascent and descent.
    /// 
    /// The default is true.
    public func includeFontPadding(_ includs: Bool = true) -> Self {
        IncludeFontPaddingViewProperty(value: includs).applyOrAppend(nil, self)
    }
}

// MARK: SetInputExtras

private struct InputExtrasViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setInputExtras"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set the extra input data of the text, which is the TextBoxAttribute.extras Bundle that will be filled in when creating an input connection.
    /// 
    /// The given integer is the resource identifier of an XML resource holding an <input-extras> XML tree.
    public func inputExtras(resourceId: Int32) -> Self {
        InputExtrasViewProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// MARK: SetInputType

private struct InputTypeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setInputType"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Set the type of the content with a constant as defined for EditorInfo.inputType.
    /// 
    /// This will take care of changing the key listener, by calling setKeyListener(android.text.method.KeyListener), to match the given content type.
    /// 
    /// If the given content type is EditorInfo.TYPE_NULL then a soft keyboard will not be displayed for this text view. Note that the maximum number of displayed lines (see setMaxLines(int)) will be modified if you change the EditorInfo.TYPE_TEXT_FLAG_MULTI_LINE flag of the input type.
    public func inputType(_ type: Int) -> Self {
        InputTypeViewProperty(value: type).applyOrAppend(nil, self)
    }
}

// MARK: SetJustificationMode

private struct JustificationModeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setJustificationMode"
    let value: JustificationMode
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Sets the justification mode for text.
    /// 
    /// The default value is `.none`.
    public func justificationMode(_ justificationMode: JustificationMode) -> Self {
        JustificationModeViewProperty(value: justificationMode).applyOrAppend(nil, self)
    }
}

// TODO: setKeyListener: implement KeyListener https://developer.android.com/reference/android/text/method/KeyListener

// MARK: SetLastBaselineToBottomHeight

private struct LastBaselineToBottomHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLastBaselineToBottomHeight"
    let value: (Int, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.toPixels(Int32(value.0)))
    }
}
extension TextView {
    /// Updates the bottom padding of the TextView so that lastBaselineToBottomHeight is the distance between the bottom of the TextView and the last line's baseline.
    ///
    /// **Note** that if FontMetrics.bottom or FontMetrics.descent was already greater than lastBaselineToBottomHeight, the bottom padding is not updated.
    /// Moreover since this function sets the bottom padding, if the height of the TextView is less than the sum of top padding, line height and bottom padding, bottom of the text will be clipped.
    public func lastBaselineToBottomHeight(_ lastBaselineToBottomHeight: Int, _ dimension: DimensionUnit = .dp) -> Self {
        LastBaselineToBottomHeightViewProperty(value: (lastBaselineToBottomHeight, dimension)).applyOrAppend(nil, self)
    }
}

// MARK: SetLetterSpacing

private struct LetterSpacingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLetterSpacing"
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets text letter-spacing in em units.
    /// 
    /// Typical values for slight expansion will be around 0.05. Negative values tighten text.
    public func letterSpacing(_ letterSpacing: Float) -> Self {
        LetterSpacingViewProperty(value: letterSpacing).applyOrAppend(nil, self)
    }
}

// MARK: SetLineBreakStyle

private struct LineBreakStyleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLineBreakStyle"
    let value: LineBreakStyle
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Sets the line-break style for text wrapping.
    ///
    /// Line-break style specifies the line-break strategies that can be used for text wrapping.
    /// The line-break style affects rule-based line breaking by specifying the strictness of line-breaking rules.
    ///
    /// The default line-break style is `.none`, which specifies that no line-breaking rules are used.
    public func lineBreakStyle(_ lineBreakStyle: LineBreakStyle) -> Self {
        LineBreakStyleViewProperty(value: lineBreakStyle).applyOrAppend(nil, self)
    }
}

// MARK: SetLineBreakWordStyle

private struct LineBreakWordStyleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLineBreakWordStyle"
    let value: LineBreakWordStyle
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.rawValue)
    }
}
extension TextView {
    /// Sets the line-break word style for text wrapping.
    ///
    /// The line-break word style affects dictionary-based line breaking by providing phrase-based line-breaking opportunities.
    /// Use `.phrase` to specify phrase-based line breaking.
    ///
    /// The default line-break word style is `.none`, which specifies that no line-breaking word style is used.
    public func lineBreakWordStyle(_ lineBreakWordStyle: LineBreakWordStyle) -> Self {
        LineBreakWordStyleViewProperty(value: lineBreakWordStyle).applyOrAppend(nil, self)
    }
}

// MARK: SetLineHeight

private struct LineHeightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLineHeight"
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.rawValue, value.0)
    }
}
extension TextView {
    /// Sets an explicit line height to a given unit and value for this TextView.
    /// 
    /// This is equivalent to the vertical distance between subsequent baselines in the TextView.
    public func lineHeight(_ lineHeight: Float, _ dimension: DimensionUnit = .dp) -> Self {
        LineHeightViewProperty(value: (lineHeight, dimension)).applyOrAppend(nil, self)
    }
}

// MARK: SetLineSpacing

private struct LineSpacingViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLineSpacing"
    let value: (Float, Float)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.0, value.1)
    }
}
extension TextView {
    /// Sets the line spacing for this TextView, in pixels.
    /// 
    /// The value is added to the default line spacing of the Paint.
    /// 
    /// The value is multiplied by the value of `setLineSpacingMultiplier(float)` before being added to the default line spacing.
    public func lineSpacing(add: Float, multiplier: Float = 1.0) -> Self {
        LineSpacingViewProperty(value: (add, multiplier)).applyOrAppend(nil, self)
    }
}

// MARK: SetLines

private struct LinesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLines"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the height of the TextView to be exactly lines tall.
    ///
    /// This value is used for height calculation if LayoutParams does not force TextView to have an exact height.
    /// Setting this value overrides previous minimum/maximum height configurations such as setMinLines(int) or setMaxLines(int). setSingleLine() will set this value to 1.
    public func lines(_ lines: Int) -> Self {
        LinesViewProperty(value: lines).applyOrAppend(nil, self)
    }
}

// MARK: SetLinkTextColor

// TODO: setLinkTextColor: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList

private struct LinkTextColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLinkTextColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets the color of links in the text.
    public func linkTextColor(_ color: GraphicsColor) -> Self {
        LinkTextColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// MARK: SetLinksClickable

private struct LinksClickableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLinksClickable"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets whether the movement method will automatically be set to LinkMovementMethod if setAutoLinkMask(int) has been set to nonzero and links are detected in setText(char, int, int).
    /// 
    /// The default is true.
    public func linksClickable(_ value: Bool = true) -> Self {
        LinksClickableViewProperty(value: value).applyOrAppend(nil, self)
    }
}

// MARK: SetLocalePreferredLineHeightForMinimumUsed

private struct LocalePreferredLineHeightForMinimumUsedViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setLocalePreferredLineHeightForMinimumUsed"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set true if the locale preferred line height is used for the minimum line height.
    public func localePreferredLineHeightForMinimumUsed(_ enabled: Bool = true) -> Self {
        LocalePreferredLineHeightForMinimumUsedViewProperty(value: enabled).applyOrAppend(nil, self)
    }
}

// MARK: SetMarqueeRepeatLimit

private struct MarqueeRepeatLimitViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMarqueeRepeatLimit"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets how many times to repeat the marquee animation.
    /// Only applied if the TextView has marquee enabled.
    /// Set to -1 to repeat indefinitely.
    public func marqueeRepeatLimit(_ limit: Int) -> Self {
        MarqueeRepeatLimitViewProperty(value: limit).applyOrAppend(nil, self)
    }
}

// MARK: SetMaxEms

private struct MaxEmsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMaxEms"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the width of the TextView to be at most maxEms wide.
    public func maxEms(_ maxEms: Int) -> Self {
        MaxEmsViewProperty(value: maxEms).applyOrAppend(nil, self)
    }
}

// MARK: SetMaxLines

private struct MaxLinesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMaxLines"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the maximum number of lines displayed in the TextView.
    /// 
    /// This value is used for height calculation if LayoutParams does not force TextView to have an exact height.
    public func maxLines(_ maxLines: Int) -> Self {
        MaxLinesViewProperty(value: maxLines).applyOrAppend(nil, self)
    }
}

// MARK: SetMinEms

private struct MinEmsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMinEms"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the width of the TextView to be at least minEms wide.
    ///
    /// This value is used for width calculation if LayoutParams does not force TextView to have an exact width.
    public func minEms(_ minEms: Int) -> Self {
        MinEmsViewProperty(value: minEms).applyOrAppend(nil, self)
    }
}

// MARK: SetMinLines

private struct MinLinesViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setMinLines"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets the minimum number of lines displayed in the TextView.
    /// 
    /// This value is used for height calculation if LayoutParams does not force TextView to have an exact height.
    public func minLines(_ minLines: Int) -> Self {
        MinLinesViewProperty(value: minLines).applyOrAppend(nil, self)
    }
}

// TODO: setMinimumFontMetrics: implement FontMetrics https://developer.android.com/reference/android/graphics/Paint.FontMetrics

// TODO: setMovementMethod: implement MovementMethod https://developer.android.com/reference/android/text/method/MovementMethod

// TODO: setOnEditorActionListener: implement OnEditorActionListener https://developer.android.com/reference/android/widget/TextView.OnEditorActionListener

// MARK: SetPaintFlags

private struct PaintFlagsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setPaintFlags"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Sets flags on the Paint being used to display the text and reflows the text if they are different from the old flags.
    public func paintFlags(_ flags: Int) -> Self {
        PaintFlagsViewProperty(value: flags).applyOrAppend(nil, self)
    }
}

// MARK: SetPrivateImeOptions

private struct PrivateImeOptionsViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setPrivateImeOptions"
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard let str = JString(from: value) else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: str.signedAsString())
    }
}
extension TextView {
    /// Set the private content type of the text, which is the EditorInfo.privateImeOptions field that will be filled in when creating an input connection.
    public func privateImeOptions(_ options: String) -> Self {
        PrivateImeOptionsViewProperty(value: options).applyOrAppend(nil, self)
    }
}

// MARK: SetRawInputType

private struct RawInputTypeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setRawInputType"
    let value: Int
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: Int32(value))
    }
}
extension TextView {
    /// Directly change the content type integer of the text view, without modifying any other state.
    public func rawInputType(_ type: Int) -> Self {
        RawInputTypeViewProperty(value: type).applyOrAppend(nil, self)
    }
}

// MARK: SetScroller

// TODO: setScroller: implement Scroller https://developer.android.com/reference/android/widget/Scroller

// MARK: SetSearchResultHighlightColor

private struct SearchResultHighlightColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSearchResultHighlightColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets the search result highlight color.
    public func searchResultHighlightColor(_ color: GraphicsColor) -> Self {
        SearchResultHighlightColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// TODO: setSearchResultHighlights

// MARK: SetSelectAllOnFocus

private struct SelectAllOnFocusViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSelectAllOnFocus"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set the TextView so that when it takes focus, all the text is selected.
    public func selectAllOnFocus(_ selectAll: Bool = true) -> Self {
        SelectAllOnFocusViewProperty(value: selectAll).applyOrAppend(nil, self)
    }
}

// MARK: SetShadowLayer

private struct ShadowLayerViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setShadowLayer"
    let value: (Float, Float, Float, GraphicsColor)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.0, value.1, value.2, value.3.value)
    }
}
extension TextView {
    /// Gives the text a shadow of the specified blur radius and color, the specified distance from its drawn position.
    ///
    /// The text shadow produced does not interact with the properties on view that are responsible for real time shadows, elevation and translationZ.
    public func shadowLayer(radius: Float, dx: Float, dy: Float, color: GraphicsColor) -> Self {
        ShadowLayerViewProperty(value: (radius, dx, dy, color)).applyOrAppend(nil, self)
    }
}

// MARK: SetShiftDrawingOffsetForStartOverhang

private struct ShiftDrawingOffsetForStartOverhangViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setShiftDrawingOffsetForStartOverhang"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set true for shifting the drawing x offset for showing overhang at the start position.
    public func shiftDrawingOffsetForStartOverhang(_ enabled: Bool = true) -> Self {
        ShiftDrawingOffsetForStartOverhangViewProperty(value: enabled).applyOrAppend(nil, self)
    }
}

// MARK: SetShowSoftInputOnFocus

private struct ShowSoftInputOnFocusViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setShowSoftInputOnFocus"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Control whether the IME will be made visible when the TextView gets focused.
    /// 
    /// The default is true.
    public func showSoftInputOnFocus(_ show: Bool = true) -> Self {
        ShowSoftInputOnFocusViewProperty(value: show).applyOrAppend(nil, self)
    }
}

// MARK: SetSingleLine

private struct SingleLineViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setSingleLine"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// If true, sets the properties of this field (number of lines, horizontally scrolling, transformation method) to be for a single-line input;
    /// 
    /// if false, restores these to the default conditions.
    /// 
    /// Note that the default conditions are not necessarily those that were in effect prior this method, and you may want to reset these properties to your custom values.
    /// 
    /// Note that due to performance reasons, by setting single line for the EditText, the maximum text length is set to 5000 if no other character limitation are applied.
    public func singleLine(_ singleLine: Bool = true) -> Self {
        SingleLineViewProperty(value: singleLine).applyOrAppend(nil, self)
    }
}

// TODO: setSpannableFactory: implement SpannableFactory https://developer.android.com/reference/android/text/SpannableFactory

// TODO: setText with arguments

// MARK: SetTextAppearance

private struct TextAppearanceViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextAppearance"
    let value: Int32
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets the text appearance from the specified style resource.
    public func textAppearance(resourceId: Int32) -> Self {
        TextAppearanceViewProperty(value: resourceId).applyOrAppend(nil, self)
    }
}

// TODO: setTextClassifier: implement TextClassifier https://developer.android.com/reference/android/view/textclassifier/TextClassifier

// MARK: SetTextColor

// TODO: setTextColor: implement ColorStateList https://developer.android.com/reference/android/content/res/ColorStateList
private struct TextColorListViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextColor"
    let value: ColorStateList
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.signed(as: ColorStateList.className))
    }
}
extension TextView {
    /// Sets the text color for all the states (normal, selected, focused) to be this color.
    public func textColor(_ colorStateList: ColorStateList) -> Self {
        TextColorListViewProperty(value: colorStateList).applyOrAppend(nil, self)
    }

    /// Sets the text color for all the states (normal, selected, focused) to be this color.
    public func textColor(_ colorStates: ColorStateListItem...) -> Self {
        TextColorListViewProperty(value: ColorStateList(colorStates)).applyOrAppend(nil, self)
    }
}

private struct TextColorViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextColor"
    let value: GraphicsColor
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.value)
    }
}
extension TextView {
    /// Sets the text color for all the states (normal, selected, focused) to be this color.
    public func textColor(_ color: GraphicsColor) -> Self {
        TextColorViewProperty(value: color).applyOrAppend(nil, self)
    }
}

// MARK: SetTextCursorDrawable

private struct TextCursorDrawableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextCursorDrawable"
    enum Value {
        case drawable(Drawable)
        case resourceId(Int32)
    }
    let value: Value
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
        case .drawable(let drawable):
            instance.callVoidMethod(env, name: key.rawValue, args: drawable.signed(as: Drawable.className))
        case .resourceId(let id):
            instance.callVoidMethod(env, name: key.rawValue, args: id)
        }
    }
}
extension TextView {
    /// Sets the drawable to be used to draw the cursor.
    public func textCursorDrawable(_ drawable: Drawable) -> Self {
        TextCursorDrawableViewProperty(value: .drawable(drawable)).applyOrAppend(nil, self)
    }
    
    /// Sets the drawable to be used to draw the cursor from a resource.
    public func textCursorDrawable(resourceId: Int32) -> Self {
        TextCursorDrawableViewProperty(value: .resourceId(resourceId)).applyOrAppend(nil, self)
    }
}

// MARK: SetTextIsSelectable

private struct TextIsSelectableViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextIsSelectable"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets whether the content of this view is selectable by the user.
    /// The default is false, meaning that the content is not selectable.
    ///
    /// When you use a TextView to display a useful piece of information to the user (such as a contact's address), make it selectable,
    /// so that the user can select and copy its content.
    /// You can also use set the XML attribute R.styleable.TextView_textIsSelectable to "true".
    ///
    /// When you call this method to set the value of textIsSelectable, it sets the flags focusable, focusableInTouchMode, clickable, and longClickable to the same value.
    public func textIsSelectable(_ selectable: Bool = true) -> Self {
        TextIsSelectableViewProperty(value: selectable).applyOrAppend(nil, self)
    }
}

// MARK: SetTextKeepState

// TODO: setTextKeepState with BufferType https://developer.android.com/reference/android/text/Editable.Factory

private struct TextKeepStateViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextKeepState"
    let value: String
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        guard let str = JString(from: value) else { return }
        instance.callVoidMethod(env, name: key.rawValue, args: str.signedAsCharSequence())
    }
}
extension TextView {
    /// Sets the text to be displayed but retains the cursor position.
    /// Same as setText(java.lang.CharSequence) except that the cursor position (if any) is retained in the new text.
    ///
    /// When required, TextView will use Spannable.Factory to create final or intermediate Spannables.
    /// Likewise it will use Editable.Factory to create final or intermediate Editables.
    public func textKeepState(_ text: String) -> Self {
        TextKeepStateViewProperty(value: text).applyOrAppend(nil, self)
    }
}

// TODO: setTextLocale: implement Locale https://developer.android.com/reference/java/util/Locale

// TODO: setTextLocales: implement LocaleList https://developer.android.com/reference/android/os/LocaleList

// TODO: setTextMetricsParams: implement TextMetricsParams https://developer.android.com/reference/android/view/WindowManager.LayoutParams

// MARK: SetTextScaleX

private struct TextScaleXViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextScaleX"
    let value: Float
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Sets the horizontal scale factor for text.
    /// 
    /// The default value is 1.0.
    /// 
    /// Values greater than 1.0 stretch the text wider.
    /// Values less than 1.0 make the text narrower.
    /// 
    /// By default, this value is 1.0.
    public func textScaleX(_ size: Float) -> Self {
        TextScaleXViewProperty(value: size).applyOrAppend(nil, self)
    }
}

// MARK: SetTextSelectHandle

private struct TextSelectHandleViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextSelectHandle"
    enum Value {
        case drawable(Drawable)
        case resourceId(Int32)
    }
    let value: Value
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
        case .drawable(let drawable):
            instance.callVoidMethod(env, name: key.rawValue, args: drawable.signed(as: Drawable.className))
        case .resourceId(let id):
            instance.callVoidMethod(env, name: key.rawValue, args: id)
        }
    }
}
extension TextView {
    /// Sets the Drawable corresponding to the selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandle attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandle(_ drawable: Drawable) -> Self {
        TextSelectHandleViewProperty(value: .drawable(drawable)).applyOrAppend(nil, self)
    }
    
    /// Sets the Drawable corresponding to the selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandle attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandle(resourceId: Int32) -> Self {
        TextSelectHandleViewProperty(value: .resourceId(resourceId)).applyOrAppend(nil, self)
    }
}

// MARK: SetTextSelectHandleLeft

private struct TextSelectHandleLeftViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextSelectHandleLeft"
    enum Value {
        case drawable(Drawable)
        case resourceId(Int32)
    }
    let value: Value
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
        case .drawable(let drawable):
            instance.callVoidMethod(env, name: key.rawValue, args: drawable.signed(as: Drawable.className))
        case .resourceId(let id):
            instance.callVoidMethod(env, name: key.rawValue, args: id)
        }
    }
}
extension TextView {
    /// Sets the Drawable corresponding to the left selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandleLeft attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleLeft(_ drawable: Drawable) -> Self {
        TextSelectHandleLeftViewProperty(value: .drawable(drawable)).applyOrAppend(nil, self)
    }
    
    /// Sets the Drawable corresponding to the left selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandleLeft attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleLeft(resourceId: Int32) -> Self {
        TextSelectHandleLeftViewProperty(value: .resourceId(resourceId)).applyOrAppend(nil, self)
    }
}

// MARK: SetTextSelectHandleRight

private struct TextSelectHandleRightViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextSelectHandleRight"
    enum Value {
        case drawable(Drawable)
        case resourceId(Int32)
    }
    let value: Value
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        switch value {
        case .drawable(let drawable):
            instance.callVoidMethod(env, name: key.rawValue, args: drawable.signed(as: Drawable.className))
        case .resourceId(let id):
            instance.callVoidMethod(env, name: key.rawValue, args: id)
        }
    }
}
extension TextView {
    /// Sets the Drawable corresponding to the right selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandleRight attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleRight(_ drawable: Drawable) -> Self {
        TextSelectHandleRightViewProperty(value: .drawable(drawable)).applyOrAppend(nil, self)
    }
    
    /// Sets the Drawable corresponding to the right selection handle used for positioning the cursor within text.
    /// 
    /// The Drawable defaults to the value of the textSelectHandleRight attribute.
    /// 
    /// **Note** that any change applied to the handle Drawable will not be visible until the handle is hidden and then drawn again.
    public func textSelectHandleRight(resourceId: Int32) -> Self {
        TextSelectHandleRightViewProperty(value: .resourceId(resourceId)).applyOrAppend(nil, self)
    }
}

// MARK: SetTextSize

private struct TextSizeViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setTextSize"
    let value: (Float, DimensionUnit)
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value.1.rawValue, value.0)
    }
}
extension TextView {
    /// Set the default text size to a given unit and value.
    public func textSize(_ size: Float, _ dimension: DimensionUnit = .sp) -> Self {
        TextSizeViewProperty(value: (size, dimension)).applyOrAppend(nil, self)
    }
}

// TODO: setTransformationMethod: implement TransformationMethod https://developer.android.com/reference/android/text/method/TransformationMethod

// TODO: setTypeface: implement Typeface https://developer.android.com/reference/android/graphics/Typeface

// MARK: SetUseBoundsForWidth

private struct UseBoundsForWidthViewProperty: ViewPropertyToApply {
    let key: ViewPropertyKey = "setUseBoundsForWidth"
    let value: Bool
    func applyToInstance(_ env: JEnv?, _ instance: View.ViewInstance) {
        instance.callVoidMethod(env, name: key.rawValue, args: value)
    }
}
extension TextView {
    /// Set true for using width of bounding box as a source of automatic line breaking and drawing.
    /// 
    /// If this value is false, the TextView determines the View width, drawing offset and automatic line breaking based on total advances as text widths.
    /// 
    /// By setting true, use glyph bound's as a source of text width.
    /// 
    /// If the font used for this TextView has glyphs that has negative bearing X or glyph xMax is greater than advance, the glyph clipping can be happened because the drawing area may be bigger than advance.
    /// 
    /// By setting this to true, the TextView will reserve more spaces for drawing are, so clipping can be prevented.
    /// 
    /// This value is true by default if the target API version is 35 or later.
    public func useBoundsForWidth(_ enabled: Bool = true) -> Self {
        UseBoundsForWidthViewProperty(value: enabled).applyOrAppend(nil, self)
    }
}

// MARK: ShowContextMenu

extension TextView {
    /// Shows the context menu for this view.
    ///
    /// Returns `true` if the context menu was shown, `false` otherwise
    @discardableResult
    public func showContextMenu() -> Bool {
        guard let instance = self.instance else { return false }
        return instance.callBoolMethod(name: "showContextMenu") ?? false
    }

    /// Shows the context menu for this view anchored to the specified view-relative coordinate.
    ///
    /// Returns `true` if the context menu was shown, `false` otherwise
    public func showContextMenu(at x: Float, y: Float, _ unit: DimensionUnit) -> Bool {
        guard let instance = self.instance else { return false }
        return instance.callBoolMethod(name: "showContextMenu", args: unit.toPixels(x), unit.toPixels(y)) ?? false
    }
}