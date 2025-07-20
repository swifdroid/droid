//
//  VSpace.swift
//  Droid
//
//  Created by Mihael Isaev on 01.07.2025.
//

import DroidFoundation

public class VSpace: Space, @unchecked Sendable {
    @discardableResult
    public init(_ height: LayoutParams.LayoutSize, _ unit: DimensionUnit = .dp, weight: Float = 0) {
        super.init(weight: weight)
        self.height(height, unit)
    }

    @discardableResult
    public init(_ height: Int, _ unit: DimensionUnit = .dp, weight: Float = 0) {
        super.init(weight: weight)
        self.height(height, unit)
    }
}