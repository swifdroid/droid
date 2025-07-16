//
//  PermissionGroup.swift
//  Manifest
//
//  Created by Mihael Isaev on 29.07.2021.
//

import FoundationEssentials

/// Declares a name for a logical grouping of related permissions.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-group-element)
public class PermissionGroup {
    public init () {}
    
//    var description="string resource"
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func description(_ value: ___) -> Self { // "string resource"
//        description = value
//        return self
//    }
    
//    var icon="drawable resource"
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func icon(_ value: ___) -> Self { // "drawable resource"
//        icon = value
//        return self
//    }
    
//    var label="string resource"
//
//    /// ___
//    ///
//    /// [Learn more](___)
//    @discardableResult
//    public func label(_ value: ___) -> Self { // "string resource"
//        label = value
//        return self
//    }
    
    var name: String?
    
    /// ___
    ///
    /// [Learn more](___)
    @discardableResult
    public func name(_ value: String) -> Self {
        name = value
        return self
    }
}
