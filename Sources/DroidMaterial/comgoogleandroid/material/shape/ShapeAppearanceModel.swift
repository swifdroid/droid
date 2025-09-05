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
public final class ShapeAppearanceModel: JObjectable, Contextable, Sendable {
    /// The JNI class name
    public class var className: JClassName { "com/google/android/material/shape/ShapeAppearanceModel" }

    public let object: JObject
    public let context: ActivityContext

    public init (_ object: JObject, _ context: Contextable) {
        self.object = object
        self.context = context.context
    }

    public init? (_ context: Contextable) {
        #if os(Android)
        guard
            let env = JEnv.current(),
            let clazz = JClass.load(Self.className),
            let methodId = clazz.methodId(env: env, name: "<init>", signature: .init(.object(.android.content.Context), returning: .void)),
            let global = env.newObject(clazz: clazz, constructor: methodId, args: [context.context.object])
        else { return nil }
        self.object = global
        self.context = context.context
        #else
        return nil
        #endif
    }

    // TODO: toBuilder

    /// Returns a copy of this `ShapeAppearanceModel` with the same edges and corners, but with the corner size for all corners updated.
    public func withCornerSize(_ cornerSize: Float) -> ShapeAppearanceModel? {
        guard
            let returningClazz = JClass.load(ShapeAppearanceModel.className),
            let newObject = object.callObjectMethod(name: "withCornerSize", args: cornerSize, returningClass: returningClazz, returning: .object(ShapeAppearanceModel.className))
        else { return nil }
        return .init(newObject, self)
    }
}