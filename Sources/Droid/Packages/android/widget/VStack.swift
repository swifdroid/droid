//
//  VStack.swift
//  Droid
//
//  Created by Mihael Isaev on 01.07.2025.
//

public final class VStack: LinearLayout {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }

    @discardableResult
    public override init (id: Int32? = nil, @BodyBuilder content: BodyBuilder.SingleView) {
        super.init(id: id, content: content)
    }

    override func _setup() {
        super._setup()
        orientation(.vertical)
    }
}