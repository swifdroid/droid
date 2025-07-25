package stream.swift.droid.appkit.activities

import android.app.ComponentCaller
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import stream.swift.droid.appkit.DroidApp

open class DroidAppCompatActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnCreate(this)
    }

    override fun onPause() {
        super.onPause()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnPause(this)
    }

    override fun onStateNotSaved() {
        super.onStateNotSaved()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStateNotSaved(this)
    }

    override fun onResume() {
        super.onResume()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnResume(this)
    }

    override fun onRestart() {
        super.onRestart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnRestart(this)
    }

    override fun onStart() {
        super.onStart()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStart(this)
    }

    override fun onStop() {
        super.onStop()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnStop(this)
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnAttachedToWindow(this)
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        super.onBackPressed()
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnBackPressed(this)
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
        caller: ComponentCaller
    ) {
        super.onActivityResult(requestCode, resultCode, data, caller)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnActivityResult(this, requestCode, resultCode, data, caller)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val app: DroidApp = applicationContext as DroidApp
        app.activityOnActivityResult(this, requestCode, resultCode, data)
    }
}