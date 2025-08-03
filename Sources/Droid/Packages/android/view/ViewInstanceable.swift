//
//  ViewInstanceable.swift
//  Droid
//
//  Created by Mihael Isaev on 05.08.2025.
//

#if canImport(AndroidLooper)
import AndroidLooper
#endif

#if canImport(AndroidLooper)
@UIThreadActor
#endif
public protocol ViewInstanceable {
    var instance: View.ViewInstance? { get }
}