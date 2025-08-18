package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnClickListener(private val uniqueId: Int) : View.OnClickListener {
    override fun onClick(v: View) {
        onClick(uniqueId)
    }

    private external fun onClick(uniqueId: Int)
}
