package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnSystemUiVisibilityChangeListener(private val uniqueId: Int): View.OnSystemUiVisibilityChangeListener {
    @Deprecated("Deprecated in Java")
    override fun onSystemUiVisibilityChange(visibility: Int) {
        onSystemUiVisibilityChange(uniqueId, visibility)
    }

    private external fun onSystemUiVisibilityChange(uniqueId: Int, visibility: Int)
}