package stream.swift.droid.appkit.views

import android.animation.Animator
import android.content.Context
import android.os.Bundle
import android.view.ContextMenu
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.view.animation.Animation
import androidx.fragment.app.Fragment

class NativeFragment(private val uniqueId: Int): Fragment() {
    override fun onAttach(context: Context) {
        super.onAttach(context)
        onAttach(uniqueId, context)
    }
    private external fun onAttach(uniqueId: Int, context: Context)

    override fun onContextItemSelected(item: MenuItem): Boolean {
        return onContextItemSelected(uniqueId, item)
    }
    private external fun onContextItemSelected(uniqueId: Int, item: MenuItem): Boolean

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

    override fun onCreateAnimation(transit: Int, enter: Boolean, nextAnim: Int): Animation? {
        return onCreateAnimation(uniqueId, transit, enter, nextAnim)
    }
    private external fun onCreateAnimation(uniqueId: Int, transit: Int, enter: Boolean, nextAnim: Int): Animation?

    override fun onCreateAnimator(transit: Int, enter: Boolean, nextAnim: Int): Animator? {
        return onCreateAnimator(uniqueId, transit, enter, nextAnim)
    }
    private external fun onCreateAnimator(uniqueId: Int, transit: Int, enter: Boolean, nextAnim: Int): Animator?

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

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        if (container != null) {
            if (savedInstanceState != null) {
                return onCreateViewContainerSavedInstanceState(uniqueId, inflater, container, savedInstanceState)
            } else {
                return onCreateViewContainer(uniqueId, inflater, container)
            }
        } else if (savedInstanceState != null) {
            return onCreateViewSavedInstanceState(uniqueId, inflater, savedInstanceState)
        } else {
            return onCreateView(uniqueId, inflater)
        }
    }
    private external fun onCreateView(uniqueId: Int, inflater: LayoutInflater): View?
    private external fun onCreateViewContainer(uniqueId: Int, inflater: LayoutInflater, container: ViewGroup): View?
    private external fun onCreateViewSavedInstanceState(uniqueId: Int, inflater: LayoutInflater, savedInstanceState: Bundle): View?
    private external fun onCreateViewContainerSavedInstanceState(uniqueId: Int, inflater: LayoutInflater, container: ViewGroup, savedInstanceState: Bundle): View?

    override fun onDestroy() {
        super.onDestroy()
        onDestroy(uniqueId)
    }
    private external fun onDestroy(uniqueId: Int)

    override fun onDestroyView() {
        super.onDestroyView()
        onDestroyView(uniqueId)
    }
    private external fun onDestroyView(uniqueId: Int)

    override fun onDetach() {
        super.onDetach()
        onDetach(uniqueId)
    }
    private external fun onDetach(uniqueId: Int)

//    override fun onGetLayoutInflater(savedInstanceState: Bundle?): LayoutInflater { // NOT SURE HOW TO IMPLEMENT IT
//        if (savedInstanceState != null) {
//            return onGetLayoutInflater(uniqueId, savedInstanceState)
//        } else {
//            return onGetLayoutInflater(uniqueId)
//        }
//    }
//    private external fun onGetLayoutInflater(uniqueId: Int): LayoutInflater
//    private external fun onGetLayoutInflater(uniqueId: Int, savedInstanceState: Bundle): LayoutInflater

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