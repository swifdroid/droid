package stream.swift.droid.appkit.listeners

import android.widget.SeekBar

class NativeOnSeekBarChangeListener(private val uniqueId: Int): SeekBar.OnSeekBarChangeListener {
    override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean) {
        if (p0 != null) {
            onProgressChangedExtended(uniqueId, p0, p1, p2)
        } else {
            onProgressChanged(uniqueId, p1, p2)
        }
    }
    override fun onStartTrackingTouch(p0: SeekBar?) {
        if (p0 != null) {
            onStartTrackingTouchExtended(uniqueId, p0)
        } else {
            onStartTrackingTouch(uniqueId)
        }
    }
    override fun onStopTrackingTouch(p0: SeekBar?) {
        if (p0 != null) {
            onStopTrackingTouchExtended(uniqueId, p0)
        } else {
            onStopTrackingTouch(uniqueId)
        }
    }

    private external fun onProgressChanged(uniqueId: Int, p1: Int, p2: Boolean)
    private external fun onProgressChangedExtended(uniqueId: Int, p0: SeekBar, p1: Int, p2: Boolean)
    private external fun onStartTrackingTouch(uniqueId: Int)
    private external fun onStartTrackingTouchExtended(uniqueId: Int, p0: SeekBar)
    private external fun onStopTrackingTouch(uniqueId: Int)
    private external fun onStopTrackingTouchExtended(uniqueId: Int, p0: SeekBar)
}