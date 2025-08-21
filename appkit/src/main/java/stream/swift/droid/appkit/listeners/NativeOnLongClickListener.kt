package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnLongClickListener(private val uniqueId: Int, private val viewId: Int): View.OnLongClickListener {
    override fun onLongClick(v: View?): Boolean {
        if (v != null) {
            return onLongClickExtended(uniqueId, v.id == viewId, v.id, v)
        } else {
            return onLongClick(uniqueId)
        }
    }

    private external fun onLongClick(uniqueId: Int): Boolean
    private external fun onLongClickExtended(uniqueId: Int, sameView: Boolean, viewId: Int, v: View): Boolean
}