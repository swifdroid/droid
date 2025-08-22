package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnFocusChangeListener(private val uniqueId: Int, private val viewId: Int): View.OnFocusChangeListener {
    override fun onFocusChange(v: View?, hasFocus: Boolean) {
        if (v != null) {
            onFocusChangeExtended(uniqueId, v.id == viewId, v.id, v, hasFocus)
        } else {
            onFocusChange(uniqueId, hasFocus)
        }
    }

    private external fun onFocusChange(uniqueId: Int, hasFocus: Boolean)
    private external fun onFocusChangeExtended(uniqueId: Int, sameView: Boolean, vId: Int, v: View, hasFocus: Boolean)
}