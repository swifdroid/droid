package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnLongClickListener(private val uniqueId: Int): View.OnLongClickListener {
    override fun onLongClick(v: View?): Boolean {
        return onLongClick(uniqueId)
    }

    private external fun onLongClick(uniqueId: Int): Boolean
}