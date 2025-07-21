extension SwiftPackage {
    public class ViewPackage: JClassName, @unchecked Sendable {}
    
    public var view: ViewPackage { .init(parent: self, name: "view") }
}