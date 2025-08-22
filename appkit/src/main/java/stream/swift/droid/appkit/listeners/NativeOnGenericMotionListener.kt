package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

class NativeOnGenericMotionListener(private val uniqueId: Int, private val viewId: Int): View.OnGenericMotionListener {
    override fun onGenericMotion(v: View?, event: MotionEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onGenericMotionViewEvent(uniqueId, v.id == viewId, v.id, v, event)
            } else {
                return onGenericMotionView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (event != null) {
            return onGenericMotionEvent(uniqueId, event)
        } else {
            return onGenericMotion(uniqueId)
        }
    }

    private external fun onGenericMotion(uniqueId: Int): Boolean
    private external fun onGenericMotionView(uniqueId: Int, sameView: Boolean, vId: Int, v: View): Boolean
    private external fun onGenericMotionEvent(uniqueId: Int, event: MotionEvent?): Boolean
    private external fun onGenericMotionViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, event: MotionEvent): Boolean
}