import Droid
#if canImport(AndroidLooper)
import AndroidLooper
#endif

/// This class models the edges and corners of a shape,
/// which are used by `MaterialShapeDrawable` to generate
/// and render the shape for a view's background.
#if canImport(AndroidLooper)
@UIThreadActor
#endif
public final class ShapeAppearanceModel: JObjectable, Sendable {
    /// The JNI class name
    public class var className: JClassName { "com/google/android/material/shape/ShapeAppearanceModel" }

    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    public init? (_ context: Contextable) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let classLoader = context.context.getClassLoader(),
            let clazz = classLoader.loadClass(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.context.object])
        else { return nil }
        self.object = global
        #else
        return nil
        #endif
    }

    // TODO: toBuilder

    /// Returns a copy of this `ShapeAppearanceModel` with the same edges and corners, but with the corner size for all corners updated.
    public func withCornerSize(_ cornerSize: Float) -> Self? {
        guard
            let newObject = object.callObjectMethod(name: "withCornerSize", args: cornerSize)
        else { return nil }
        return .init(newObject)
    }
}