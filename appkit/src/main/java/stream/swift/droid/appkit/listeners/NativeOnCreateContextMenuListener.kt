package stream.swift.droid.appkit.listeners

import android.view.ContextMenu
import android.view.View

class NativeOnCreateContextMenuListener(private val uniqueId: Int, private val viewId: Int): View.OnCreateContextMenuListener {
    override fun onCreateContextMenu(
        menu: ContextMenu?,
        v: View?,
        menuInfo: ContextMenu.ContextMenuInfo?
    ) {
        if (menu != null) {
            if (v != null) {
                if (menuInfo != null) {
                    onCreateContextMenuMenuViewInfo(uniqueId, v.id == viewId, menu, v.id, v, menuInfo)
                } else {
                    onCreateContextMenuMenuView(uniqueId, v.id == viewId, menu, v.id, v)
                }
            } else if (menuInfo != null) {
                onCreateContextMenuMenuInfo(uniqueId, menu, menuInfo)
            } else {
                onCreateContextMenuMenu(uniqueId, menu)
            }
        } else if (v != null) {
            if (menuInfo != null) {
                onCreateContextMenuViewInfo(uniqueId, v.id == viewId, v.id, v, menuInfo)
            } else {
                onCreateContextMenuView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (menuInfo != null) {
            onCreateContextMenuInfo(uniqueId, menuInfo)
        } else {
            onCreateContextMenu(uniqueId)
        }
    }

    private external fun onCreateContextMenu(uniqueId: Int)
    private external fun onCreateContextMenuMenu(
        uniqueId: Int,
        menu: ContextMenu
    )
    private external fun onCreateContextMenuView(
        uniqueId: Int,
        sameView: Boolean,
        vId: Int,
        v: View
    )
    private external fun onCreateContextMenuInfo(
        uniqueId: Int,
        menuInfo: ContextMenu.ContextMenuInfo
    )
    private external fun onCreateContextMenuMenuView(
        uniqueId: Int,
        sameView: Boolean,
        menu: ContextMenu,
        vId: Int,
        v: View
    )
    private external fun onCreateContextMenuMenuInfo(
        uniqueId: Int,
        menu: ContextMenu,
        menuInfo: ContextMenu.ContextMenuInfo
    )
    private external fun onCreateContextMenuViewInfo(
        uniqueId: Int,
        sameView: Boolean,
        vId: Int,
        v: View,
        menuInfo: ContextMenu.ContextMenuInfo
    )
    private external fun onCreateContextMenuMenuViewInfo(
        uniqueId: Int,
        sameView: Boolean,
        menu: ContextMenu,
        vId: Int,
        v: View,
        menuInfo: ContextMenu.ContextMenuInfo
    )
}