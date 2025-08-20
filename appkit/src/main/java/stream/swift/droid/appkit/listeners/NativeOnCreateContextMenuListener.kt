package stream.swift.droid.appkit.listeners

import android.view.ContextMenu
import android.view.View

    external override fun onCreateContextMenu(
class NativeOnCreateContextMenuListener(private val uniqueId: Int, private val viewId: Int): View.OnCreateContextMenuListener {
        menu: ContextMenu?,
        v: View?,
        menuInfo: ContextMenu.ContextMenuInfo?,
    )
}