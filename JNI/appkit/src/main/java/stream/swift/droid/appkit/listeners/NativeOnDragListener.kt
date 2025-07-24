package stream.swift.droid.appkit.listeners

import android.view.DragEvent
import android.view.View

class NativeOnDragListener: View.OnDragListener {
    external override fun onDrag(v: View?, event: DragEvent?): Boolean
}