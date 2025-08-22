package stream.swift.droid.appkit.listeners

import android.annotation.SuppressLint
import android.view.MotionEvent
import android.view.View

class NativeOnTouchListener(private val uniqueId: Int, private val viewId: Int): View.OnTouchListener {
    @SuppressLint("ClickableViewAccessibility")
    override fun onTouch(v: View?, event: MotionEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onTouchViewEvent(uniqueId, v.id == viewId, v.id, v, event)
            } else {
                return onTouchView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (event != null) {
            return onTouchEvent(uniqueId, event)
        } else {
            return onTouch(uniqueId)
        }
    }

    private external fun onTouch(uniqueId: Int): Boolean
    private external fun onTouchView(uniqueId: Int, sameView: Boolean, vId: Int, v: View): Boolean
    private external fun onTouchEvent(uniqueId: Int, event: MotionEvent): Boolean
    private external fun onTouchViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, event: MotionEvent): Boolean
}