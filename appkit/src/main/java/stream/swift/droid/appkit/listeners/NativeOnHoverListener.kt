package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

    external override fun onHover(v: View?, event: MotionEvent?): Boolean
class NativeOnHoverListener(private val uniqueId: Int, private val viewId: Int): View.OnHoverListener {
}