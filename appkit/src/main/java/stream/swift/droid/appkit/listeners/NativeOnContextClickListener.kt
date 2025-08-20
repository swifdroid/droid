package stream.swift.droid.appkit.listeners

import android.view.View

    external override fun onContextClick(v: View?): Boolean
class NativeOnContextClickListener(private val uniqueId: Int, private val viewId: Int): View.OnContextClickListener {
}