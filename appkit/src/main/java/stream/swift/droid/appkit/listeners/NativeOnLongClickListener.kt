package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnLongClickListener: View.OnLongClickListener {
    external override fun onLongClick(v: View?): Boolean
}