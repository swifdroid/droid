package stream.swift.droid.appkit.listeners

import android.view.KeyEvent
import android.view.View

class NativeOnKeyListener: View.OnKeyListener {
    external override fun onKey(v: View?, keyCode: Int, event: KeyEvent?): Boolean
}