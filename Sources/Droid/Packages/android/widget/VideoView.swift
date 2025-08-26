//
//  VideoView.swift
//  Droid
//
//  Created by Mihael Isaev on 16.01.2022.
//

extension AndroidPackage.WidgetPackage {
    public class VideoViewClass: JClassName, @unchecked Sendable {}
    public var VideoView: VideoViewClass { .init(parent: self, name: "VideoView") }
}

open class VideoView: View, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}
