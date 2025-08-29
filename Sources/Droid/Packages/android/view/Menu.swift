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
open class Menu: JObjectable, Contextable, @unchecked Sendable {
    /// The JNI class name
    open class var className: JClassName { "android/view/Menu" }

    public let object: JObject
    public let context: ActivityContext

    public init (_ object: JObject, _ context: Contextable) {
        self.object = object
        self.context = context.context
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
    ) -> Self {
        guard
            let str = JString(from: title)
        else { return self }
        _ = object.callObjectMethod(name: "add", args: groupId, itemId, Int32(order), str.signed(as: .java.lang.CharSequence), returning: .object(Menu.className))
        return self
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
            let global = object.callObjectMethod(name: "addSubMenu", args: str.signedAsCharSequence(), returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }

    /// Add a new sub-menu to the menu.
    /// 
    /// This item displays the given title for its label.
    /// 
    /// To modify other attributes on the submenu's menu item, use `SubMenu.getItem()`.
    public func addSubMenu(_ titleResId: Int32) -> SubMenu! {
        guard
            let global = object.callObjectMethod(name: "addSubMenu", args: titleResId, returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
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
            let global = object.callObjectMethod(name: "addSubMenu", args: Int32(groupId), Int32(itemId), Int32(order), str.signedAsCharSequence(), returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
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
            let global = object.callObjectMethod(name: "addSubMenu", args: Int32(groupId), Int32(itemId), Int32(order), titleResId, returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
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
            let global = object.callObjectMethod(name: "findItem", args: Int32(id), returning: .object(MenuItem.className))
        else { return nil }
        return .init(global, self)
    }

    /// Gets the menu item at the given index.
    public func getItem(at index: Int) -> MenuItem? {
        guard
            let global = object.callObjectMethod(name: "getItem", args: Int32(index), returning: .object(MenuItem.className))
        else { return nil }
        return .init(global, self)
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
            let global = object.callObjectMethod(name: "setHeaderIcon", args: resId, returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }

    /// Sets the context menu header's icon to the icon given in icon `Drawable`.
    public func headerIcon(_ value: Drawable) -> ContextMenu! {
        guard
            let global = object.callObjectMethod(name: "setHeaderIcon", args: value.signed(as: Drawable.className), returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }

    /// Sets the context menu header's title to the title given in titleRes resource identifier.
    public func headerTitle(_ resId: Int32) -> ContextMenu! {
        guard
            let global = object.callObjectMethod(name: "setHeaderTitle", args: resId, returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }

    /// Sets the context menu header's title to the title given in title.
    public func headerTitle(_ value: String) -> ContextMenu! {
        guard
            let str = JString(from: value),
            let global = object.callObjectMethod(name: "setHeaderTitle", args: str.signedAsCharSequence(), returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }

    /// Sets the header of the context menu to the View given in view.
    /// 
    /// This replaces the header title and icon (and those replace this).
    public func headerView(_ view: View) -> ContextMenu! {
        guard
            let view = view.instance,
            let global = object.callObjectMethod(name: "setHeaderView", args: view.signed(as: View.className), returning: .object(SubMenu.className))
        else { return nil }
        return .init(global, self)
    }
}
