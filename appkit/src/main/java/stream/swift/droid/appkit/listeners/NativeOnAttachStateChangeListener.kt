package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnAttachStateChangeListener: View.OnAttachStateChangeListener {
    external override fun onViewAttachedToWindow(v: View)
    external override fun onViewDetachedFromWindow(v: View)
}