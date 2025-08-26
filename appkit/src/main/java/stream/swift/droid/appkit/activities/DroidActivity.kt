package stream.swift.droid.appkit.activities

import android.app.Activity
import android.app.ComponentCaller
import android.content.Intent
import android.os.Bundle
import android.view.View
import stream.swift.droid.appkit.DroidApp

open class DroidActivity: Activity() {
    private val uniqueId by lazy { View.generateViewId() }
    private var isStopping = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnCreate(this, uniqueId)
    }

    override fun onPause() {
        super.onPause()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnPause(uniqueId)
    }

    override fun onStateNotSaved() {
        super.onStateNotSaved()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStateNotSaved(uniqueId)
    }

    override fun onResume() {
        super.onResume()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnResume(uniqueId)
    }

    override fun onRestart() {
        super.onRestart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnRestart(uniqueId)
    }

    override fun onStart() {
        super.onStart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStart(uniqueId)
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
}