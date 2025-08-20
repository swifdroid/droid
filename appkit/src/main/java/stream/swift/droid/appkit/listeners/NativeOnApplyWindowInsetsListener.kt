package stream.swift.droid.appkit.listeners

import android.view.View
import android.view.WindowInsets

    external override fun onApplyWindowInsets(v: View, insets: WindowInsets): WindowInsets
class NativeOnApplyWindowInsetsListener(private val uniqueId: Int, private val viewId: Int): View.OnApplyWindowInsetsListener {
}