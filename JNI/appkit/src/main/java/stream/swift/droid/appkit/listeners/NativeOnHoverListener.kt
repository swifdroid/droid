package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

class NativeOnHoverListener: View.OnHoverListener {
    external override fun onHover(v: View?, event: MotionEvent?): Boolean
}