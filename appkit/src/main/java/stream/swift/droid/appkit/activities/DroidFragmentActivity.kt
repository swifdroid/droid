package stream.swift.droid.appkit.activities

import android.app.ComponentCaller
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.AttributeSet
import android.view.Menu
import android.view.MenuItem
import android.view.View
import androidx.fragment.app.FragmentActivity
import stream.swift.droid.appkit.DroidApp

open class DroidFragmentActivity: FragmentActivity() {
    @Suppress("PrivatePropertyName")
    private val UNIQUE_ID_KEY = "UNIQUE_ID"

    protected var uniqueId: Int = 0
        private set
    private var isStopping = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val app: DroidApp = applicationContext as DroidApp
        if (savedInstanceState != null) {
            uniqueId = savedInstanceState.getInt(UNIQUE_ID_KEY, 0)
            if (uniqueId == 0) {
                throw IllegalStateException("DroidFragmentActivity: UNIQUE_ID wasn't saved properly")
            }
            app.activityOnCreateSavedInstanceState(this, uniqueId, savedInstanceState)
        } else {
            uniqueId = View.generateViewId()
            app.activityOnCreate(this, uniqueId)
        }
    }

    override fun onPause() {
        super.onPause()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnPause(uniqueId)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt(UNIQUE_ID_KEY, uniqueId)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnSaveInstanceState(uniqueId, outState)
    }

    @Deprecated("Deprecated in Java")
    override fun onStateNotSaved() {
        super.onStateNotSaved()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStateNotSaved(uniqueId)
    }

    override fun onResume() {
        super.onResume()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnResume(this, uniqueId)
    }

    override fun onPostResume() {
        super.onPostResume()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnPostResume(this, uniqueId)
    }

    override fun onRestart() {
        super.onRestart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnRestart(this, uniqueId)
    }

    override fun onStart() {
        super.onStart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStart(this, uniqueId)
        isStopping = false
    }

    override fun onStop() {
        super.onStop()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStop(uniqueId)
        isStopping = true
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isFinishing && isStopping) {
            val app: DroidApp = applicationContext as DroidApp
            app.activityOnDestroy(uniqueId)
        }
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnAttachedToWindow(uniqueId)
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        super.onBackPressed()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnBackPressed(uniqueId)
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
        caller: ComponentCaller
    ) {
        super.onActivityResult(requestCode, resultCode, data, caller)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnActivityResult1(uniqueId, requestCode, resultCode, data, caller)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnActivityResult2(uniqueId, requestCode, resultCode, data)
    }

    // MARK: Fragment related

    override fun onCreatePanelMenu(featureId: Int, menu: Menu): Boolean {
        return super.onCreatePanelMenu(featureId, menu)
    }

    override fun onCreateView(name: String, context: Context, attrs: AttributeSet): View? {
        return super.onCreateView(name, context, attrs)
    }

    override fun onCreateView(
        parent: View?,
        name: String,
        context: Context,
        attrs: AttributeSet
    ): View? {
        return super.onCreateView(parent, name, context, attrs)
    }

    override fun onMenuItemSelected(featureId: Int, item: MenuItem): Boolean {
        return super.onMenuItemSelected(featureId, item)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
        deviceId: Int
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults, deviceId)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        super.onCreateOptionsMenu(menu)
        val app: DroidApp = applicationContext as DroidApp
        return app.activityOnCreateOptionsMenu(uniqueId, menu)
    }

    override fun onPrepareOptionsMenu(menu: Menu?): Boolean {
        super.onPrepareOptionsMenu(menu)
        val app: DroidApp = applicationContext as DroidApp
        return app.activityOnPrepareOptionsMenu(uniqueId, menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        super.onOptionsItemSelected(item)
        val app: DroidApp = applicationContext as DroidApp
        return app.activityOnOptionsItemSelected(uniqueId, item)
    }

    override fun onOptionsMenuClosed(menu: Menu?) {
        super.onOptionsMenuClosed(menu)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnOptionsMenuClosed(uniqueId, menu)
    }
}