package stream.swift.droid.appkit.providers

import android.view.Menu
import android.view.MenuInflater
import android.view.MenuItem
import androidx.core.view.MenuProvider

class NativeMenuProvider(private val uniqueId: Int): MenuProvider {
    override fun onCreateMenu(menu: Menu, menuInflater: MenuInflater) {
        onCreateMenu(uniqueId, menu, menuInflater)
    }

    override fun onPrepareMenu(menu: Menu) {
        onPrepareMenu(uniqueId, menu)
    }

    override fun onMenuItemSelected(menuItem: MenuItem): Boolean {
        return onMenuItemSelected(uniqueId, menuItem)
    }

    override fun onMenuClosed(menu: Menu) {
        onMenuClosed(uniqueId, menu)
    }

    private external fun onCreateMenu(uniqueId: Int, menu: Menu, menuInflater: MenuInflater)
    private external fun onPrepareMenu(uniqueId: Int, menu: Menu)
    private external fun onMenuItemSelected(uniqueId: Int, menuItem: MenuItem): Boolean
    private external fun onMenuClosed(uniqueId: Int, menu: Menu)
}