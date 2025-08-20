package stream.swift.droid.appkit.listeners

import android.view.KeyEvent
import android.view.View

    external override fun onKey(v: View?, keyCode: Int, event: KeyEvent?): Boolean
class NativeOnKeyListener(private val uniqueId: Int, private val viewId: Int): View.OnKeyListener {
}