package stream.swift.droid.appkit.listeners

import android.os.Build
import android.view.ContentInfo
import android.view.OnReceiveContentListener
import android.view.View
import androidx.annotation.RequiresApi

@RequiresApi(Build.VERSION_CODES.S)
class NativeOnReceiveContentListener(private val uniqueId: Int, private val viewId: Int):
    OnReceiveContentListener {
    override fun onReceiveContent(view: View, payload: ContentInfo): ContentInfo? {
        return onReceiveContent(uniqueId, view.id == viewId, view.id, view, payload)
    }

    private external fun onReceiveContent(uniqueId: Int, sameView: Boolean, vId: Int, view: View, payload: ContentInfo): ContentInfo?
}