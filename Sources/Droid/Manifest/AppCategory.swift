//
//  AppCategory.swift
//  Droid
//
//  Created by Mihael Isaev on 01.11.2025.
//

public struct AppCategory: ExpressibleByStringLiteral, StringValuable, Sendable, CustomStringConvertible {
    public let value: String

    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public var description: String { value }

    /// Apps that are primarily accessibility apps, such as screen-readers.
    public static let accessibility: AppCategory = "accessibility"
    /// Apps that primarily work with audio or music, such as music players.
    public static let audio: AppCategory = "audio"
    /// Apps that are primarily games.
    public static let game: AppCategory = "game"
    /// Apps that primarily work with images or photos, such as camera or gallery apps.
    public static let image: AppCategory = "image"
    /// Apps that are primarily map apps, such as navigation apps.
    public static let maps: AppCategory = "maps"
    /// Apps that are primarily news apps, such as newspapers, magazines, or sports apps.
    public static let news: AppCategory = "news"
    /// Apps that are primarily productivity apps, such as cloud storage or workplace apps.
    public static let productivity: AppCategory = "productivity"
    /// Apps that are primarily social apps, such as messaging, communication, email, or social network apps.
    public static let social: AppCategory = "social"
    /// Apps that primarily work with video or movies, such as streaming video apps.
    public static let video: AppCategory = "video"
}