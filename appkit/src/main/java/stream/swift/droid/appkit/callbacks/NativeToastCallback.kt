package stream.swift.droid.appkit.callbacks

import android.widget.Toast

class NativeToastCallback : Toast.Callback() {
    external override fun onToastShown()
    external override fun onToastHidden()
}