package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnAttachStateChangeListener(private val uniqueId: Int, private val viewId: Int): View.OnAttachStateChangeListener {
    override fun onViewAttachedToWindow(v: View) {
        onViewAttachedToWindow(uniqueId, v.id == viewId, v.id, v)
    }
    override fun onViewDetachedFromWindow(v: View) {
        onViewDetachedFromWindow(uniqueId, v.id == viewId, v.id, v)
    }

    private external fun onViewAttachedToWindow(uniqueId: Int, sameView: Boolean, vId: Int, v: View)
    private external fun onViewDetachedFromWindow(uniqueId: Int, sameView: Boolean, vId: Int, v: View)
}