package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnClickListener(private val uniqueId: Int, private val viewId: Int) : View.OnClickListener {
    override fun onClick(v: View) {
        onClick(uniqueId, v.id == viewId, v.id, v)
    }

    private external fun onClick(uniqueId: Int, sameView: Boolean, vId: Int, v: View)
}
