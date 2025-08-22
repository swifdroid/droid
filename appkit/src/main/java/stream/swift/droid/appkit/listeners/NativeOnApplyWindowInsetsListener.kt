package stream.swift.droid.appkit.listeners

import android.view.View
import android.view.WindowInsets

class NativeOnApplyWindowInsetsListener(private val uniqueId: Int, private val viewId: Int): View.OnApplyWindowInsetsListener {
    override fun onApplyWindowInsets(v: View, insets: WindowInsets): WindowInsets {
        return onApplyWindowInsets(uniqueId, v.id == viewId, v.id, v, insets)
    }

    private external fun onApplyWindowInsets(uniqueId: Int, sameView: Boolean, vId: Int, v: View, insets: WindowInsets): WindowInsets
}