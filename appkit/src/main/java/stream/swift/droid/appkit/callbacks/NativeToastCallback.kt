package stream.swift.droid.appkit.callbacks

import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.R)
class NativeToastCallback(private val uniqueId: Int) : Toast.Callback() {
    override fun onToastShown() {
        onToastShown(uniqueId)
    }
    override fun onToastHidden() {
        onToastHidden(uniqueId)
    }

    private external fun onToastShown(uniqueId: Int)
    private external fun onToastHidden(uniqueId: Int)
}