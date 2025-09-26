//
//  ManifestPermissionGroup.swift
//  Droid
//
//  Created by Mihael Isaev on 13.09.2025.
//

public struct ManifestPermissionGroup: ExpressibleByStringLiteral, StringValuable, Sendable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    /// Used for permissions that are associated with activity recognition.
    public static let activityRecognition: ManifestPermissionGroup = "android.permission-group.ACTIVITY_RECOGNITION"
    /// Used for runtime permissions related to user's calendar.
    public static let calendar: ManifestPermissionGroup = "android.permission-group.CALENDAR"
    /// Used for permissions that are associated telephony features.
    public static let callLog: ManifestPermissionGroup = "android.permission-group.CALL_LOG"
    /// Used for permissions that are associated with accessing camera or capturing images/video from the device.
    public static let camera: ManifestPermissionGroup = "android.permission-group.CAMERA"
    /// Used for runtime permissions related to contacts and profiles on this device.
    public static let contacts: ManifestPermissionGroup = "android.permission-group.CONTACTS"
    /// Used for permissions that allow accessing the device location.
    public static let location: ManifestPermissionGroup = "android.permission-group.LOCATION"
    /// Used for permissions that are associated with accessing microphone audio from the device.
    public static let microphone: ManifestPermissionGroup = "android.permission-group.MICROPHONE"
    /// Required to be able to discover and connect to nearby Bluetooth devices.
    public static let nearbyDevices: ManifestPermissionGroup = "android.permission-group.NEARBY_DEVICES"
    /// Used for permissions that are associated with posting notifications
    public static let notifications: ManifestPermissionGroup = "android.permission-group.NOTIFICATIONS"
    /// Used for permissions that are associated telephony features.
    public static let phone: ManifestPermissionGroup = "android.permission-group.PHONE"
    /// Required to be able to read audio files from shared storage.
    public static let readMediaAural: ManifestPermissionGroup = "android.permission-group.READ_MEDIA_AURAL"
    /// Required to be able to read image and video files from shared storage.
    public static let readMediaVisual: ManifestPermissionGroup = "android.permission-group.READ_MEDIA_VISUAL"
    /// Used for permissions that are associated with accessing body or environmental sensors.
    public static let sensors: ManifestPermissionGroup = "android.permission-group.SENSORS"
    /// Used for runtime permissions related to user's SMS messages.
    public static let sms: ManifestPermissionGroup = "android.permission-group.SMS"
    /// Used for runtime permissions related to the shared external storage.
    public static let storage: ManifestPermissionGroup = "android.permission-group.STORAGE"
}