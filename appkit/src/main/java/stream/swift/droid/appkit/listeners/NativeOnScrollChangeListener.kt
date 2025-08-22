package stream.swift.droid.appkit.listeners

import android.view.View

class NativeOnScrollChangeListener(private val uniqueId: Int, private val viewId: Int): View.OnScrollChangeListener {
    override fun onScrollChange(
        v: View?,
        scrollX: Int,
        scrollY: Int,
        oldScrollX: Int,
        oldScrollY: Int,
    ) {
        if (v != null) {
            onScrollChangeExtended(uniqueId, v.id == viewId, v.id, v, scrollX, scrollY, oldScrollX, oldScrollY)
        } else {
            onScrollChange(uniqueId, scrollX, scrollY, oldScrollX, oldScrollY)
        }
    }

    private external fun onScrollChange(
        uniqueId: Int,
        scrollX: Int,
        scrollY: Int,
        oldScrollX: Int,
        oldScrollY: Int
    )

    private external fun onScrollChangeExtended(
        uniqueId: Int,
        sameView: Boolean,
        vId: Int,
        v: View,
        scrollX: Int,
        scrollY: Int,
        oldScrollX: Int,
        oldScrollY: Int
    )
}