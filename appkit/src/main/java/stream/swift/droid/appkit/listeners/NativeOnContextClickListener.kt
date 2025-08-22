package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnContextClickListener(private val uniqueId: Int, private val viewId: Int): View.OnContextClickListener {
    override fun onContextClick(v: View?): Boolean {
        if (v != null) {
            return onContextClickExtended(uniqueId, v.id == viewId, v)
        } else {
            return onContextClick(uniqueId)
        }
    }

    private external fun onContextClick(uniqueId: Int): Boolean
    private external fun onContextClickExtended(uniqueId: Int, sameView: Boolean, v: View): Boolean
}