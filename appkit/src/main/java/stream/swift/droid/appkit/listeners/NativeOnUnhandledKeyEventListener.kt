package stream.swift.droid.appkit.listeners

import android.os.Build
import android.view.KeyEvent
import android.view.View
import androidx.annotation.RequiresApi

class NativeOnUnhandledKeyEventListener(private val uniqueId: Int, private val viewId: Int): View.OnUnhandledKeyEventListener {
    override fun onUnhandledKeyEvent(v: View?, event: KeyEvent?): Boolean {
        if (v != null) {
            if (event != null) {
                return onUnhandledKeyEventViewEvent(uniqueId, v.id == viewId, v.id, v, event)
            } else {
                return onUnhandledKeyEventView(uniqueId, v.id == viewId, v.id, v)
            }
        } else if (event != null) {
            return onUnhandledKeyEventEvent(uniqueId, event)
        } else {
            return onUnhandledKeyEvent(uniqueId)
        }
    }

    private external fun onUnhandledKeyEvent(uniqueId: Int): Boolean
    private external fun onUnhandledKeyEventView(uniqueId: Int, sameView: Boolean, vId: Int, v: View): Boolean
    private external fun onUnhandledKeyEventEvent(uniqueId: Int, event: KeyEvent): Boolean
    private external fun onUnhandledKeyEventViewEvent(uniqueId: Int, sameView: Boolean, vId: Int, v: View, event: KeyEvent): Boolean
}