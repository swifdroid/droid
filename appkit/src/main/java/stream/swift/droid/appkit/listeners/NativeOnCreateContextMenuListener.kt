package stream.swift.droid.appkit.listeners

import android.view.ContextMenu
import android.view.View

class NativeOnCreateContextMenuListener: View.OnCreateContextMenuListener {
    external override fun onCreateContextMenu(
        menu: ContextMenu?,
        v: View?,
        menuInfo: ContextMenu.ContextMenuInfo?,
    )
}