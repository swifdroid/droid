package stream.swift.droid.appkit.listeners

import android.annotation.SuppressLint
import android.view.MotionEvent
import android.view.View

class NativeOnTouchListener(private val uniqueId: Int, private val viewId: Int): View.OnTouchListener {
    @SuppressLint("ClickableViewAccessibility")
    external override fun onTouch(v: View?, event: MotionEvent?): Boolean
}