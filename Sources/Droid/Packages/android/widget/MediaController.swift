//
//  MediaController.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class MediaControllerClass: JClassName, @unchecked Sendable {}
    public var MediaController: MediaControllerClass { .init(parent: self, name: "MediaController") }
}

open class MediaController: View, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }
}
