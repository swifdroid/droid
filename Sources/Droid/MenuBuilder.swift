//
//  MenuBuilder.swift
//  
//
//  Created by Mihael Isaev on 01.01.2026.
//

@MainActor
public protocol MenuBuilderContent {
    var menuBuilderContent: MenuBuilder.Item { get }
}

extension AppCompatActivity.ActionSubMenu: MenuBuilderContent {
    public var menuBuilderContent: MenuBuilder.Item { .menu(self) }
}

extension AppCompatActivity.ActionMenuItem: MenuBuilderContent {
	public var menuBuilderContent: MenuBuilder.Item { .menuItem(self) }
}

struct EmptyMenuBuilderItem: MenuBuilderContent {
    public var menuBuilderContent: MenuBuilder.Item { .none }
}

struct _MenuContent: MenuBuilder.Content {
    let menuBuilderContent: MenuBuilder.Item
}

@MainActor
@resultBuilder public struct MenuBuilder {
    public typealias Block = () -> MenuBuilderContent
    public typealias Content = MenuBuilderContent
    
    public enum Item {
        case none
        case menu(AppCompatActivity.ActionSubMenu)
        case menuItem(AppCompatActivity.ActionMenuItem)
        case items([Item])
    }

    public static func buildBlock() -> Content {
        _MenuContent(menuBuilderContent: .none)
    }

    public static func buildBlock(_ attrs: Content...) -> Content {
        buildBlock(attrs)
    }

    public static func buildBlock(_ attrs: [Content]) -> Content {
        _MenuContent(menuBuilderContent: .items(attrs.map { $0.menuBuilderContent }))
    }

    public static func buildIf(_ content: Content?) -> Content {
        guard let content = content else { return _MenuContent(menuBuilderContent: .none) }
        return _MenuContent(menuBuilderContent: .items([content.menuBuilderContent]))
    }

    public static func buildEither(first: Content) -> Content {
        _MenuContent(menuBuilderContent: .items([first.menuBuilderContent]))
    }

    public static func buildEither(second: Content) -> Content {
        _MenuContent(menuBuilderContent: .items([second.menuBuilderContent]))
    }
}
