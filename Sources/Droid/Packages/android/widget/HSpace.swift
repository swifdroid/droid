//
//  HSpace.swift
//  Droid
//
//  Created by Mihael Isaev on 01.07.2025.
//

public final class HSpace: Space, @unchecked Sendable {
    @discardableResult
    public init(_ width: LayoutParams.LayoutSize, _ unit: DimensionUnit = .dp, weight: Float = 0) {
        super.init(weight: weight)
        self.width(width, unit)
    }

    @discardableResult
    public init(_ width: Int, _ unit: DimensionUnit = .dp, weight: Float = 0) {
        super.init(weight: weight)
        self.width(width, unit)
    }
}