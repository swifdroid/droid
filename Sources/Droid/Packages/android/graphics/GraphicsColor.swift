//
//  GraphicsColor.swift
//  Droid
//
//  Created by Mihael Isaev on 13.01.2022.
//

import DroidFoundation

extension AndroidPackage.GraphicsPackage {
    public class ColorClass: AndroidClassName {}
    
    public var Color: ColorClass { .init(superClass: self, "Color") }
    
    // TODO: color from HEX https://stackoverflow.com/questions/5248583/how-to-get-a-color-from-hexadecimal-color-string
}

class GraphicsColor: JClass {
    public static var black: Int = -16777216
    public static var blue: Int = -16776961
    public static var cyan: Int = -16711681
    public static var darkGray: Int = -12303292
    public static var gray: Int = -7829368
    public static var green: Int = -16711936
    public static var lightGray: Int = -3355444
    public static var magenta: Int = -65281
    public static var red: Int = -65536
    public static var transparent: Int = 0
    public static var white: Int = -1
    public static var yellow: Int = -256
}
