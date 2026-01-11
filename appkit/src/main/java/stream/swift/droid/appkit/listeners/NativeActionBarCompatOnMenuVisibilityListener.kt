package stream.swift.droid.appkit.listeners

import androidx.appcompat.app.ActionBar

class NativeActionBarCompatOnMenuVisibilityListener(private val uniqueId: Int): ActionBar.OnMenuVisibilityListener {
    override fun onMenuVisibilityChanged(isVisible: Boolean) {
        onMenuVisibilityChanged(uniqueId, isVisible)
    }

    private external fun onMenuVisibilityChanged(uniqueId: Int, isVisible: Boolean)
}