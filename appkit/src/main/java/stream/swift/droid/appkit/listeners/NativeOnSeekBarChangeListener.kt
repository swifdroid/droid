package stream.swift.droid.appkit.listeners

import android.widget.SeekBar

class NativeOnSeekBarChangeListener: SeekBar.OnSeekBarChangeListener {
    external override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean)
    external override fun onStartTrackingTouch(p0: SeekBar?)
    external override fun onStopTrackingTouch(p0: SeekBar?)
}