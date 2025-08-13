package stream.swift.droid.appkit.adapters

import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

class NativeRecyclerViewAdapter(private val nativeId: Int) : RecyclerView.Adapter<NativeRecyclerViewHolder>() {
    private external fun nativeItemsCount(nativeId: Int): Int
    private external fun nativeOnCreateViewHolder(nativeId: Int, parent: ViewGroup, viewType: Int): NativeRecyclerViewHolder
    private external fun nativeOnBindViewHolder(nativeId: Int, holderId: Int, holder: NativeRecyclerViewHolder, position: Int)
    private external fun nativeGetItemViewType(nativeId: Int, position: Int): Int

    override fun getItemCount(): Int {
        return nativeItemsCount(nativeId)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NativeRecyclerViewHolder {
        return nativeOnCreateViewHolder(nativeId, parent, viewType)
    }

    override fun onBindViewHolder(holder: NativeRecyclerViewHolder, position: Int) {
        nativeOnBindViewHolder(nativeId, holder.nativeId, holder, position)
    }

    override fun getItemViewType(position: Int): Int {
        return nativeGetItemViewType(nativeId, position)
    }
}