//
//  AppBuilder.swift
//  
//
//  Created by Mihael Isaev on 27.10.2021.
//

import Foundation

public protocol AppBuilderContent {
    var appBuilderContent: AppBuilder.Item { get }
}

extension AppLifecycle: AppBuilderContent {
    public var appBuilderContent: AppBuilder.Item { .lifecycle(self) }
}

extension AppManifest: AppBuilderContent {
	public var appBuilderContent: AppBuilder.Item { .manifest(self) }
}

struct _AppContent: AppBuilder.Content {
    let appBuilderContent: AppBuilder.Item
}

@resultBuilder public struct AppBuilder {
    public typealias Block = () -> AppBuilderContent
    public typealias Content = AppBuilderContent
    
    public enum Item {
        case none
        case lifecycle(AppLifecycle)
        case manifest(AppManifest)
//        case activities(Activities)
        case items([Item])
    }

    public static func buildBlock() -> Content {
        _AppContent(appBuilderContent: .none)
    }

    public static func buildBlock(_ attrs: Content...) -> Content {
        buildBlock(attrs)
    }

    public static func buildBlock(_ attrs: [Content]) -> Content {
        _AppContent(appBuilderContent: .items(attrs.map { $0.appBuilderContent }))
    }

    public static func buildIf(_ content: Content?) -> Content {
        guard let content = content else { return _AppContent(appBuilderContent: .none) }
        return _AppContent(appBuilderContent: .items([content.appBuilderContent]))
    }

    public static func buildEither(first: Content) -> Content {
        _AppContent(appBuilderContent: .items([first.appBuilderContent]))
    }

    public static func buildEither(second: Content) -> Content {
        _AppContent(appBuilderContent: .items([second.appBuilderContent]))
    }
}
