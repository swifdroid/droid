package stream.swift.droid.appkit.listeners

import android.view.View

    external override fun onViewAttachedToWindow(v: View)
    external override fun onViewDetachedFromWindow(v: View)
class NativeOnAttachStateChangeListener(private val uniqueId: Int, private val viewId: Int): View.OnAttachStateChangeListener {
}