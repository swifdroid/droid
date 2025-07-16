//
//  Permission.swift
//  Manifest
//
//  Created by Mihael Isaev on 29.07.2021.
//

import FoundationEssentials

/// Declares a security permission that can be used to limit access to specific components or features of this or other applications.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element)
public class Permission {
//    var description="string resource"
//
//    /// A user-readable description of the permission, longer and more informative than the label.
//    ///
//    /// It may be displayed to explain the permission to the user — for example, when the user is asked whether to grant the permission to another application.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#desc)
//    @discardableResult
//    public func description(_ value: ___) -> Self { // "string resource"
//        description = value
//        return self
//    }
    
//    var icon="drawable resource"
//
//    /// A reference to a drawable resource for an icon that represents the permission.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#icon)
//    @discardableResult
//    public func icon(_ value: ___) -> Self { // "drawable resource"
//        icon = value
//        return self
//    }
    
//    var label="string resource"
//
//    /// A name for the permission, one that can be displayed to users.
//    ///
//    ///As a convenience, the label can be directly set as a raw string while you're developing the application.
//    ///However, when the application is ready to be published, it should be set as a reference to a string resource,
//    ///so that it can be localized like other strings in the user interface.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#label)
//    @discardableResult
//    public func label(_ value: ___) -> Self { // "string resource"
//        label = value
//        return self
//    }
    
    var name: String?
    
    /// The name of the permission.
    ///
    /// This is the name that will be used in code to refer to the permission — for example,
    /// in a `<uses-permission>` element and the permission attributes of application components.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#nm)
    @discardableResult
    public func name(_ value: String) -> Self {
        name = value
        return self
    }
    
    var permissionGroup: String?
    
    /// Assigns this permission to a group.
    ///
    /// The value of this attribute is the name of the group,
    /// which must be declared with the `<permission-group>` element in this or another application.
    ///
    /// If this attribute is not set, the permission does not belong to a group.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#pgroup)
    @discardableResult
    public func permissionGroup(_ value: String) -> Self {
        permissionGroup = value
        return self
    }
    
    /// Characterizes the potential risk implied in the permission
    /// and indicates the procedure the system should follow when determining
    /// whether or not to grant the permission to an application requesting it.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#plevel)
    public class ProtectionLevel: ExpressibleByStringLiteral {
        let value: String
        
        public required init(stringLiteral value: String) {
            self.value = value
        }
        
        /// The default value.
        /// A lower-risk permission that gives requesting applications access to isolated application-level features,
        /// with minimal risk to other applications, the system, or the user.
        /// The system automatically grants this type of permission to a requesting application at installation,
        /// without asking for the user's explicit approval
        /// (though the user always has the option to review these permissions before installing).
        public static var normal: ProtectionLevel { "normal" }
        
        /// A higher-risk permission that would give a requesting application access to private user data
        /// or control over the device that can negatively impact the user. Because this type of permission
        /// introduces potential risk, the system may not automatically grant it to the requesting application.
        ///
        /// For example, any dangerous permissions requested by an application may be displayed to the user
        /// and require confirmation before proceeding, or some other approach may be taken
        /// to avoid the user automatically allowing the use of such facilities.
        public static var dangerous: ProtectionLevel { "dangerous" }
        
        /// A permission that the system grants only if the requesting application is signed with the same certificate
        /// as the application that declared the permission. If the certificates match, the system automatically grants the permission
        /// without notifying the user or asking for the user's explicit approval.
        public static var signature: ProtectionLevel { "signature" }
    }
    
    var protectionLevel: ProtectionLevel?
    
    /// Characterizes the potential risk implied in the permission
    /// and indicates the procedure the system should follow when determining
    /// whether or not to grant the permission to an application requesting it.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/permission-element#plevel)
    @discardableResult
    public func protectionLevel(_ value: ProtectionLevel) -> Self {
        protectionLevel = value
        return self
    }
}
