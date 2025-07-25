package stream.swift.droid.appkit.listeners

import android.view.View
import android.view.WindowInsets

class NativeOnApplyWindowInsetsListener: View.OnApplyWindowInsetsListener {
    external override fun onApplyWindowInsets(v: View, insets: WindowInsets): WindowInsets
}