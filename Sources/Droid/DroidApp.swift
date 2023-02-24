//
//  DroidApp.swift
//  Droid
//
//  Created by Mihael Isaev on 26.10.2021.
//

import Foundation
import DroidFoundation

private var droidApp: DroidApp!

open class DroidApp {
    public typealias Content = AppBuilder.Content
    public typealias Lifecycle = AppLifecycle
	public typealias Manifest = AppManifest
    
    public static func main() {
        Self.start()
    }
    
    private var isStarted = false
    
    public static var shared: DroidApp {
        #if ANDROIDPREVIEW
        guard droidApp == nil else {
            return droidApp
        }
        droidApp = DroidApp.start()
        return droidApp
        #else
        return droidApp
        #endif
    }
    public class var current: Self { shared as! Self }
    
    required public init () {}

    deinit {}
    
    @discardableResult
    public static func start() -> DroidApp {
        guard droidApp == nil else { return droidApp }
        droidApp = Self()
        guard !droidApp.isStarted else { return droidApp }
        droidApp.isStarted = true
        #if ANDROIDPREVIEW
        droidApp.previewStart()
        #else
        droidApp.start()
        #endif
        return droidApp
    }
    
    private func start() {
        parseAppBuilderItem(body.appBuilderContent)
//        lifecycleHandler.add(.enterForeground) { self._lifecycles.forEach { $0._willEnterForeground.forEach { $0() } } }
//        lifecycleHandler.add(.enterBackground) { self._lifecycles.forEach { $0._didEnterBackground.forEach { $0() } } }
//        launched(activities.current)
    }
    
    @AppBuilder open var body: AppBuilder.Content { _AppContent(appBuilderContent: .none) }
    
    var _lifecycles: [AppLifecycle] = []
//    public private(set) lazy var activities: Activities = Activities()

    private func parseAppBuilderItem(_ item: AppBuilder.Item) {
        switch item {
        case .items(let v): v.forEach { parseAppBuilderItem($0) }
        case .lifecycle(let v): _lifecycles.append(v)
		case .manifest(_): break
//        case .activities(let v): activities = v
        case .none: break
        }
    }
}

// MARK: - Core-context Functions

extension DroidApp {
    
    
//    public func showToast(_ text: String, _ length: ToastLength = .short) {
//        coreContext.showToast(text, length.rawValue)
//    }
//
//    func launched(_ activity: Activity) {
//        _lifecycles.forEach { $0._didFinishLaunching.forEach { $0() } }
//        coreContext.launched(activity)
//    }
}

class LifecycleHandler {
//    private let context: JSObject
//
//    var closures: [String: JSClosure] = [:]
//
//    init (_ global: JSObject) {
//        let dict: [String: String] = [:]
//        context = dict.jsValue().object!
//        global.lifecycle = context.jsValue()
//    }
//
//    deinit {
//        closures.forEach { $0.value.release() }
//    }
//
//    enum Event: String {
//        case enterForeground, enterBackground
//    }
//
//    func add(_ event: Event, _ action: @escaping () -> Void) {
//        closures[event.rawValue] = JSClosure { args in
//            return JSPromise(resolver: { handler in
//                action()
//                handler(.success(.undefined))
//            }).jsValue()
//        }
//        context[event.rawValue] = closures[event.rawValue]?.jsValue() ?? .null
//    }
}

public enum ToastLength: Int {
    case short = 0, long
}

class CoreContext {
//    private let context: JSObject
//
//    init (_ global: JSObject) {
//        context = global.core.object!
//    }
//
//    func launched(_ activity: Activity) {
//        guard let json = activity.model.json() else { return }
//        context.launched.function?.callAsFunction(this: context, json)
//    }
//
//    func showToast(_ text: String, _ length: Int = 0) {
//        if length == 0 {
//            context.showToastShort.function?.callAsFunction(this: context, text)
//        } else {
//            context.showToastLong.function?.callAsFunction(this: context, text)
//        }
//    }
}
