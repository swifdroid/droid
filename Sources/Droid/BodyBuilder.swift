#if os(Android)
@MainActor
#endif
@resultBuilder public struct BodyBuilder {
    public typealias Result = BodyBuilderItemable
    #if os(Android)
    public typealias SingleView = @MainActor @Sendable () -> Result
    #else
    public typealias SingleView = @Sendable () -> Result
    #endif
    
    /// Empty block support
    public static func buildPartialBlock(first: Void) -> Result {
        EmptyBodyBuilderItem()
    }
    
    /// Single component support
    public static func buildPartialBlock(first: BodyBuilderItemable) -> Result {
        #if ANDROIDBUILDING
        parseItemForAndroidBuilding(first.bodyBuilderItem)
        #endif
        return first
    }
    
    /// Accumulation for multiple components
    public static func buildPartialBlock(
        accumulated: Result,
        next: BodyBuilderItemable
    ) -> Result {
        #if ANDROIDBUILDING
        parseItemForAndroidBuilding(accumulated.bodyBuilderItem)
        parseItemForAndroidBuilding(next.bodyBuilderItem)
        #endif
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
        #if ANDROIDBUILDING
        parseItemForAndroidBuilding(first.bodyBuilderItem)
        #endif
        return first
    }
    
    public static func buildEither(second: BodyBuilderItemable) -> Result {
        #if ANDROIDBUILDING
        parseItemForAndroidBuilding(second.bodyBuilderItem)
        #endif
        return second
    }
    
    /// Optional view support
    public static func buildIf(_ content: BodyBuilderItemable?) -> Result {
        #if ANDROIDBUILDING
        if let content {
            parseItemForAndroidBuilding(content.bodyBuilderItem)
        }
        #endif
        return content ?? EmptyBodyBuilderItem()
    }
    
    /// Optional: Support for limited availability views
    public static func buildLimitedAvailability(_ component: BodyBuilderItemable) -> Result {
        #if ANDROIDBUILDING
        parseItemForAndroidBuilding(component.bodyBuilderItem)
        #endif
        return component
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

    #if ANDROIDBUILDING
    private static func parseItemForAndroidBuilding(_ item: BodyBuilderItem) {
        switch item {
            case .single(let view):
                parseViewForAndroidBuilding(view)
            case .multiple(let views):
                for view in views {
                    parseViewForAndroidBuilding(view)
                }
            case .forEach(let forEach):
                for item in forEach.allItems() {
                    parseItemForAndroidBuilding(item.bodyBuilderItem)
                }
            case .nested(let items):
                for item in items {
                    parseItemForAndroidBuilding(item.bodyBuilderItem)
                }
            case .none:
                break
        }
    }

    private static func parseViewForAndroidBuilding(_ view: View) {
        DroidApp.shared._gradleDependencies.append(type(of: view).gradleDependencies)
    }
    #endif
}