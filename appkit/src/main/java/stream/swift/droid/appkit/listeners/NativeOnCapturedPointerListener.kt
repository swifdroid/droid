package stream.swift.droid.appkit.listeners

import android.os.Build
import android.view.MotionEvent
import android.view.View
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.O)
class NativeOnCapturedPointerListener(private val uniqueId: Int, private val viewId: Int): View.OnCapturedPointerListener {
    override fun onCapturedPointer(view: View?, event: MotionEvent?): Boolean {
        if (view != null) {
            if (event != null) {
                return onCapturedPointerViewEvent(uniqueId, view.id == viewId, view, event)
            } else {
                return onCapturedPointerView(uniqueId, view.id == viewId, view)
            }
        } else if (event != null) {
            return onCapturedPointerEvent(uniqueId, event)
        } else {
            return onCapturedPointer(uniqueId)
        }
    }

    private external fun onCapturedPointer(uniqueId: Int): Boolean
    private external fun onCapturedPointerView(uniqueId: Int, sameView: Boolean, view: View): Boolean
    private external fun onCapturedPointerEvent(uniqueId: Int, event: MotionEvent): Boolean
    private external fun onCapturedPointerViewEvent(uniqueId: Int, sameView: Boolean, view: View, event: MotionEvent): Boolean
}