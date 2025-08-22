package stream.swift.droid.appkit.listeners;

import android.view.View
import androidx.core.view.ContentInfoCompat
import androidx.core.view.OnReceiveContentListener

public class NativeOnReceiveContentCompatListener(private val uniqueId: Int, private val viewId: Int):
OnReceiveContentListener {
    override fun onReceiveContent(view: View, payload: ContentInfoCompat): ContentInfoCompat? {
        return onReceiveContent(uniqueId, view.id == viewId, view.id, view, payload)
    }

    private external fun onReceiveContent(uniqueId: Int, sameView: Boolean, vId: Int, view: View, payload: ContentInfoCompat): ContentInfoCompat?
}
