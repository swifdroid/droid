package stream.swift.droid.appkit.listeners

import android.text.Editable
import android.text.TextWatcher

class NativeTextWatcher: TextWatcher {
    external override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int)
    external override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int)
    external override fun afterTextChanged(p0: Editable?)
}