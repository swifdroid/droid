package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnSystemUiVisibilityChangeListener(private val uniqueId: Int): View.OnSystemUiVisibilityChangeListener {
    @Deprecated("Deprecated in Java")
    external override fun onSystemUiVisibilityChange(visibility: Int)
}