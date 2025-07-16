public enum BodyBuilderItem {
    case none
    case single(View)
    case multiple([View])
    case nested([BodyBuilderItemable])
    case forEach(AnyForEach)
}
public protocol BodyBuilderItemable {
    var bodyBuilderItem: BodyBuilderItem { get }
}
public struct EmptyBodyBuilderItem: BodyBuilderItemable {
    public var bodyBuilderItem: BodyBuilderItem { .none }
}
extension View: BodyBuilderItemable {
    public var bodyBuilderItem: BodyBuilderItem { .single(self) }
}
extension Array: BodyBuilderItemable where Element: View {
    public var bodyBuilderItem: BodyBuilderItem { .multiple(self) }
}
extension Optional: BodyBuilderItemable where Wrapped: View {
    public var bodyBuilderItem: BodyBuilderItem {
        switch self {
        case .none: return .none
        case .some(let value): return .single(value)
        }
    }
}
