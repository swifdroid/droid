package stream.swift.droid.appkit.listeners

import android.view.View
import androidx.core.view.OnApplyWindowInsetsListener
import androidx.core.view.WindowInsetsCompat

class NativeOnApplyWindowInsetsCompatListener(private val uniqueId: Int, private val viewId: Int): OnApplyWindowInsetsListener {
    override fun onApplyWindowInsets(v: View, insets: WindowInsetsCompat): WindowInsetsCompat {
        return onApplyWindowInsets(uniqueId, v.id == viewId, v.id, v, insets)
    }

    private external fun onApplyWindowInsets(uniqueId: Int, sameView: Boolean, vId: Int, v: View, insets: WindowInsetsCompat): WindowInsetsCompat
}