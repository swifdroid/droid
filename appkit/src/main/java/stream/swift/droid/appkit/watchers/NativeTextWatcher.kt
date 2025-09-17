package stream.swift.droid.appkit.watchers

import android.text.Editable
import android.text.TextWatcher

class NativeTextWatcher(private val uniqueId: Int): TextWatcher {
    override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        if (p0 != null) {
            beforeTextChangedExtended(uniqueId, p0.toString(), p1, p2, p3)
        } else {
            beforeTextChanged(uniqueId, p1, p2, p3)
        }
    }
    override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        if (p0 != null) {
            onTextChangedExtended(uniqueId, p0.toString(), p1, p2, p3)
        } else {
            onTextChanged(uniqueId, p1, p2, p3)
        }
    }
    override fun afterTextChanged(p0: Editable?) {
        if (p0 != null) {
            afterTextChangedExtended(uniqueId, p0.toString())
        } else {
            afterTextChanged(uniqueId)
        }
    }

    private external fun beforeTextChanged(uniqueId: Int, p1: Int, p2: Int, p3: Int)
    private external fun beforeTextChangedExtended(uniqueId: Int, p0: String, p1: Int, p2: Int, p3: Int)
    private external fun onTextChanged(uniqueId: Int, p1: Int, p2: Int, p3: Int)
    private external fun onTextChangedExtended(uniqueId: Int, p0: String, p1: Int, p2: Int, p3: Int)
    private external fun afterTextChanged(uniqueId: Int)
    private external fun afterTextChangedExtended(uniqueId: Int, p0: String)
}