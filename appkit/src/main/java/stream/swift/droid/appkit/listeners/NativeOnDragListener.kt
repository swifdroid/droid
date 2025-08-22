package stream.swift.droid.appkit.listeners

import android.view.DragEvent
import android.view.View

class NativeOnDragListener(private val uniqueId: Int, private val viewId: Int): View.OnDragListener {
    override fun onDrag(v: View?, event: DragEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onDragViewEvent(uniqueId, v.id == viewId, v.id, v, event)
            } else {
                return onDragView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (event != null) {
            return onDragEvent(uniqueId, event)
        } else {
            return onDrag(uniqueId)
        }
    }

    private external fun onDrag(uniqueId: Int): Boolean
    private external fun onDragView(uniqueId: Int, sameView: Boolean, vId: Int, v: View): Boolean
    private external fun onDragEvent(uniqueId: Int, event: DragEvent): Boolean
    private external fun onDragViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, event: DragEvent): Boolean
}