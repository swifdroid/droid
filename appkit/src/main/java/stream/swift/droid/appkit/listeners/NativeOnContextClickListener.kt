package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnContextClickListener: View.OnContextClickListener {
    external override fun onContextClick(v: View?): Boolean
}