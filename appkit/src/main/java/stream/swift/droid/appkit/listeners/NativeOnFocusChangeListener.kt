package stream.swift.droid.appkit.listeners

import android.view.View

    external override fun onFocusChange(v: View?, hasFocus: Boolean)
class NativeOnFocusChangeListener(private val uniqueId: Int, private val viewId: Int): View.OnFocusChangeListener {
}