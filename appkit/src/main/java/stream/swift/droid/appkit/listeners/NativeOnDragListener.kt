package stream.swift.droid.appkit.listeners

import android.view.DragEvent
import android.view.View

    external override fun onDrag(v: View?, event: DragEvent?): Boolean
class NativeOnDragListener(private val uniqueId: Int, private val viewId: Int): View.OnDragListener {
}