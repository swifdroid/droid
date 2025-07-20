//
//  AppCompatActivity.swift
//  
//
//  Created by Mihael Isaev on 25.02.2023.
//

import DroidFoundation
#if canImport(AndroidLooper)
import AndroidLooper
#endif

extension AndroidPackage.SupportPackage.V7Package.AppPackage {
    public class AppCompatPackage: JClassName, @unchecked Sendable {}
    
    public var AppCompatActivity: AppCompatPackage { .init(parent: self, name: "AppCompatActivity") }
}

public struct ActivityContext: JObjectable, JClassLoadable, Sendable {
    public let object: JObject
}

#if os(Android)
extension AppCompatActivity: Sendable {}
#else
extension AppCompatActivity: @unchecked Sendable {}
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
open class AppCompatActivity: Activity {
    public class var className: JClassName { .init(stringLiteral: "androidx/appcompat/app/AppCompatActivity") }
    public class var requiredImports: [String] { ["android.support.v7.app.AppCompatActivity"] }
    public class var parentClass: String { "AppCompatActivity()" }

    public let context: ActivityContext
    public var contentView: View?

    public required init(object: JObject) {
        context = ActivityContext(object: object)
        onCreate(context)
        buildUI()
    }

    open func onCreate(_ context: ActivityContext) {}

    public func setContentView(_ view: View) {
        view.willMoveToParent()
        guard let viewInstance = view.setStatusAsContentView(context) else {
            DroidApp.logger.critical("🟥 Unable to initialize ViewInstance for `setContentView`")
            return
        }
        #if os(Android)
        guard
            let env = JEnv.current(),
            let methodId = context.clazz.methodId(env: env, name: "setContentView", signature: .init(.object(.android.view.View), returning: .void))
        else { return }
        env.callVoidMethod(object: .init(context.ref, context.clazz), methodId: methodId, args: [viewInstance.object])
        #endif
        view.didMoveToParent()
    }

    @BodyBuilder open var body: BodyBuilder.Result { EmptyBodyBuilderItem() }

    @discardableResult
    open func body(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        DroidApp.logger.debug("activity body 1")
        if let contentView {
            DroidApp.logger.debug("activity body 2 (existing contentView)")
            contentView.body(block: block)
        } else {
            DroidApp.logger.debug("activity body 3")
            let item = block().bodyBuilderItem
            func setDefaultFrameLayout(_ item: BodyBuilderItem) {
                DroidApp.logger.debug("activity body setDefaultFrameLayout")
                let view = FrameLayout()
                view.addItem(item)
                setContentView(view)
                contentView = view
            }
            func proceedItem(_ item: BodyBuilderItem) {
                switch item {
                case .single(let view):
                    DroidApp.logger.debug("activity body 4 (single)")
                    setContentView(view)
                case .multiple(let views):
                    if views.count == 1, let view = views.first {
                        DroidApp.logger.debug("activity body 5 (multiple)")
                        setContentView(view)
                    } else {
                        DroidApp.logger.debug("activity body 6 (multiple)")
                        setDefaultFrameLayout(item)
                    }
                case .nested(let items):
                    if items.count == 1, let item = items.first {
                        DroidApp.logger.debug("activity body 7 (nested)")
                        proceedItem(item.bodyBuilderItem)
                    } else {
                        DroidApp.logger.debug("activity body 8 (nested)")
                        setDefaultFrameLayout(item)
                    }
                case .forEach:
                    DroidApp.logger.debug("activity body 9 (forEach)")
                    setDefaultFrameLayout(item)
                case .none:
                    DroidApp.logger.debug("activity body 10 (none)")
                    setDefaultFrameLayout(item)
                }
            }
            proceedItem(item)
        }
        return self
    }

    open func buildUI() {}
}

// public final class AppCompatActivity: DroidApp.AnyActivity {
//     /// The globally retained JNI reference to the Java object.
//     public let ref: JObjectBox

//     /// The loaded `JClass`
//     public let clazz: JClass

//     /// Object wrapper
//     public let object: JObject

//     public required init(ref: JObjectBox, clazz: JClass, object: JObject) {
//         self.ref = ref
//         self.clazz = clazz
//         self.object = object
//     }

//     public class var className: JClassName { .init(stringLiteral: "androidx/appcompat/app/AppCompatActivity") }
//     public class var requiredImports: [String] { ["android.support.v7.app.AppCompatActivity"] }
//     public class var parentClass: String { "AppCompatActivity()" }
// }
