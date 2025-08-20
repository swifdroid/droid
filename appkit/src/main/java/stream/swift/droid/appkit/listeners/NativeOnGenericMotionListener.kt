package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

    external override fun onGenericMotion(v: View?, event: MotionEvent?): Boolean
class NativeOnGenericMotionListener(private val uniqueId: Int, private val viewId: Int): View.OnGenericMotionListener {
}