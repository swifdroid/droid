//
//  ViewInstanceable.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

#if os(Android)
@MainActor
#endif
public protocol ViewInstanceable {
    var instance: View.ViewInstance? { get }
}