package stream.swift.droid.appkit.views

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.ContextMenu
import android.view.MenuItem
import android.view.View
import androidx.navigation.fragment.NavHostFragment

class NativeNavHostFragment(): NavHostFragment() {
    private val uniqueId: Int
        get() = requireArguments().getInt(UNIQUE_ID_KEY)

    companion object {
        private const val UNIQUE_ID_KEY = "UNIQUE_ID"

        @JvmStatic
        fun newInstance(uniqueId: Int): NativeNavHostFragment {
            Log.d("NativeNavHostFragment", "nativeFragment static newInstance uniqueId: $uniqueId")
            val fragment = NativeNavHostFragment()
            val args = Bundle()
            args.putInt(UNIQUE_ID_KEY, uniqueId)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState != null) {
            onCreateSavedInstanceState(uniqueId, savedInstanceState)
        } else {
            onCreate(uniqueId)
        }
    }
    private external fun onCreate(uniqueId: Int)
    private external fun onCreateSavedInstanceState(uniqueId: Int, savedInstanceState: Bundle)

    override fun onAttach(context: Context) {
        super.onAttach(context)
        onAttach(uniqueId, context)
    }
    private external fun onAttach(uniqueId: Int, context: Context)

    override fun onContextItemSelected(item: MenuItem): Boolean {
        return onContextItemSelected(uniqueId, item)
    }
    private external fun onContextItemSelected(uniqueId: Int, item: MenuItem): Boolean

    // onCreateAnimation should be handled by the original NavHostFragment, it is too fragile to touch
    // onCreateAnimator should be handled by the original NavHostFragment, it is too fragile to touch

    override fun onCreateContextMenu(
        menu: ContextMenu,
        v: View,
        menuInfo: ContextMenu.ContextMenuInfo?
    ) {
        if (menuInfo != null) {
            onCreateContextMenuWithInfo(uniqueId, menu, v, menuInfo)
        } else {
            onCreateContextMenu(uniqueId, menu, v)
        }
    }
    private external fun onCreateContextMenu(uniqueId: Int, menu: ContextMenu, v: View)
    private external fun onCreateContextMenuWithInfo(uniqueId: Int, menu: ContextMenu, v: View, menuInfo: ContextMenu.ContextMenuInfo)

    // onCreateView should always be handled by the original NavHostFragment

    override fun onDestroy() {
        super.onDestroy()
        onDestroy(uniqueId)
    }
    private external fun onDestroy(uniqueId: Int)

    // onDestroyView should always be handled by the original NavHostFragment

    override fun onDetach() {
        super.onDetach()
        onDetach(uniqueId)
    }
    private external fun onDetach(uniqueId: Int)

    // onGetLayoutInflater should be handled by the original NavHostFragment

    override fun onHiddenChanged(hidden: Boolean) {
        onHiddenChanged(uniqueId, hidden)
    }
    private external fun onHiddenChanged(uniqueId: Int, hidden: Boolean)

    override fun onMultiWindowModeChanged(isInMultiWindowMode: Boolean) {
        onMultiWindowModeChanged(uniqueId, isInMultiWindowMode)
    }
    private external fun onMultiWindowModeChanged(uniqueId: Int, isInMultiWindowMode: Boolean)

    override fun onPause() {
        super.onPause()
        onPause(uniqueId)
    }
    private external fun onPause(uniqueId: Int)

    override fun onPictureInPictureModeChanged(isInPictureInPictureMode: Boolean) {
        onPictureInPictureModeChanged(uniqueId, isInPictureInPictureMode)
    }
    private external fun onPictureInPictureModeChanged(uniqueId: Int, isInPictureInPictureMode: Boolean)

    override fun onPrimaryNavigationFragmentChanged(isPrimaryNavigationFragment: Boolean) {
        onPrimaryNavigationFragmentChanged(uniqueId, isPrimaryNavigationFragment)
    }
    private external fun onPrimaryNavigationFragmentChanged(uniqueId: Int, isPrimaryNavigationFragment: Boolean)

    override fun onResume() {
        super.onResume()
        onResume(uniqueId)
    }
    private external fun onResume(uniqueId: Int)

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        onSaveInstanceState(uniqueId, outState)
    }
    private external fun onSaveInstanceState(uniqueId: Int, outState: Bundle)

    override fun onStart() {
        super.onStart()
        onStart(uniqueId)
    }
    private external fun onStart(uniqueId: Int)

    override fun onStop() {
        super.onStop()
        onStop(uniqueId)
    }
    private external fun onStop(uniqueId: Int)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        if (savedInstanceState != null) {
            onViewCreatedSavedInstanceState(uniqueId, view, savedInstanceState)
        } else {
            onViewCreated(uniqueId, view)
        }
    }
    private external fun onViewCreated(uniqueId: Int, view: View)
    private external fun onViewCreatedSavedInstanceState(uniqueId: Int, view: View, savedInstanceState: Bundle)

    override fun onViewStateRestored(savedInstanceState: Bundle?) {
        super.onViewStateRestored(savedInstanceState)
        if (savedInstanceState != null) {
            onViewStateRestoredSavedInstanceState(uniqueId, savedInstanceState)
        } else {
            onViewStateRestored(uniqueId)
        }
    }
    private external fun onViewStateRestored(uniqueId: Int)
    private external fun onViewStateRestoredSavedInstanceState(uniqueId: Int, savedInstanceState: Bundle)
}