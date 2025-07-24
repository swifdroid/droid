package stream.swift.droid.appkit.listeners

import android.view.MotionEvent
import android.view.View

class NativeOnGenericMotionListener: View.OnGenericMotionListener {
    external override fun onGenericMotion(v: View?, event: MotionEvent?): Boolean
}