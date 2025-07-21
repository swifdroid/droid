#if canImport(Android)
import Android
#if canImport(AndroidLogging)
import AndroidLogging
#endif
#if canImport(AndroidLooper)
import AndroidLooper
#endif
#endif
#if canImport(Logging)
import Logging
#endif

#if os(Android)
@_cdecl("Java_com_somebody_appui_SwiftApp_activityOnCreate")
public func activityLoaded(envPointer: UnsafeMutablePointer<JNIEnv?>, appObject: jobject, callerObject localCallerObjectRef: jobject) {
    let logger = Logger(label: "🐦‍🔥 SWIFT")
    logger.info("🚀 Hello World!")
    let localEnv = JEnv(envPointer)
    let globalCallerObj = localCallerObjectRef.box(localEnv)
    if let _ = localEnv.findClass(.android.view.ViewGroup) {
        logger.info("🚀 main: ViewGroup FOUND")
    } else {
        logger.info("🚀 main: ViewGroup NOT FOUND")
    }
    if let context = globalCallerObj?.object() {
        logger.info("context class: \(context.className.name)")
        logger.info("activities count: \(DroidApp.shared._activities.count)")
        if let activityType = DroidApp.shared._activities.first(where: { $0.className == context.className.name }) {
            logger.info("activity found")
            #if canImport(AndroidLooper)
            Task.detached { @UIThreadActor in
                _ = activityType.init(object: context)
            }
            #endif
        }
        // guard let activity = AppCompatActivity(context) else {
        //     logger.info("0.1")
        //     return
        // }
        // logger.info("00")
        // Task {
        //     logger.info("1")
        //     guard let context = globalCallerObj?.object() else { logger.info("1.1");return }
        //     logger.info("2")
        //     // await helloUI(context)
        //     if let activity = AppCompatActivity(context) {
        //         logger.info("3")
        //     //     logger.info("🟢 Activity is here")
        //     //     if let view = View(activity.object) {
        //     //         logger.info("🟢 View is here")
        //     //         activity.setContentView(view.object)
        //     //         logger.info("🟢 Successfully set View into Activity")
        //     //         view.setBackgroundColor(.aqua)
        //     //         logger.info("🟢 Successfully set View's color")
        //     //         if let c = localEnv.findClass(.android.view.ViewGroup) {
        //     //             logger.info("🚀 main: ViewGroup FOUND")
        //     //         } else {
        //     //             logger.info("🚀 main: ViewGroup NOT FOUND")
        //     //         }
        //     //         if let c = localEnv.findClass(.swift.view.OnClickListener) {
        //     //             logger.info("🚀 main: OnClickListener FOUND")
        //     //         } else {
        //     //             logger.info("🚀 main: OnClickListener NOT FOUND")
        //     //         }
        //     //         Task {
        //     //             // guard let env = JNIKit.shared.vm.attachCurrentThread() else {
        //     //             //     logger.info("❌ Unable to attachCurrentThread")
        //     //             //     return
        //     //             // }
        //     //             // logger.info("🚀 class task: jni version: \(env.getVersionString())")                        
        //     //             // if let c = env.findClass(.android.view.ViewGroup) {
        //     //             //     logger.info("🚀 class task: ViewGroup FOUND")
        //     //             // } else {
        //     //             //     logger.info("🚀 class task: ViewGroup NOT FOUND")
        //     //             // }
        //     //             // if let c = env.findClass(.swift.view.OnClickListener) {
        //     //             //     logger.info("🚀 class task: OnClickListener FOUND")
        //     //             // } else {
        //     //             //     logger.info("🚀 class task: OnClickListener NOT FOUND")
        //     //             // }
        //     //             guard let clickListener = await NativeOnClickListener(activity) else {
        //     //                 logger.info("🟢 ClickListener2 NOT initialized")
        //     //                 return
        //     //             }
        //     //             clickListener.onClick {
        //     //                 view.setBackgroundColor(.teal)
        //     //             }
        //     //             view.setOnClickListener(clickListener)
        //     //         }
        //     //     } else {
        //     //         logger.info("💧 Unable to init view")
        //     //     }
        //     } else {
        //         logger.info("💧 Unable to init activity")
        //     }
        // }
    } else {
        logger.info("💧 Unable to init context")
    }
    // Task {
    //     guard let env = JNIKit.shared.vm.attachCurrentThread() else { return }
    //     logger.info("🚀 new env: \(env)")
    //     logger.info("🚀 jni version: \(env.getVersionString())")
    //     let callerDescription = callerObj?.object()?.toString()
    //     logger.info("🚀 caller description: \(callerDescription ?? "n/a")")
    // }
}

// @UIThreadActor
// func helloUI(_ context: JObject) {
//     let logger = Logger(label: "🐦‍🔥 SWIFT")
//     guard let activity = AppCompatActivity(context) else { return }
//     logger.info("🟢 Activity is here")
//     guard let view = View(activity.object) else { return }
//     logger.info("🟢 View is here")
//     activity.setContentView(view.object)
//     view.setBackgroundColor(.aqua)
//     logger.info("🟢 Successfully set View's color")
//     Task {
//         guard let clickListener = await NativeOnClickListener(activity) else {
//             logger.info("🟢 ClickListener2 NOT initialized")
//             return
//         }
//         clickListener.onClick {
//             view.setBackgroundColor(.teal)
//         }
//         view.setOnClickListener(clickListener)
//     }
// }
#endif