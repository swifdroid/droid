package stream.swift.droid.appkit.listeners

import android.view.KeyEvent
import android.view.View

class NativeOnKeyListener(private val uniqueId: Int, private val viewId: Int): View.OnKeyListener {
    override fun onKey(v: View?, keyCode: Int, event: KeyEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onKeyViewEvent(uniqueId, v.id == viewId, v.id, v, keyCode, event)
            } else {
                return onKeyView(uniqueId, v.id == viewId, v.id, v, keyCode)
            }
        } else if (event != null) {
            return onKeyEvent(uniqueId, keyCode, event)
        } else {
            return onKey(uniqueId, keyCode)
        }
    }

    private external fun onKey(uniqueId: Int, keyCode: Int): Boolean
    private external fun onKeyView(uniqueId: Int, sameView: Boolean, vId: Int, v: View, keyCode: Int): Boolean
    private external fun onKeyEvent(uniqueId: Int, keyCode: Int, event: KeyEvent): Boolean
    private external fun onKeyViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, keyCode: Int, event: KeyEvent): Boolean
}