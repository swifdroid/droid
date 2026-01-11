package stream.swift.droid.appkit.listeners

import android.app.ActionBar

class NativeActionBarOnMenuVisibilityListener(private val uniqueId: Int): ActionBar.OnMenuVisibilityListener {
    override fun onMenuVisibilityChanged(isVisible: Boolean) {
        onMenuVisibilityChanged(uniqueId, isVisible)
    }

    private external fun onMenuVisibilityChanged(uniqueId: Int, isVisible: Boolean)
}