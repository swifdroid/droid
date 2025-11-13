//
//  IsMonitoringTool.swift
//  Droid
//
//  Created by Mihael Isaev on 02.11.2025.
//

public struct IsMonitoringTool: ExpressibleByStringLiteral, StringValuable, Sendable, CustomStringConvertible {
    public let value: String

    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public var description: String { value }

    /// App caters to parental control and is specifically targeted at parents who want to keep their kids safe. 
    public static let childMonitoring: IsMonitoringTool = "child_monitoring"

    /// App caters to enterprises who want to manage and monitor employees. 
    public static let enterpriseManagement: IsMonitoringTool = "enterprise_management"

    /// App that does not fall in any of the above categories.
    /// 
    /// The Google Play review team will assess whether apps with this value qualify for any valid exemption categories.
    public static let other: IsMonitoringTool = "other"
}