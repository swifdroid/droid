package stream.swift.droid.appkit.listeners

import android.os.Build
import android.view.KeyEvent
import android.view.View
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.P)
class NativeOnUnhandledKeyEventListener: View.OnUnhandledKeyEventListener {
    external override fun onUnhandledKeyEvent(v: View?, event: KeyEvent?): Boolean
}