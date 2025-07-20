#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
@resultBuilder public struct BodyBuilder {
    public typealias Result = BodyBuilderItemable
    #if canImport(AndroidLooper)
    public typealias SingleView = @UIThreadActor @Sendable () -> Result
    #else
    public typealias SingleView = @Sendable () -> Result
    #endif
    
    /// Empty block support
    public static func buildPartialBlock(first: Void) -> Result {
        EmptyBodyBuilderItem()
    }
    
    /// Single component support
    public static func buildPartialBlock(first: BodyBuilderItemable) -> Result {
        first
    }
    
    /// Accumulation for multiple components
    public static func buildPartialBlock(
        accumulated: Result,
        next: BodyBuilderItemable
    ) -> Result {
        switch (accumulated.bodyBuilderItem, next.bodyBuilderItem) {
        case (.nested(let items), .nested(let newItems)):
            return BodyBuilderItems(items: items + newItems)
        case (.nested(let items), _):
            return BodyBuilderItems(items: items + [next])
        case (_, .nested(let items)):
            return BodyBuilderItems(items: [accumulated] + items)
        default:
            return BodyBuilderItems(items: [accumulated, next])
        }
    }
    
    // MARK: - Control Flow Support
    
    /// if/else support
    public static func buildEither(first: BodyBuilderItemable) -> Result {
        first
    }
    
    public static func buildEither(second: BodyBuilderItemable) -> Result {
        second
    }
    
    /// Optional view support
    public static func buildIf(_ content: BodyBuilderItemable?) -> Result {
        content ?? EmptyBodyBuilderItem()
    }
    
    /// Optional: Support for limited availability views
    public static func buildLimitedAvailability(_ component: BodyBuilderItemable) -> Result {
        component
    }
    
    // MARK: - Expression Handling
    
    // /// Handle non-BodyBuilderItemable expressions
    // public static func buildExpression(_ expression: some BodyBuilderItemable) -> Result {
    //     expression
    // }
    
    // /// Handle literal values if needed
    // public static func buildExpression(_ expression: String) -> Result {
    //     Text(expression) // Assuming Text conforms to BodyBuilderItemable
    // }
}