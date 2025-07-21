//
//  VStack.swift
//  Droid
//
//  Created by Mihael Isaev on 01.07.2025.
//

public class VStack: LinearLayout, @unchecked Sendable {
    @discardableResult
    public override init() {
        super.init()
    }

    @discardableResult
    public override init (@BodyBuilder content: BodyBuilder.SingleView) {
        super.init(content: content)
    }

    override func _setup() {
        super._setup()
        orientation(.vertical)
    }
}