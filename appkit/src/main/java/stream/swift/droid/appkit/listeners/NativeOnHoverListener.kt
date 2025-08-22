package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

class NativeOnHoverListener(private val uniqueId: Int, private val viewId: Int): View.OnHoverListener {
    override fun onHover(v: View?, event: MotionEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onHoverViewEvent(uniqueId, v.id == viewId, v.id, v, event)
            } else {
                return onHoverView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (event != null) {
            return onHoverEvent(uniqueId, event)
        } else {
            return onHover(uniqueId)
        }
    }

    private external fun onHover(uniqueId: Int): Boolean
    private external fun onHoverView(uniqueId: Int, sameView: Boolean, vId: Int, v: View): Boolean
    private external fun onHoverEvent(uniqueId: Int, event: MotionEvent): Boolean
    private external fun onHoverViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, event: MotionEvent): Boolean
}