package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnFocusChangeListener: View.OnFocusChangeListener {
    external override fun onFocusChange(v: View?, hasFocus: Boolean)
}