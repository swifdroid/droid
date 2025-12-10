//
//  BadgeUtils.swift
//  Droid
//
//  Created by Mihael Isaev on 10.12.2025.
//

#if os(Android)
import Android
#endif

extension ComGoogleAndroidPackage.MaterialPackage.BadgePackage {
    public class BadgeUtilsClass: JClassName, @unchecked Sendable {}
    
    public var BadgeUtils: BadgeUtilsClass { .init(parent: self, name: "BadgeUtils") }
}

/// Utility class for `BadgeDrawable`.
@MainActor
public final class BadgeUtils: JObjectable, @unchecked Sendable {
    public class var className: JClassName { .comGoogleAndroid.material.badge.BadgeUtils }

    /// JNI Object
    public let object: JObject
    
    /// Base Droid constructor with existing JNI object
    public init (_ object: JObject) {
        self.object = object
    }
}

extension BadgeUtils {
    /// Attaches a BadgeDrawable to its associated anchor
    /// and update the BadgeDrawable's coordinates based on the anchor.
    /// 
    /// The BadgeDrawable will be added as a view overlay as default.
    /// 
    /// If it has a FrameLayout custom parent that is an ancestor
    /// of the anchor, then the BadgeDrawable will be set as the foreground of that.
    public static func attachBadgeDrawable(
        _ badgeDrawable: BadgeDrawable,
        to anchor: View,
        in parent: FrameLayout? = nil
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        var args: [JSignatureItemable] = []
        args.append(badgeDrawable.signed(as: BadgeDrawable.className))
        guard let anchorInstance = anchor.instance else { return }
        args.append(anchorInstance.signed(as: View.className))
        if let parent = parent {
            guard let parentInstance = parent.instance else { return }
            args.append(parentInstance.signed(as: FrameLayout.className))
        }
        clazz.staticVoidMethod(
            name: "attachBadgeDrawable",
            args: args
        )
    }

    /// A convenience method to attach a BadgeDrawable to the specified
    /// menu item on a toolbar, update the BadgeDrawable's coordinates
    /// based on its anchor and adjust the BadgeDrawable's offset
    /// so it is not clipped off by the toolbar.
    /// 
    /// The BadgeDrawable will be added as a view overlay as default.
    /// 
    /// If it has a FrameLayout custom parent that is an ancestor
    /// of the anchor, then the BadgeDrawable will be set as the foreground of that.
    ///
    /// Menu item views are reused by the menu, so any structural changes
    /// to the menu may require detaching the BadgeDrawable
    /// and re-attaching it to the correct item.
    public static func attachBadgeDrawable(
        _ badgeDrawable: BadgeDrawable,
        toMenuItem menuItemId: Int32,
        in toolbar: Toolbar,
        in parent: FrameLayout? = nil
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        var args: [JSignatureItemable] = []
        args.append(badgeDrawable.signed(as: BadgeDrawable.className))
        guard let toolbarInstance = toolbar.instance else { return }
        args.append(toolbarInstance.signed(as: Toolbar.className))
        args.append(menuItemId)
        if let parent = parent {
            guard let parentInstance = parent.instance else { return }
            args.append(parentInstance.signed(as: FrameLayout.className))
        }
        clazz.staticVoidMethod(
            name: "attachBadgeDrawable",
            args: args
        )
    }
}

// TODO: createBadgeDrawablesFromSavedStates
// TODO: createParcelableBadgeStates

extension BadgeUtils {
    /// Detaches a `BadgeDrawable` from its associated anchor.
    /// 
    /// The `BadgeDrawable` will be removed from its anchor's ViewOverlay.
    /// If it has a FrameLayout custom parent that is an ancestor of the anchor,
    /// then the `BadgeDrawable` will be removed from the parent's foreground instead.
    public static func detachBadgeDrawable(
        _ badgeDrawable: BadgeDrawable,
        from anchor: View
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        var args: [JSignatureItemable] = []
        args.append(badgeDrawable.signed(as: BadgeDrawable.className))
        guard let anchorInstance = anchor.instance else { return }
        args.append(anchorInstance.signed(as: View.className))
        clazz.staticVoidMethod(
            name: "detachBadgeDrawable",
            args: args
        )
    }

    /// Detaches a `BadgeDrawable` from its associated action menu item on a toolbar.
    /// 
    /// The `BadgeDrawable` will be removed from its anchor's ViewOverlay.
    /// If it has a FrameLayout custom parent that is an ancestor of the anchor,
    /// then the `BadgeDrawable` will be removed from the parent's foreground instead.
    public static func detachBadgeDrawable(
        _ badgeDrawable: BadgeDrawable,
        fromMenuItem menuItemId: Int32,
        in toolbar: Toolbar
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        var args: [JSignatureItemable] = []
        args.append(badgeDrawable.signed(as: BadgeDrawable.className))
        guard let toolbarInstance = toolbar.instance else { return }
        args.append(toolbarInstance.signed(as: Toolbar.className))
        args.append(menuItemId)
        clazz.staticVoidMethod(
            name: "detachBadgeDrawable",
            args: args
        )
    }
}

extension BadgeUtils {
    /// Sets the bounds of a `BadgeDrawable` to match the bounds
    /// of its anchor or its anchor's FrameLayout ancestor if it has a custom parent set.
    public static func setBadgeDrawableBounds(
        _ badgeDrawable: BadgeDrawable,
        for anchor: View,
        in parent: FrameLayout
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        var args: [JSignatureItemable] = []
        args.append(badgeDrawable.signed(as: BadgeDrawable.className))
        guard let anchorInstance = anchor.instance else { return }
        args.append(anchorInstance.signed(as: View.className))
        guard let parentInstance = parent.instance else { return }
        args.append(parentInstance.signed(as: FrameLayout.className))
        clazz.staticVoidMethod(
            name: "setBadgeDrawableBounds",
            args: args
        )
    }
}

extension BadgeUtils {
    /// Sets the bounds of a `BadgeDrawable` to match the bounds
    /// of its anchor or its anchor's FrameLayout ancestor if it has a custom parent set.
    public static func updateBadgeBounds(
        _ rect: Rect,
        _ centerX: Float,
        _ centerY: Float,
        _ halfWidth: Float,
        _ halfHeight: Float,
        _ unit: DimensionUnit = .dp
    ) {
        guard
            let clazz = JClass.load(BadgeUtils.className)
        else { return }
        clazz.staticVoidMethod(
            name: "updateBadgeBounds",
            args:
                rect.signed(as: Rect.className),
                unit.toPixels(centerX),
                unit.toPixels(centerY),
                unit.toPixels(halfWidth),
                unit.toPixels(halfHeight)
        )
    }
}