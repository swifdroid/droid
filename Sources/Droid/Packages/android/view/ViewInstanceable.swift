//
//  ViewInstanceable.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

@MainActor
public protocol ViewInstanceable {
    var instance: View.ViewInstance? { get }
}