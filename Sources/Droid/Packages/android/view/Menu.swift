//
//  Menu.swift
//  Droid
//
//  Created by Mihael Isaev on 24.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// Interface for managing the items in a menu.
///
/// By default, every `Activity` supports an options menu of actions or options.
/// 
/// You can add items to this menu and handle clicks on your additions.
/// 
/// The easiest way of adding menu items is inflating an XML file into the Menu via MenuInflater.
/// 
/// The easiest way of attaching code to clicks is via `Activity.onOptionsItemSelected(MenuItem)`
/// and `Activity.onContextItemSelected(MenuItem)`.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/Menu)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class Menu: JObjectable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/view/Menu" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension Menu {
    public enum Category: Int32 {
        case alternative = 0x00040000
        case container = 0x00010000
        case secondary = 0x00030000
        case system = 0x00020000
    }

    /// First value for group and item identifier integers.
    public static let first: Int32 = 1
    /// Value to use for group and item identifier integers when you don't care about them.
    public static let none: Int32 = 0
    /// A mask of all supported modifiers for MenuItem's keyboard shortcuts
    public static let suppoertedModifiersMask: Int32 = 0x0001100f

    public enum Flag: Int32 {
        case alwaysPerformClose = 0x00000002
        case appendToGroup = 0x00000001
        // case performNoClose = 0x00000001
    }
}

extension Menu {
    /// Add a new item to the menu. This item displays the given title for its label.
    public func add(
        groupId: Int32 = Menu.none,
        itemId: Int32,
        order: Int = 100,
        title: String
    ) -> Menu {
        guard
            let str = JString(from: title),
            let returningClazz = JClass.load(Menu.className),
            let global = object.callObjectMethod(name: "add", args: groupId, itemId, Int32(order), str.signed(as: .java.lang.CharSequence), returningClass: returningClazz)
        else { return self }
        return .init(global)
    }

    // TODO: addIntentOptions

    /// Add a new sub-menu to the menu.
    /// 
    /// This item displays the given title for its label.
    /// 
    /// To modify other attributes on the submenu's menu item, use `SubMenu.getItem()`.
    public func addSubMenu(_ title: String) -> SubMenu! {
        guard
            let str = JString(from: title),
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "addSubMenu", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Add a new sub-menu to the menu.
    /// 
    /// This item displays the given title for its label.
    /// 
    /// To modify other attributes on the submenu's menu item, use `SubMenu.getItem()`.
    public func addSubMenu(_ titleResId: Int32) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "addSubMenu", args: titleResId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Add a new sub-menu to the menu.
    /// 
    /// This item displays the given title for its label.
    /// 
    /// To modify other attributes on the submenu's menu item, use `SubMenu.getItem()`.
    public func addSubMenu(
        groupId: Int,
        itemId: Int,
        order: Int,
        _ title: String
    ) -> SubMenu! {
        guard
            let str = JString(from: title),
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "addSubMenu", args: Int32(groupId), Int32(itemId), Int32(order), str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Add a new sub-menu to the menu.
    /// 
    /// This item displays the given title for its label.
    /// 
    /// To modify other attributes on the submenu's menu item, use `SubMenu.getItem()`.
    public func addSubMenu(
        groupId: Int,
        itemId: Int,
        order: Int,
        _ titleResId: Int32
    ) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "addSubMenu", args: Int32(groupId), Int32(itemId), Int32(order), titleResId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Remove all existing items from the menu, leaving it empty as if it had just been created.
    public func clear() {
        object.callVoidMethod(name: "clear")
    }

    /// Closes the menu, if open.
    public func close() {
        object.callVoidMethod(name: "close")
    }

    /// Return the menu item with a particular identifier.
    public func findItem(_ id: Int) -> MenuItem? {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "findItem", args: Int32(id), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Gets the menu item at the given index.
    public func getItem(at index: Int) -> MenuItem? {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "getItem", args: Int32(index), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Return whether the menu currently has item items that are visible.
    public func hasVisibleItems() -> Bool {
        object.callBoolMethod(name: "hasVisibleItems") ?? false
    }

    /// Is a keypress one of the defined shortcut keys for this window.
    public func isShortcutKey(_ keyCode: KeyEvent.KeyCode, _ event: KeyEvent) -> Bool {
        object.callBoolMethod(name: "isShortcutKey", args: keyCode.rawValue, event.signed(as: KeyEvent.className)) ?? false
    }

    /// Execute the menu item action associated with the given menu identifier.
    public func performIdentifierAction(id: Int, flags: Int) -> Bool {
        object.callBoolMethod(name: "performIdentifierAction", args: Int32(id), Int32(flags)) ?? false
    }

    /// Execute the menu item action associated with the given shortcut character.
    public func performShortcut(_ keyCode: KeyEvent.KeyCode, _ event: KeyEvent, _ flags: Int) -> Bool {
        object.callBoolMethod(name: "performShortcut", args: keyCode.rawValue, event.signed(as: KeyEvent.className), Int32(flags)) ?? false
    }

    /// Remove all items in the given group.
    public func removeGroup(_ groupId: Int) {
        object.callVoidMethod(name: "removeGroup", args: Int32(groupId))
    }

    /// Remove the item with the given identifier.
    public func removeItem(_ id: Int) {
        object.callVoidMethod(name: "removeItem", args: Int32(id))
    }

    /// Control whether a particular group of items can show a check mark.
    /// 
    /// This is similar to calling `MenuItem.setCheckable` on all of the menu items with the given group identifier,
    // but in addition you can control whether this group contains a mutually-exclusive set items.

    // This should be called after the items of the group have been added to the menu.
    public func groupCheckable(group: Int, _ checkable: Bool = true, exclusive: Bool = false) {
        object.callVoidMethod(name: "setGroupCheckable", args: Int32(group), checkable, exclusive)
    }

    /// Enable or disable the group dividers.
    public func groupDividerEnabled(_ value: Bool = true) {
        object.callVoidMethod(name: "setGroupDividerEnabled", args: value)
    }

    /// Enable or disable all menu items that are in the given group.
    public func groupEnabled(group: Int, _ enabled: Bool = true) {
        object.callVoidMethod(name: "setGroupEnabled", args: Int32(group), enabled)
    }

    /// Show or hide all menu items that are in the given group.
    public func groupVisible(group: Int, _ visible: Bool = true) {
        object.callVoidMethod(name: "setGroupVisible", args: Int32(group), visible)
    }

    /// Control whether the menu should be running in qwerty mode
    /// (alphabetic shortcuts) or 12-key mode (numeric shortcuts).
    public func qwertyMode(_ value: Bool = true) {
        object.callVoidMethod(name: "setQwertyMode", args: value)
    }

    /// Get the number of items in the menu.
    /// 
    /// Note that this will change any times items are added or removed from the menu.
    public func size() -> Int {
        Int(object.callIntMethod(name: "size") ?? 0)
    }
}

/// Extension of Menu for context menus providing functionality to modify the header of the context menu.
///
/// Context menus do not support item shortcuts and item icons.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/ContextMenu.html)
open class ContextMenu: Menu, @unchecked Sendable {
    /// The JNI class name
    open class override var className: JClassName { "android/view/ContextMenu" }
}

extension ContextMenu {
    /// Clears the header of the context menu.
    public func clearHeader() {
        object.callVoidMethod(name: "clearHeader")
    }

    /// Sets the context menu header's icon to the icon given in iconRes resource id.
    public func headerIcon(_ resId: Int32) -> ContextMenu! {
        guard
            let returningClazz = JClass.load(ContextMenu.className),
            let global = object.callObjectMethod(name: "setHeaderIcon", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the context menu header's icon to the icon given in icon `Drawable`.
    public func headerIcon(_ value: Drawable) -> ContextMenu! {
        guard
            let returningClazz = JClass.load(ContextMenu.className),
            let global = object.callObjectMethod(name: "setHeaderIcon", args: value.signed(as: Drawable.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the context menu header's title to the title given in titleRes resource identifier.
    public func headerTitle(_ resId: Int32) -> ContextMenu! {
        guard
            let returningClazz = JClass.load(ContextMenu.className),
            let global = object.callObjectMethod(name: "setHeaderTitle", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the context menu header's title to the title given in title.
    public func headerTitle(_ value: String) -> ContextMenu! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(ContextMenu.className),
            let global = object.callObjectMethod(name: "setHeaderTitle", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the header of the context menu to the View given in view.
    /// 
    /// This replaces the header title and icon (and those replace this).
    public func headerView(_ view: View) -> ContextMenu! {
        guard
            let view = view.instance,
            let returningClazz = JClass.load(ContextMenu.className),
            let global = object.callObjectMethod(name: "setHeaderView", args: view.signed(as: View.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }
}

extension ContextMenu {
/// Additional information regarding the creation of the context menu.
/// 
/// For example, AdapterViews use this to pass the exact item position within the adapter that initiated the context menu.
///
/// [Learn more](https://developer.android.com/reference/android/view/ContextMenu.ContextMenuInfo)
#if canImport(AndroidLooper)
    @UIThreadActor
    #endif
    open class ContextMenuInfo: JObjectable, @unchecked Sendable {
        /// The JNI class name
        open class var className: JClassName { "android/view/ContextMenu$ContextMenuInfo" }

        public let object: JObject

        public init (_ object: JObject) {
            self.object = object
        }
    }
}

extension AdapterView {
    /// Extra menu information provided
    /// to the `View.OnCreateContextMenuListener.onCreateContextMenu(ContextMenu, View, ContextMenuInfo)`
    /// callback when a context menu is brought up for this `AdapterView`.
    public final class AdapterContextMenuInfo: ContextMenu.ContextMenuInfo, @unchecked Sendable {
        /// The JNI class name
        public class override var className: JClassName { "android/widget/AdapterView$AdapterContextMenuInfo" }

        public init! (
            targetView: View,
            potision: Int,
            id: Int32 = .nextViewId()
        ) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let targetView = targetView.instance,
                let clazz = JClass.load(Self.className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(View.className), .int, .int, returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [targetView.object, Int32(potision), id])
            else { return nil }
            super.init(global)
            #else
            return nil
            #endif
        }

        /// The row id of the item for which the context menu is being displayed.
        public func id() -> Int {
            Int(object.longField(name: "id") ?? 0)
        }

        /// The position in the adapter for which the context menu is being displayed.
        public func position() -> Int {
            Int(object.intField(name: "position") ?? 0)
        }

        /// The child view for which the context menu is being displayed.
        public func targetView(_ context: ActivityContext) -> View! {
            guard
                let returningClazz = JClass.load(View.className),
                let global = object.objectField(name: "targetView", returningClass: returningClazz)
            else { return nil }
            return .init(global, context)
        }
    }
}

extension ExpandableListView {
    /// Extra menu information specific to an ExpandableListView provided
    /// to the View.OnCreateContextMenuListener.onCreateContextMenu(ContextMenu, View, ContextMenuInfo)
    /// callback when a context menu is brought up for this AdapterView.
    public final class ExpandableListContextMenuInfo: ContextMenu.ContextMenuInfo, @unchecked Sendable {
        /// The JNI class name
        public class override var className: JClassName { "android/widget/ExpandableListView$ExpandableListContextMenuInfo" }

        public init! (
            targetView: View,
            packedPosition: Int,
            id: Int32 = .nextViewId()
        ) {
            #if os(Android)
            guard
                let env = JEnv.current(),
                let targetView = targetView.instance,
                let clazz = JClass.load(Self.className),
                let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(View.className), .int, .int, returning: .void)),
                let global = env.newObject(clazz: clazz, constructor: methodId, args: [targetView.object, Int64(packedPosition), Int64(id)])
            else { return nil }
            super.init(global)
            #else
            return nil
            #endif
        }

        /// The ID of the item (group or child) for which the context menu is being displayed.
        public func id() -> Int {
            Int(object.longField(name: "id") ?? 0)
        }

        /// The packed position in the list represented by the adapter for which the context menu is being displayed.
        public func packedPosition() -> Int {
            Int(object.longField(name: "packedPosition") ?? 0)
        }

        /// The view for which the context menu is being displayed.
        /// 
        /// This will be one of the children Views of this ExpandableListView.
        public func targetView(_ context: ActivityContext) -> View! {
            guard
                let returningClazz = JClass.load(View.className),
                let global = object.objectField(name: "targetView", returningClass: returningClazz)
            else { return nil }
            return .init(global, context)
        }
    }
}

/// Subclass of Menu for sub menus.
///
/// Sub menus do not support item icons, or nested sub menus.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/SubMenu)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class SubMenu: JObjectable, Sendable {
    /// The JNI class name
    public class var className: JClassName { "android/view/SubMenu" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension SubMenu {
    /// Clears the header of the submenu.
    public func clearHeader() {
        object.callVoidMethod(name: "clearHeader")
    }

    /// Gets the MenuItem that represents this submenu in the parent menu.
    /// 
    /// Use this for setting additional item attributes.
    public func item() -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "getItem", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the submenu header's icon to the icon given in iconRes resource id.
    public func headerIcon(_ resId: Int32) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setHeaderIcon", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the submenu header's icon to the icon given in icon `Drawable`.
    public func headerIcon(_ value: Drawable) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setHeaderIcon", args: value.signed(as: Drawable.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the submenu header's title to the title given in titleRes resource identifier.
    public func headerTitle(_ resId: Int32) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setHeaderTitle", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the submenu header's title to the title given in title.
    public func headerTitle(_ value: String) -> SubMenu! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setHeaderTitle", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets the header of the submenu to the View given in view.
    /// 
    /// This replaces the header title and icon (and those replace this).
    public func headerView(_ view: View) -> SubMenu! {
        guard
            let view = view.instance,
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setHeaderView", args: view.signed(as: View.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the icon associated with this submenu's item in its parent menu.
    public func icon(_ value: Drawable) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setIcon", args: value.signed(as: Drawable.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the icon associated with this submenu's item in its parent menu.
    public func icon(_ resId: Int32) -> SubMenu! {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "setIcon", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }
}

/// Interface for direct access to a previously created menu item.
/// 
/// An Item is returned by calling one of the `Menu.add(int)` methods.
///
/// For a feature set of specific menu types, see `Menu`.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/MenuItem)
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class MenuItem: JObjectable, @unchecked Sendable {
    /// The JNI class name
    public class var className: JClassName { "android/view/MenuItem" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

extension MenuItem {
    public enum ShowAsAction: Int32 {
        /// Always show this item as a button in an Action Bar.
        ///
        /// Use sparingly! If too many items are set to always show in the Action Bar it can crowd the Action Bar
        /// and degrade the user experience on devices with smaller screens.
        /// A good rule of thumb is to have no more than 2 items set to always show at a time.
        case always = 2
        /// This item's action view collapses to a normal menu item.
        /// When expanded, the action view temporarily takes over a larger segment of its container.
        case collapseActionView = 8
        /// Show this item as a button in an Action Bar if the system decides there is room for it.
        case ifRoom = 1
        /// Never show this item as a button in an Action Bar.
        case never = 0
        /// When this item is in the action bar, always show it with a text label even if it also has an icon specified.
        case withText = 4
    }
}

extension MenuItem {
    /// Collapse the action view associated with this menu item.
    ///
    /// The menu item must have an action view set, as well as the `showAsAction` flag `SHOW_AS_ACTION_COLLAPSE_ACTION_VIEW`.
    /// 
    /// If a listener has been set using `setOnActionExpandListener(android.view.MenuItem.OnActionExpandListener)`
    /// it will have its `OnActionExpandListener.onMenuItemActionCollapse(MenuItem)` method invoked.
    /// 
    /// The listener may return false from this method to prevent collapsing the action view.
    public func collapseActionView() -> Bool {
        object.callBoolMethod(name: "collapseActionView") ?? false
    }

    /// Expand the action view associated with this menu item.
    ///
    /// The menu item must have an action view set, as well as the `showAsAction` flag `SHOW_AS_ACTION_COLLAPSE_ACTION_VIEW`.
    /// 
    /// If a listener has been set using `setOnActionExpandListener(android.view.MenuItem.OnActionExpandListener)`
    /// it will have its `OnActionExpandListener.onMenuItemActionCollapse(MenuItem)` method invoked.
    /// 
    /// The listener may return false from this method to prevent collapsing the action view.
    public func expandActionView() -> Bool {
        object.callBoolMethod(name: "expandActionView") ?? false
    }

    /// Gets the `ActionProvider`.
    public func actionProvider() -> ActionProvider? {
        guard
            let returningClazz = JClass.load(ActionProvider.className),
            let global = object.callObjectMethod(name: "getActionProvider", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Returns the currently set action view for this menu item.
    public func actionView(_ context: ActivityContext) -> View? {
        guard
            let returningClazz = JClass.load(View.className),
            let global = object.callObjectMethod(name: "getActionView", returningClass: returningClazz)
        else { return nil }
        return .init(global, context)
    }

    /// Return the modifier for this menu item's alphabetic shortcut.
    /// 
    /// The modifier is a combination of
    ///    - KeyEvent.META_META_ON
    ///    - KeyEvent.META_CTRL_ON
    ///    - KeyEvent.META_ALT_ON
    ///    - KeyEvent.META_SHIFT_ON
    ///    - KeyEvent.META_SYM_ON
    ///    - KeyEvent.META_FUNCTION_ON
    /// 
    /// For example: `KeyEvent.META_FUNCTION_ON | KeyEvent.META_CTRL_ON`
    public func alphabeticModifiers() -> Int { // TODO: implement as OptionSet?
        Int(object.callIntMethod(name: "getAlphabeticModifiers") ?? 0)
    }

    /// Return the char for this menu item's alphabetic shortcut.
    public func alphabeticShortcut() -> UInt16 {
        object.callCharMethod(name: "getAlphabeticShortcut") ?? 0
    }

    /// Retrieve the content description associated with this menu item.
    public func contentDescription() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getContentDescription", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }

    /// Return the group identifier that this menu item is part of.
    /// 
    /// The group identifier can not be changed after the menu is created.
    public func groupId() -> Int {
        Int(object.callIntMethod(name: "getGroupId") ?? 0)
    }

    /// Returns the icon for this item as a Drawable (getting it from resources if it hasn't been loaded before).
    /// 
    /// Note that if you call `setIconTintList(ColorStateList)` or `setIconTintMode(PorterDuff.Mode)` on this item,
    /// and you use a custom menu presenter in your application,
    /// you have to apply the tinting explicitly on the Drawable returned by this method.
    public func icon() -> Drawable? {
        guard
            let returningClazz = JClass.load(Drawable.className),
            let global = object.callObjectMethod(name: "getIcon", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: getIconTintBlendMode implement BlendMode
    // TODO: getIconTintList implement ColorStateList
    // TODO: getIconTintMode implement PorterDuff.Mode

    /// Return the Intent associated with this item.
    /// 
    /// This returns a reference to the Intent which you can change as desired to modify what the Item is holding.
    public func intent() -> Intent? {
        guard
            let returningClazz = JClass.load(Intent.className),
            let global = object.callObjectMethod(name: "getIntent", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Return the identifier for this menu item.
    /// 
    /// The identifier can not be changed after the menu is created.
    public func itemId() -> Int {
        Int(object.callIntMethod(name: "getItemId") ?? 0)
    }

    // TODO: getMenuInfo implement ContextMenu.ContextMenuInfo
    
    /// Return the modifiers for this menu item's numeric (12-key) shortcut.
    /// 
    /// The modifier is a combination of
    ///    - KeyEvent.META_META_ON
    ///    - KeyEvent.META_CTRL_ON
    ///    - KeyEvent.META_ALT_ON
    ///    - KeyEvent.META_SHIFT_ON
    ///    - KeyEvent.META_SYM_ON
    ///    - KeyEvent.META_FUNCTION_ON
    /// 
    /// For example: `KeyEvent.META_FUNCTION_ON | KeyEvent.META_CTRL_ON`
    public func numericModifiers() -> Int { // TODO: implement as OptionSet?
        Int(object.callIntMethod(name: "getNumericModifiers") ?? 0)
    }

    /// Return the char for this menu item's numeric (12-key) shortcut.
    public func numericShortcut() -> UInt16 {
        object.callCharMethod(name: "getNumericShortcut") ?? 0
    }

    /// Return the category and order within the category of this item.
    /// 
    /// This item will be shown before all items (within its category) that have order greater than this value.
    public func order() -> Int {
        Int(object.callIntMethod(name: "getOrder") ?? 0)
    }

    /// Get the sub-menu to be invoked when this item is selected, if it has one.
    public func subMenu() -> SubMenu? {
        guard
            let returningClazz = JClass.load(SubMenu.className),
            let global = object.callObjectMethod(name: "getSubMenu", returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Retrieve the current title of the item.
    public func title() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getTitle", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }

    /// Retrieve the current condensed title of the item.
    /// 
    /// If a condensed title was never set, it will return the normal title.
    public func titleCondensed() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getTitleCondensed", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }

    /// Retrieve the tooltip text associated with this menu item.
    public func tooltipText() -> String? {
        guard
            let returningClazz = JClass.load(JString.charSequenseClassName),
            let str = object.callObjectMethod(name: "getTooltipText", returningClass: returningClazz)
        else { return nil }
        return JString(str).toString()
    }

    /// Check whether this item has an associated sub-menu.
    /// 
    /// I.e. it is a sub-menu of another menu.
    public func hasSubMenu() -> Bool {
        object.callBoolMethod(name: "hasSubMenu") ?? false
    }

    /// Returns true if this menu item's action view has been expanded.
    public func isActionViewExpanded() -> Bool {
        object.callBoolMethod(name: "isActionViewExpanded") ?? false
    }

    /// Return whether the item can currently display a check mark.
    public func isCheckable() -> Bool {
        object.callBoolMethod(name: "isCheckable") ?? false
    }

    /// Return whether the item is currently displaying a check mark.
    public func isChecked() -> Bool {
        object.callBoolMethod(name: "isChecked") ?? false
    }

    /// Return the enabled state of the menu item.
    public func isEnabled() -> Bool {
        object.callBoolMethod(name: "isEnabled") ?? false
    }

    /// Return the visibility of the menu item.
    public func isVisible() -> Bool {
        object.callBoolMethod(name: "isVisible") ?? false
    }

    /// Sets the `ActionProvider` responsible for creating an action view if the item is placed on the action bar.
    /// 
    /// The provider also provides a default action invoked if the item is placed in the overflow menu.
    ///
    /// Note: Setting an action provider overrides the action view set via `setActionView(int)` or `setActionView(View)`.
    public func actionProvider(_ provider: ActionProvider) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setActionProvider", args: provider.signed(as: ActionProvider.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Set an action view for this menu item.
    /// 
    /// An action view will be displayed in place of an automatically generated menu item element in the UI when this item is shown as an action within a parent.
    /// 
    /// Note: Setting an action view overrides the action provider set via `setActionProvider(ActionProvider)`.
    public func actionView(_ resId: Int32) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setActionView", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Set an action view for this menu item.
    /// 
    /// An action view will be displayed in place of an automatically generated menu item element in the UI when this item is shown as an action within a parent.
    /// 
    /// Note: Setting an action view overrides the action provider set via `setActionProvider(ActionProvider)`.
    public func actionView(_ view: View) -> MenuItem! {
        guard
            let view = view.instance,
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setActionView", args: view.signed(as: View.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the alphabetic shortcut associated with this item.
    /// 
    /// The shortcut will be triggered when the key that generates the given character is pressed along with the corresponding modifier key.
    /// 
    /// The default modifier is `KeyEvent.META_CTRL_ON` in case nothing is specified.
    /// 
    /// Case is not significant and shortcut characters will be displayed in lower case.
    /// 
    /// Note that menu items with the characters '\b' or '\n' as shortcuts will get triggered by the Delete key or Carriage Return key, respectively.
    /// 
    /// See Menu for the menu types that support shortcuts.
    public func alphabeticShortcut(_ alphaChar: UInt16) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setAlphabeticShortcut", args: alphaChar, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the alphabetic shortcut associated with this item.
    /// 
    /// The shortcut will be triggered when the key that generates the given character is pressed along with the corresponding modifier key.
    /// 
    /// The default modifier is `KeyEvent.META_CTRL_ON` in case nothing is specified.
    /// 
    /// Case is not significant and shortcut characters will be displayed in lower case.
    /// 
    /// Note that menu items with the characters '\b' or '\n' as shortcuts will get triggered by the Delete key or Carriage Return key, respectively.
    /// 
    /// See Menu for the menu types that support shortcuts.
    public func alphabeticShortcut(_ alphaChar: UInt16, alphaModifiers: Int) -> MenuItem! { // TODO: OptionSet for modifiers?
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setAlphabeticShortcut", args: alphaChar, Int32(alphaModifiers), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Control whether this item can display a check mark.
    /// 
    /// Setting this does not actually display a check mark (see setChecked(boolean) for that);
    /// 
    /// rather, it ensures there is room in the item in which to display a check mark.
    ///
    /// See Menu for the menu types that support check marks.
    public func checkable(_ value: Bool = true) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setCheckable", args: value, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Control whether this item is shown with a check mark.
    /// 
    /// Note that you must first have enabled checking with `setCheckable(boolean)`
    /// or else the check mark will not appear.
    /// 
    /// If this item is a member of a group that contains mutually-exclusive items (set via Menu.setGroupCheckable(int, boolean, boolean), the other items in the group will be unchecked.
    ///
    /// See Menu for the menu types that support check marks.
    public func checked(_ value: Bool = true) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setChecked", args: value, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the content description associated with this menu item.
    public func contentDescription(_ value: String) -> MenuItem! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setContentDescription", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets whether the menu item is enabled.
    /// 
    /// Disabling a menu item will not allow it to be invoked via its shortcut.
    /// 
    /// The menu item will still be visible.
    public func enabled(_ value: Bool = true) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setEnabled", args: value, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the icon associated with this item.
    /// 
    /// This icon will not always be shown, so the title should be sufficient in describing this item.
    public func icon(_ value: Drawable) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setIcon", args: value.signed(as: Drawable.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the icon associated with this item.
    /// 
    /// This icon will not always be shown, so the title should be sufficient in describing this item.
    public func icon(_ resId: Int32) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setIcon", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: setIconTintBlendMode implement BlendMode
    // TODO: setIconTintList implement ColorStateList
    // TODO: setIconTintMode implement PorterDuff.Mode

    /// Change the Intent associated with this item.
    ///
    /// By default there is no Intent associated with a menu item.
    /// 
    /// If you set one, and nothing else handles the item, then the default behavior will be to call `Context.startActivity(Intent)` with the given Intent.
    ///
    /// Note that `setIntent()` can not be used with the versions of `Menu.add` that take a `Runnable`,
    /// because `Runnable.run` does not return a value so there is no way to tell if it handled the item.
    /// 
    /// In this case it is assumed that the `Runnable` always handles the item, and the intent will never be started.
    public func intent(_ intent: Intent) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setIntent", args: intent.signed(as: Intent.className), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the numeric shortcut and modifiers associated with this item.
    public func numericShortcut(numericChar: UInt16, numericModifiers: Int) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setNumericShortcut", args: numericChar, Int32(numericModifiers), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the numeric shortcut associated with this item.
    public func numericShortcut(numericChar: UInt16) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setNumericShortcut", args: numericChar, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    // TODO: setOnActionExpandListener
    // TODO: setOnMenuItemClickListener

    /// Change the numeric shortcut and modifiers associated with this item.
    public func shortcut(numericChar: UInt16, numericModifiers: Int) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setShortcut", args: numericChar, Int32(numericModifiers), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the numeric shortcut associated with this item.
    public func shortcut(numericChar: UInt16) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setShortcut", args: numericChar, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Sets how this item should display in the presence of an Action Bar.
    public func showAsAction(_ value: ShowAsAction) {
        object.callVoidMethod(name: "setShowAsAction", args: value.rawValue)
    }

    /// Sets how this item should display in the presence of an Action Bar.
    public func setShowAsActionFlags(_ value: ShowAsAction) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setShowAsActionFlags", args: value.rawValue, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the title associated with this item.
    public func title(_ value: String) -> MenuItem! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setTitle", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the title associated with this item.
    public func title(_ resId: Int32) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setTitle", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the condensed title associated with this item.
    /// 
    /// The condensed title is used in situations where the normal title may be too long to be displayed.
    public func titleCondensed(_ value: String) -> MenuItem! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setTitleCondensed", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the condensed title associated with this item.
    /// 
    /// The condensed title is used in situations where the normal title may be too long to be displayed.
    public func titleCondensed(_ resId: Int32) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setTitleCondensed", args: resId, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    /// Change the tooltip text associated with this menu item.
    public func tooltipText(_ value: String) -> MenuItem! {
        guard
            let str = JString(from: value),
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setTooltipText", args: str.signedAsCharSequence(), returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }

    public func visible(_ value: Bool = true) -> MenuItem! {
        guard
            let returningClazz = JClass.load(MenuItem.className),
            let global = object.callObjectMethod(name: "setVisible", args: value, returningClass: returningClazz)
        else { return nil }
        return .init(global)
    }
}