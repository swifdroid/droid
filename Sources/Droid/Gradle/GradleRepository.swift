//
//  GradleRepository.swift
//  
//
//  Created by Mihael Isaev on 05.06.2023.
//

import FoundationEssentials

public struct GradleRepository: ExpressibleByStringLiteral {
    let name: String
    
    public init(stringLiteral value: String) {
        self.name = value
    }
    
    public static var gradlePluginPortal: Self { "gradlePluginPortal()" }
    public static var jcenter: Self { "jcenter()" }
    public static var mavenCentral: Self { "mavenCentral()" }
    public static var mavenLocal: Self { "mavenLocal()" }
    public static var google: Self { "google()" }
}
