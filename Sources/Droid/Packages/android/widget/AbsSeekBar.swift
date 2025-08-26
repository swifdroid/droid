//
//  AbsSeekBar.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

open class AbsSeekBar: ProgressBar, @unchecked Sendable {
    @discardableResult
    public override init (id: Int32? = nil) {
        super.init(id: id)
    }
}