package stream.swift.droid.appkit

import android.app.Application
import android.app.ComponentCaller
import android.content.Intent
import android.content.res.Configuration
import android.os.Build

class DroidApp : Application() {
    companion object {
        init {
            System.loadLibrary("AppUI")
        }
    }

    override fun onCreate() {
        super.onCreate()
        initialize(this)
        _onConfigurationChanged(this.resources.configuration)
        onCreate(this)
    }
    private external fun initialize(caller: DroidApp)
    private external fun onCreate(caller: DroidApp)

    override fun onTerminate() {
        super.onTerminate()
        onTerminate(this)
    }
    private external fun onTerminate(caller: DroidApp)

    @Deprecated("Deprecated in Java")
    override fun onLowMemory() {
        super.onLowMemory()
        // since API 34 use onTrimMemory
        lowMemory()
    }
    private external fun lowMemory()

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)
        // brand new equivalent to onLowMemory
        trimMemory(level)
    }
    private external fun trimMemory(level: Int)

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        _onConfigurationChanged(newConfig)
    }

    private fun _onConfigurationChanged(newConfig: Configuration) {
        val metrics = resources.displayMetrics
        configurationChanged(
            intArrayOf(
                // Basic display metrics
                newConfig.orientation,
                newConfig.densityDpi,
                (newConfig.fontScale * 1000).toInt(),  // Fixed-point scaling
                newConfig.uiMode,
                // Screen dimensions
                newConfig.screenWidthDp,
                newConfig.screenHeightDp,
                newConfig.smallestScreenWidthDp,
                // Layout direction
                newConfig.layoutDirection,
                // Color mode
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) newConfig.colorMode else 0,
                // Touchscreen
                newConfig.touchscreen,
                // Keyboard/input
                newConfig.keyboard,
                newConfig.keyboardHidden,
                newConfig.hardKeyboardHidden,
                newConfig.navigation,
                newConfig.navigationHidden,
                // Misc flags
                newConfig.mcc,
                newConfig.mnc,
                newConfig.screenLayout,
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) newConfig.grammaticalGender else 0,
                // Display Metrics
                metrics.densityDpi,
                metrics.widthPixels,
                metrics.heightPixels,
                (metrics.xdpi * 1000).toInt(),
                (metrics.ydpi * 1000).toInt(),
                (metrics.density * 1000).toInt(),
                (metrics.scaledDensity * 1000).toInt()
            )
        )
    }
    private external fun configurationChanged(newConfig: IntArray)

    external fun activityOnCreate(activity: Any, uniqueId: Int)
    external fun activityOnPause(activityId: Int)
    external fun activityOnStateNotSaved(activityId: Int)
    external fun activityOnResume(activityId: Int)
    external fun activityOnRestart(activityId: Int)
    external fun activityOnStart(activityId: Int)
    external fun activityOnStop(activityId: Int)
    external fun activityOnDestroy(activityId: Int)
    external fun activityOnAttachedToWindow(activityId: Int)
    external fun activityOnBackPressed(activityId: Int)
    external fun activityOnActivityResult(
        activityId: Int,
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
        caller: ComponentCaller
    )
    external fun activityOnActivityResult(activityId: Int, requestCode: Int, resultCode: Int, data: Intent?)
}