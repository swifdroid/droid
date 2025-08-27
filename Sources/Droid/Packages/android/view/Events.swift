//
//  Events.swift
//  Droid
//
//  Created by Mihael Isaev on 21.08.2025.
//

/// Describes the capabilities of a particular input device.
///
/// Each input device may support multiple classes of input.
/// For example, a multi-function keyboard may compose the capabilities
/// of a standard keyboard together with a track pad mouse or other pointing device.
///
/// Some input devices present multiple distinguishable sources of input.
/// Applications can query the framework about the characteristics of each distinct source.
///
/// As a further wrinkle, different kinds of input sources uses different coordinate systems
/// to describe motion events. Refer to the comments on the input source constants for the appropriate interpretation.
/// 
/// [Learn more](https://developer.android.com/reference/android/view/InputDevice)
public final class InputDevice: JObjectable, Sendable {
    public class var className: JClassName { "android/view/InputDevice" }

    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: https://developer.android.com/reference/android/view/InputDevice
}

extension InputDevice {
    public enum KeyboardType: Int32 {
        // The keyboard supports a complement of alphabetic keys.
        case alphabetic
        // There is no keyboard.
        case none
        // The keyboard is not fully alphabetic.
        case nonAlphabetic
    }
}

/// Common base class for input events.
///
/// [Learn more](https://developer.android.com/reference/android/view/InputEvent)
open class InputEvent: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/InputEvent" }
    
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    /// Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
    public func describeContents() -> Int? {
        guard let value = object.callIntMethod(name: "describeContents") else { return nil }
        return Int(value)
    }

    /// Gets the device that this event came from.
    public func getDevice() -> InputDevice? {
        guard
            let global = object.callObjectMethod(name: "getDevice", returning: .object(InputDevice.className))
        else { return nil }
        return .init(global)
    }

    /// Gets the id for the device that this event came from.
    public func getDeviceId() -> Int? {
        guard let value = object.callIntMethod(name: "getDeviceId") else { return nil }
        return Int(value)
    }

    /// Retrieve the time this event occurred, in the SystemClock.uptimeMillis() time base.
    public func getEventTime() -> Int? {
        guard let value = object.callLongMethod(name: "getEventTime") else { return nil }
        return Int(value)
    }

    /// Gets the source of the event.
    public func getSource() -> Int {
        guard let value = object.callIntMethod(name: "getSource") else { return 0 }
        return Int(value)
    }

    /// Determines whether the event is from the given source.
    public func isFromSource(_ source: Int) -> Bool {
        object.callBoolMethod(name: "isFromSource", args: Int32(source)) ?? false
    }
}

// MARK: - MotionEvent

/// Object used to report movement (mouse, pen, finger, trackball) events.
///
/// Motion events may hold either absolute or relative movements and other data,
/// depending on the type of device.
///
/// [Learn more](https://developer.android.com/reference/android/view/MotionEvent)
public final class MotionEvent: InputEvent, @unchecked Sendable {
    public override class var className: JClassName { "android/view/InputEvent" }

    // TODO: addBatch()

    /// Given a pointer identifier, find the index of its data in the event.
    public func findPointerIndex(_ pointerId: Int) -> Int? {
        guard let value = object.callIntMethod(name: "findPointerIndex", args: Int32(pointerId)) else { return nil }
        return Int(value)
    }

    /// Return the kind of action being performed.
    public func getAction() -> Action? {
        guard let value = object.callIntMethod(name: "getAction") else { return nil }
        return .init(rawValue: value)
    }

    /// Gets which button has been modified during a press or release action.
    public func getActionButton() -> ActionButton? {
        guard let value = object.callIntMethod(name: "getActionButton") else { return nil }
        return .init(rawValue: value)
    }

    /// For `ACTION_POINTER_DOWN` or `ACTION_POINTER_UP` as returned by `getActionMasked()`, this returns the associated pointer index.
    public func getActionIndex() -> Int? {
        guard let value = object.callIntMethod(name: "getActionIndex") else { return nil }
        return Int(value)
    }

    /// Return the masked action being performed, without pointer index information.
    public func getActionMasked() -> Action? {
        guard let value = object.callIntMethod(name: "getActionMasked") else { return nil }
        return .init(rawValue: value)
    }

    /// Returns the value of the requested axis.
    public func getAxisValue(axis: Axis, pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = [axis.rawValue]
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getAxisValue", args: args)
    }

    /// Gets the state of all buttons that are pressed such as a mouse or stylus button.
    public func getButtonState() -> Button? {
        guard let value = object.callIntMethod(name: "getButtonState") else { return nil }
        return .init(rawValue: value)
    }

    /// Returns the classification for the current gesture. The classification may change as more events become available for the same gesture.
    public func getClassification() -> Classification? {
        guard let value = object.callIntMethod(name: "getClassification") else { return nil }
        return .init(rawValue: value)
    }

    /// Returns the time (in ms) when the user originally pressed down to start a stream of position events.
    public func getDownTime() -> Int64? {
        object.callLongMethod(name: "getDownTime")
    }

    /// Returns a bitfield indicating which edges, if any, were touched by this MotionEvent.
    public func getEdgeFlags() -> Edge? {
        guard let value = object.callIntMethod(name: "getEdgeFlags") else { return nil }
        return .init(rawValue: value)
    }

    /// Retrieve the time this event occurred, in the `SystemClock.uptimeMillis()` time base but with nanosecond precision.
    public func getEventTimeNanos() -> Int? {
        guard let value = object.callLongMethod(name: "getEventTimeNanos") else { return nil }
        return Int(value)
    }

    /// Gets the motion event flags.
    public func getFlags() -> Flag? {
        guard let value = object.callIntMethod(name: "getFlags") else { return nil }
        return .init(rawValue: value)
    }

    /// Returns the historical value of the requested axis, as per `getAxisValue(int, int)`, occurred between this event and the previous event for the given pointer. Only applies to `ACTION_MOVE` events.
    public func getHistoricalAxisValue(axis: Axis, pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = [axis.rawValue]
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getHistoricalAxisValue", args: args)
    }

    /// Returns the time that a historical movement occurred between this event and the previous event, in the `SystemClock.uptimeMillis()` time base.
    public func getHistoricalEventTime(position: Int) -> Int? {
        guard let value = object.callLongMethod(name: "getHistoricalEventTime", args: Int32(position)) else { return nil }
        return Int(value)
    }

    /// Returns the time that a historical movement occurred between this event and the previous event, in the `SystemClock.uptimeMillis()` time base but with nanosecond (instead of millisecond) precision.
    public func getHistoricalEventTimeNanos(position: Int) -> Int? {
        guard let value = object.callLongMethod(name: "getHistoricalEventTimeNanos", args: Int32(position)) else { return nil }
        return Int(value)
    }

    /// Returns a historical orientation coordinate, as per `getOrientation(int)`, that occurred between this event and the previous event for the given pointer. Only applies to `ACTION_MOVE` events.
    public func getHistoricalOrientation(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalOrientation", args: args)
    }

    // TODO: getHistoricalPointerCoords()

    /// Returns a historical pressure coordinate, as per `getPressure(int)`, that occurred between this event and the previous event for the given pointer. Only applies to `ACTION_MOVE` events.
    public func getHistoricalPressure(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalPressure", args: args)
    }

    /// Gets historical size for the first pointer index (may be an arbitrary pointer identifier).
    public func getHistoricalSize(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalSize", args: args)
    }

    /// Returns a historical tool major axis coordinate, as per `getToolMajor(int)`, that occurred between this event and the previous event for the given pointer. 
    public func getHistoricalToolMajor(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalToolMajor", args: args)
    }

    /// Returns a historical tool minor axis coordinate, as per `getToolMinor(int)`, that occurred between this event and the previous event for the given pointer. 
    public func getHistoricalToolMinor(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalToolMinor", args: args)
    }

    /// Returns a historical touch major axis coordinate, as per `getTouchMajor(int)`, that occurred between this event and the previous event for the given pointer.
    public func getHistoricalTouchMajor(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalTouchMajor", args: args)
    }

    /// Returns a historical touch minor axis coordinate, as per `getTouchMinor(int)`, that occurred between this event and the previous event for the given pointer.
    public func getHistoricalTouchMinor(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalTouchMinor", args: args)
    }

    /// Returns a historical X coordinate, as per `getX(int)`, that occurred between this event and the previous event for the given pointer.
    public func getHistoricalX(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalX", args: args)
    }

    /// Returns a historical Y coordinate, as per `getY(int)`, that occurred between this event and the previous event for the given pointer.
    public func getHistoricalY(pointerIndex: Int? = nil, position: Int) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        args.append(Int32(position))
        return object.callFloatMethod(name: "getHistoricalY", args: args)
    }

    /// Returns the number of historical points in this event.
    public func getHistorySize() -> Int? {
        guard let value = object.callIntMethod(name: "getHistorySize") else { return nil }
        return Int(value)
    }

    /// Returns the state of any meta / modifier keys that were in effect when the event was generated.
    public func getMetaState() -> Int? {
        guard let value = object.callIntMethod(name: "getMetaState") else { return nil }
        return Int(value)
    }

    /// Returns the value of AXIS_ORIENTATION for the given pointer index.
    public func getOrientation(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getOrientation", args: args)
    }

    // TODO: getPointerCoords()

    /// The number of pointers of data contained in this event. Always >= 1.
    public func getPointerCount() -> Int? {
        guard let value = object.callIntMethod(name: "getPointerCount") else { return nil }
        return Int(value)
    }

    /// Return the pointer identifier associated with a particular pointer data index in this event. The identifier tells you the actual pointer number associated with the data, accounting for individual pointers going up and down since the start of the current gesture.
    public func getPointerId(pointerIndex: Int) -> Int? {
        guard let value = object.callIntMethod(name: "getPointerCount", args: Int32(pointerIndex)) else { return nil }
        return Int(value)
    }

    // TODO: getPointerProperties()

    /// Returns the value of `AXIS_PRESSURE`.
    public func getPressure(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getPressure", args: args)
    }

    /// Returns the X coordinate of the pointer referenced by `pointerIndex` for this motion event.
    public func getRawX(pointerIndex: Int = 0) -> Float? {
        return object.callFloatMethod(name: "getRawX", args: Int32(pointerIndex))
    }

    /// Returns the Y coordinate of the pointer referenced by `pointerIndex` for this motion event.
    public func getRawY(pointerIndex: Int = 0) -> Float? {
        object.callFloatMethod(name: "getRawY", args: Int32(pointerIndex))
    }

    /// Returns the value of `AXIS_SIZE`.
    public func getSize(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getSize", args: args)
    }

    /// Gets the source of the event.
    public func getSource() -> Int? {
        guard let value = object.callIntMethod(name: "getSource") else { return nil }
        return Int(value)
    }

    /// Returns the value of `AXIS_TOOL_MAJOR`.
    public func getToolMajor(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getToolMajor", args: args)
    }

    /// Returns the value of `AXIS_TOOL_MINOR`.
    public func getToolMinor(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getToolMinor", args: args)
    }

    /// Gets the tool type of a pointer for the given pointer index. The tool type indicates the type of tool used to make contact such as a finger or stylus, if known.
    public func getToolType(pointerIndex: Int) -> Int? {
        guard let value = object.callIntMethod(name: "getToolType", args: Int32(pointerIndex)) else { return nil }
        return Int(value)
    }

    /// Returns the value of `AXIS_TOUCH_MAJOR`.
    public func getTouchMajor(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getTouchMajor", args: args)
    }

    /// Returns the value of `AXIS_TOUCH_MINOR`.
    public func getTouchMinor(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getTouchMinor", args: args)
    }

    /// Returns the X coordinate of the pointer referenced by `pointerIndex` for this motion event.
    public func getX(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getX", args: args)
    }

    /// Return the precision of the X coordinates being reported.
    public func getXPrecision(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getXPrecision", args: args)
    }

    /// Returns the Y coordinate of the pointer referenced by `pointerIndex` for this motion event.
    public func getY(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getY", args: args)
    }

    /// Return the precision of the Y coordinates being reported.
    public func getYPrecision(pointerIndex: Int? = nil) -> Float? {
        var args: [any JSignatureItemable] = []
        if let pointerIndex {
            args.append(Int32(pointerIndex))
        }
        return object.callFloatMethod(name: "getYPrecision", args: args)
    }
}

extension MotionEvent {
    public enum Action: Int32 {
        /// A pressed gesture has started, the motion contains the initial starting location.
        case down = 0
        /// A pressed gesture has finished, the motion contains the final release location as well as any intermediate points since the last down or move event.
        case up = 1
        /// Constant for `getActionMasked()`: A change has happened during a press gesture (between `.down` and `.up`). The motion contains the most recent point, as well as any intermediate points since the last down or move event.
        case move = 2
        /// The current gesture has been aborted. You will not receive any more points in it. You should treat this as an up event, but not perform any action that you normally would.
        case cancel = 3
        /// Constant for `getActionMasked()`: A movement has happened outside of the normal bounds of the UI element. This does not provide a full gesture, but only the initial location of the movement/touch.
        case outside = 4
        /// A non-primary pointer has gone down.
        case pointerDown = 5
        /// A non-primary pointer has gone up.
        case pointerUp = 6
        /// A change happened but the pointer is not down (unlike `.move`). The motion contains the most recent point, as well as any intermediate points since the last hover move event.
        case hoverMove = 7
        /// The motion event contains relative vertical and/or horizontal scroll offsets.
        case scroll = 8
        /// The pointer is not down but has entered the boundaries of a window or view.
        case hoverEnter = 9
        /// The pointer is not down but has exited the boundaries of a window or view.
        case hoverExit = 10
        /// A button has been pressed.
        case buttonPress = 11
        /// A button has been released.
        case buttonRelease = 12
        /// Bit mask of the parts of the action code that are the action itself.
        case mask = 255
        /// Bits in the action code that represent a pointer index, used with `.pointerDown` and `.pointerUp`. Shifting down by `.pointerIndexShift` provides the actual pointer index where the data for the pointer going up or down can be found; you can get its identifier with `getPointerId(int)` and the actual data with `getX(int)` etc.
        case pointerIndexMask = 65280
    }

    public enum ActionButton: Int32 {
        /// A button has been pressed.
        case press = 11
        /// A button has been released.
        case release = 12
    }

    public enum Axis: Int32 {
        /// Gas axis of a motion event.
        case gas = 22
        /// Brake axis of a motion event.
        case brake = 23
        /// Distance axis of a motion event.
        case distance = 24
        /// Generic 1 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic1 = 32
        /// Generic 2 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic2 = 33
        /// Generic 3 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic3 = 34
        /// Generic 4 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic4 = 35
        /// Generic 5 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic5 = 36
        /// Generic 6 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic6 = 37
        /// Generic 7 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic7 = 38
        /// Generic 8 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic8 = 39
        /// Generic 9 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic9 = 40
        /// Generic 10 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic10 = 41
        /// Generic 11 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic11 = 42
        /// Generic 12 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic12 = 43
        /// Generic 13 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic13 = 44
        /// Generic 14 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic14 = 45
        /// Generic 15 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic15 = 46
        /// Generic 16 axis of a motion event. The interpretation of a generic axis is device-specific.
        case generic16 = 47
        /// Pinch scale factor of a motion event.
        case gesturePinchScaleFactor = 52
        /// X scroll distance axis of a motion event.
        case gestureScrollXDistance = 50
        /// Y scroll distance axis of a motion event.
        case gestureScrollYDistance = 51
        /// X gesture offset axis of a motion event.
        case gestureXOffset = 48
        /// Y gesture offset axis of a motion event.
        case gestureYOffset = 49
        /// Hat X axis of a motion event.
        case hatX = 15
        /// Hat Y axis of a motion event.
        case hatY = 16
        /// Horizontal Scroll axis of a motion event.
        case hScroll = 10
        /// Left Trigger axis of a motion event.
        case leftTrigger = 17
        /// Orientation axis of a motion event.
        case orientation = 8
        /// Pressure axis of a motion event.
        case pressure = 2
        /// The movement of `x` position of a motion event.
        case relativeX = 27
        /// The movement of `y` position of a motion event.
        case relativeY = 28
        /// Right Trigger axis of a motion event.
        case rightTrigger = 18
        /// Rudder axis of a motion event.
        case rudder = 20
        /// X Rotation axis of a motion event.
        case rotationX = 12
        /// Y Rotation axis of a motion event.
        case rotationY = 13
        /// Z Rotation axis of a motion event.
        case rotationZ = 14
        /// Generic scroll axis of a motion event.
        case scroll = 26
        /// Size axis of a motion event.
        case size = 3
        /// Throttle axis of a motion event.
        case throttle = 19
        /// Tilt axis of a motion event.
        case tilt = 25
        /// ToolMajor axis of a motion event.
        case toolMajor = 6
        /// ToolMinor axis of a motion event.
        case toolMinor = 7
        /// TouchMajor axis of a motion event.
        case touchMajor = 4
        /// TouchMinor axis of a motion event.
        case touchMinor = 5
        /// Vertical Scroll axis of a motion event.
        case vScroll = 9
        /// Wheel axis of a motion event.
        case wheel = 21
        /// X axis of a motion event.
        case x = 0
        /// Y axis of a motion event.
        case y = 1
        /// Z axis of a motion event.
        case z = 11
    }

    public enum Button: Int32 {
        /// Back button pressed (mouse back button).
        case back = 8
        /// Forward button pressed (mouse forward button).
        case forward = 16
        /// Primary button (left mouse button). This button constant is not set in response to simple touches with a finger or stylus tip. The user must actually push a button.
        case primary = 1
        /// Button constant: Secondary button (right mouse button).
        case secondary = 2
        /// Primary stylus button pressed.
        case stylusPrimary = 32
        /// Secondary stylus button pressed.
        case stylusSecondary = 64
        /// Tertiary button (middle mouse button).
        case tertiary = 4
    }

    public enum Classification: Int32 {
        /// Ambiguous gesture. The user's intent with respect to the current event stream is not yet determined. Gestural actions, such as scrolling, should be inhibited until the classification resolves to another value or the event stream ends.
        case ambiguous = 1
        /// Deep press. The current event stream represents the user intentionally pressing harder on the screen. This classification type should be used to accelerate the long press behaviour.
        case deepPress = 2
        /// None. No additional information is available about the current motion event stream.
        case none = 0
        /// Touchpad pinch. The current event stream represents the user pinching with two fingers on a touchpad. The gesture is centered around the current cursor position.
        case pinch = 5
        /// Touchpad scroll. The current event stream represents the user scrolling with two fingers on a touchpad.
        case twoFingerSwipe = 3
    }

    public enum Edge: Int32 {
        /// Flag indicating the motion event intersected the left edge of the screen.
        case left = 4
        /// Flag indicating the motion event intersected the right edge of the screen.
        case right = 8
        /// Flag indicating the motion event intersected the top edge of the screen.
        case top = 1
    }

    public enum Flag: Int32 {
        /// This flag is only set for events with ACTION_POINTER_UP and ACTION_CANCEL. It indicates that the pointer going up was an unintentional user touch. When FLAG_CANCELED is set, the typical actions that occur in response for a pointer going up (such as click handlers, end of drawing) should be aborted. This flag is typically set when the user was accidentally touching the screen, such as by gripping the device, or placing the palm on the screen.
        case canceled = 32
        /// This flag indicates that the window that received this motion event is partly or wholly obscured by another visible window above it and the event directly passed through the obscured area. A security sensitive application can check this flag to identify situations in which a malicious application may have covered up part of its content for the purpose of misleading the user or hijacking touches. An appropriate response might be to drop the suspect touches or to take additional precautions to confirm the user's actual intent.
        case windowIsObscured = 1
        /// This flag indicates that the window that received this motion event is partly or wholly obscured by another visible window above it and the event did not directly pass through the obscured area. A security sensitive application can check this flag to identify situations in which a malicious application may have covered up part of its content for the purpose of misleading the user or hijacking touches. An appropriate response might be to drop the suspect touches or to take additional precautions to confirm the user's actual intent. Unlike FLAG_WINDOW_IS_OBSCURED, this is only true if the window that received this event is obstructed in areas other than the touched location.
        case windowIsPartiallyObscured = 2
    }

    public enum ToolType: Int32 {
        /// The tool is an eraser or a stylus being used in an inverted posture.
        case eraser = 4
        /// The tool is a finger.
        case finger = 1
        /// The tool is a mouse.
        case mouse = 3
        /// The tool is a stylus.
        case stylus = 2
        /// Unknown tool type. This constant is used when the tool type is not known or is not relevant, such as for a trackball or other non-pointing device.
        case unknown = 0
    }
}

// MARK: - DragEvent

/// Representation of a clipped data on the clipboard.
///
/// ClipData is a complex type containing one or more Item instances,
/// each of which can hold one or more representations of an item of data.
/// For display to the user, it also has a label.
/// 
/// [Learn more](https://developer.android.com/reference/android/content/ClipData)
open class ClipData: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/content/ClipData" }
    // TODO: Move to appropriate place
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement methods
}

/// Meta-data describing the contents of a ClipData. Provides enough information to know if you can handle the ClipData, but not the data itself.
/// 
/// [Learn more](https://developer.android.com/reference/android/content/ClipDescription)
open class ClipDescription: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/content/ClipDescription" }
    // TODO: Move to appropriate place
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement methods
}

/// Class Object is the root of the class hierarchy. Every class has Object as a superclass. All objects, including arrays, implement the methods of this class.
/// 
/// [Learn more](https://developer.android.com/reference/java/lang/Object)
open class Object: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "java/lang/Object" }
    // TODO: Move to appropriate place
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

/// Container for a message (data and object references) that can be sent through an IBinder.
///
/// A Parcel can contain both flattened data that will be unflattened on the other side of the IPC
/// (using the various methods here for writing specific types, or the general Parcelable interface),
/// and references to live IBinder objects that will result in the other side receiving a proxy IBinder
/// connected with the original IBinder in the Parcel.
/// 
/// [Learn more](https://developer.android.com/reference/android/os/Parcel)
open class Parcel: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/os/Parcel" }
    // TODO: Move to appropriate place
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement methods
}

/// Represents an event that is sent out by the system at various times
/// during a drag and drop operation. It is a data structure that contains
/// several important pieces of data about the operation and the underlying data.
///
/// [Learn more](https://developer.android.com/reference/android/view/DragEvent)
open class DragEvent: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/DragEvent" }
    
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    /// Inspect the action value of this event.
    public func getAction() -> Action? {
        guard let value = object.callIntMethod(name: "getAction") else { return nil }
        return .init(rawValue: value)
    }

    /// Returns the `ClipData` object sent to the system as part of the call to `startDragAndDrop()`.
    ///
    /// This method only returns valid data if the event action is `ACTION_DROP`.
    public func getClipData() -> ClipData? {
        guard
            let global = object.callObjectMethod(name: "getClipData", returning: .object(ClipData.className))
        else { return nil }
        return .init(global)
    }

    public func getClipDescription() -> ClipDescription? {
        guard
            let global = object.callObjectMethod(name: "getClipDescription", returning: .object(ClipDescription.className))
        else { return nil }
        return .init(global)
    }

    /// Returns the local state object sent to the system as part of the call to `startDragAndDrop()`. The object is intended to provide local information about the drag and drop operation. For example, it can indicate whether the drag and drop operation is a copy or a move.
    ///
    /// The local state is available only to views in the activity which has started the drag operation. In all other activities this method will return null
    ///
    /// This method returns valid data for all event actions.
    public func getLocalState() -> JObject? {
        object.callObjectMethod(name: "getLocalState")
    }

    /// Returns an indication of the result of the drag and drop operation. This method only returns valid data if the action type is `ACTION_DRAG_ENDED`. The return value depends on what happens after the user releases the drag shadow.
    ///
    /// If the user releases the drag shadow on a View that can accept a drop, the system sends an `ACTION_DROP` event to the View object's drag event listener. If the listener returns true, then `getResult()` will return true. If the listener returns false, then `getResult()` returns false.
    ///
    /// Notice that `getResult()` also returns false if no `ACTION_DROP` is sent. This happens, for example, when the user releases the drag shadow over an area outside of the application. In this case, the system sends out `ACTION_DRAG_ENDED` for the current operation, but never sends out `ACTION_DROP`.
    public func getResult() -> Bool? {
        object.callBoolMethod(name: "getResult")
    }

    /// Gets the X coordinate of the drag point.
    ///
    /// The value is only valid if the event action is `ACTION_DRAG_STARTED`, `ACTION_DRAG_LOCATION` or `ACTION_DROP`.
    public func getX() -> Float? {
        object.callFloatMethod(name: "getX")
    }

    /// Gets the Y coordinate of the drag point.
    ///
    /// The value is only valid if the event action is `ACTION_DRAG_STARTED`, `ACTION_DRAG_LOCATION` or `ACTION_DROP`.
    public func getY() -> Float? {
        object.callFloatMethod(name: "getY")
    }

    public func writeToParcel(_ dest: Parcel, _ flags: Int) {
        object.callVoidMethod(name: "writeToParcel", args: dest.object.signed(as: Parcel.className), Int32(flags))
    }
}

extension DragEvent {
    public enum Action: Int32 {
        /// Signals to a View that the drag and drop operation has concluded.
        ///
        /// A View that changed its appearance during the operation should return to its usual drawing state in response to this event.
        case dragEnded = 4
        /// Signals to a View that the drag point has entered the bounding box of the View.
        case dragEntered = 5
        /// Signals that the user has moved the drag shadow out of the bounding box of the View or into a descendant view that can accept the data.
        ///
        /// The View can react by changing its appearance in a way that tells the user that View is no longer the immediate drop target.
        case dragExited = 6
        /// Sent to a View after `ACTION_DRAG_ENTERED` while the drag shadow is still within the View object's bounding box,
        /// but not within a descendant view that can accept the data. The `getX()` and `getY()` methods supply the X and Y position
        /// of the drag point within the View object's bounding box.
        case dragLocation = 2
        /// Signals the start of a drag and drop operation. The View should return true from its `onDragEvent()` handler method or `OnDragListener.onDrag()` listener if it can accept a drop.
        case dragStarted = 1
        /// Signals to a View that the user has released the drag shadow, and the drag point is within the bounding box of the View and not within a descendant view that can accept the data.
        case drop = 3
    }
}

// MARK: - KeyEvent

// TODO: implement KeyCharacterMap
/// Describes the keys provided by a keyboard device and their associated labels.
///
/// [Learn more](https://developer.android.com/reference/android/view/KeyCharacterMap)
public final class KeyCharacterMap: JObjectable, @unchecked Sendable {
    public class var className: JClassName { "android/view/KeyCharacterMap" }
    
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }
}

/// Object used to report key and button events.
///
/// Each key press is described by a sequence of key events.
/// A key press starts with a key event with `ACTION_DOWN`.
/// If the key is held sufficiently long that it repeats, then the initial down is followed additional key events with `ACTION_DOWN`
/// and a non-zero value for `getRepeatCount()`.
/// The last key event is a `ACTION_UP` for the key up. If the key press is canceled,
// the key up event will have the `FLAG_CANCELED` flag set.
///
/// [Learn more](https://developer.android.com/reference/android/view/KeyEvent)
open class KeyEvent: JObjectable, @unchecked Sendable {
    open class var className: JClassName { "android/view/KeyEvent" }
    
    /// JNI reference
    public let object: JObject

    public init (_ object: JObject) {
        self.object = object
    }

    // TODO: implement initializer
    /// Make an exact copy of an existing key event.
    // public init (_ origEvent: KeyEvent) {}
    // TODO: implement initializer
    /// Copy an existing key event, modifying its time and repeat count.
    // public init (_ origEvent: KeyEvent, eventTime: Int, newRepeat: Int) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (_ action: Action, _ key: KeyCode) {}
    // TODO: implement initializer
    /// Create a new key event for a string of characters.
    /// 
    /// The key code, action, repeat count and source will automatically be set to `KEYCODE_UNKNOWN`, `ACTION_MULTIPLE`, 0, and `InputDevice.SOURCE_KEYBOARD` for you.
    // public init (time: Int, characters: String, deviceId: Int, flags: Flag) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (downTime: Int64, eventTime: Int, action: Action, key: KeyCode, repeat: Int) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (downTime: Int64, eventTime: Int, action: Action, key: KeyCode, repeat: Int, metaState: Int) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (downTime: Int64, eventTime: Int, action: Action, key: KeyCode, repeat: Int, metaState: Int, deviceId: Int, scanCode: Int) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (downTime: Int64, eventTime: Int, action: Action, key: KeyCode, repeat: Int, metaState: Int, deviceId: Int, scanCode: Int, flags: Flag) {}
    // TODO: implement initializer
    /// Create a new key event.
    // public init (downTime: Int64, eventTime: Int, action: Action, key: KeyCode, repeat: Int, metaState: Int, deviceId: Int, scanCode: Int, flags: Flag, dource: Int) {}

    // MARK: Methods
    
    // TODO: implement static method
    /// Create a new key event that is the same as the given one, but whose action is replaced with the given value.
    // public static func changeAction(_ eevent: KeyEvent, _ action: Action) -> KeyEvent? {}
    // TODO: implement static method
    /// Create a new key event that is the same as the given one, but whose flags are replaced with the given value.
    // public static func changeFlags(_ event: KeyEvent, flags: Flag) -> KeyEvent? {}
    // TODO: implement static method
    /// Create a new key event that is the same as the given one, but whose flags are replaced with the given value.
    // public static func changeTimeRepeat(_ event: KeyEvent, eventTime: Int, newRepeat: Int, newFlags: Flag) -> KeyEvent? {}
    // TODO: implement static method
    /// Create a new key event that is the same as the given one, but whose flags are replaced with the given value.
    // public static func changeTimeRepeat(_ event: KeyEvent, eventTime: Int, newRepeat: Int) -> KeyEvent? {}
    // TODO: implement method
    /// Deliver this key event to a Callback interface. If this is an `ACTION_MULTIPLE` event and it is not handled, then an attempt will be made to deliver a single normal event.
    // public func dispatch() -> Bool {}

    public func getAction() -> Action? {
        guard let value = object.callIntMethod(name: "getAction") else { return nil }
        return .init(rawValue: value)
    }

    /// Get the character that is produced by putting accent on the character c. For example, getDeadChar('`', 'e') returns è.
    public func getDeadChar(accent: Int, c: Int) -> Int? {
        guard let value = object.callIntMethod(name: "getDeadChar", args: Int32(accent), Int32(c)) else { return nil }
        return Int(value)
    }

    /// Gets the id for the device that this event came from.
    /// An id of zero indicates that the event didn't come from a physical device and maps to the default keymap.
    /// The other numbers are arbitrary and you shouldn't depend on the values.
    public func getDeviceId() -> Int? {
        guard let value = object.callIntMethod(name: "getDeviceId") else { return nil }
        return Int(value)
    }

    /// Gets the primary character for this key. In other words, the label that is physically printed on it.
    public func getDisplayLabel() -> UInt16? {
        object.callCharMethod(name: "getDisplayLabel")
    }

    /// Retrieve the time of the most recent key down event, in the `SystemClock.uptimeMillis()` time base. If this is a down event, this will be the same as `getEventTime()`. Note that when chording keys, this value is the down time of the most recently pressed key, which may not be the same physical key of this event.
    public func getDownTime() -> Float? {
        object.callFloatMethod(name: "getDownTime")
    }

    /// Retrieve the time this event occurred, in the `SystemClock.uptimeMillis()` time base.
    public func getEventTime() -> Int? {
        guard let value = object.callLongMethod(name: "getEventTime") else { return nil }
        return Int(value)
    }

    /// Returns the flags for this key event.
    public func getFlags() -> Flag? {
        guard let value = object.callIntMethod(name: "getFlags") else { return nil }
        return .init(rawValue: value)
    }

    /// Gets the `KeyCharacterMap` associated with the keyboard device.
    public func getKeyCharacterMap() -> KeyCharacterMap? {
        guard
            let global = object.callObjectMethod(name: "getKeyCharacterMap", returning: .object(KeyCharacterMap.className))
        else { return nil }
        return .init(global)
    }

    /// Retrieve the key code of the key event.
    ///
    /// This is the physical key that was pressed, not the Unicode character.
    public func getKeyCode() -> KeyCode? {
        guard let value = object.callIntMethod(name: "getKeyCode") else { return nil }
        return .init(rawValue: value)
    }

    /// Gets the first character in the character array that can be generated by the specified key code.
    ///
    /// If there are multiple choices, prefers the one that would be generated with the specified meta key modifier state.
    public func getMatch(_ chars: [UInt16], metaState: Int? = nil) -> UInt16? {
        // TODO: implement method
        return nil
    }

    /// Returns the maximum keycode.
    public func getMaxKeyCode() -> Int? {
        guard let value = object.callIntMethod(name: "getMaxKeyCode") else { return nil }
        return Int(value)
    }

    /// Returns the state of the meta keys.
    public func getMetaState() -> Int? {
        guard let value = object.callIntMethod(name: "getMetaState") else { return nil }
        return Int(value)
    }

    /// Gets a mask that includes all valid modifier key meta state bits.
    public func getModifierMetaStateMask() -> Int? {
        guard let value = object.callIntMethod(name: "getModifierMetaStateMask") else { return nil }
        return Int(value)
    }

    /// Returns the state of the modifier keys.
    public func getModifiers() -> Int? {
        guard let value = object.callIntMethod(name: "getModifiers") else { return nil }
        return Int(value)
    }

    /// Gets the number or symbol associated with the key.
    ///
    /// The character value is returned, not the numeric value. If the key is not a number, but is a symbol, the symbol is retuned.
    public func getNumber() -> UInt16? {
        object.callCharMethod(name: "getNumber")
    }

    /// Retrieve the repeat count of the event.
    /// For key down events, this is the number of times the key has repeated with the first down starting at 0 and counting up from there.
    /// For key up events, this is always equal to zero. For multiple key events, this is the number of down/up pairs that have occurred.
    public func getRepeatCount() -> Int? {
        guard let value = object.callIntMethod(name: "getRepeatCount") else { return nil }
        return Int(value)
    }

    /// Retrieve the hardware key id of this key event. These values are not reliable and vary from device to device.
    ///
    /// Mostly this is here for debugging purposes.
    public func getScanCode() -> Int? {
        guard let value = object.callIntMethod(name: "getScanCode") else { return nil }
        return Int(value)
    }

    /// Gets the source of the event.
    public func getSource() -> Int? {
        guard let value = object.callIntMethod(name: "getSource") else { return nil }
        return Int(value)
    }

    /// Gets the Unicode character generated by the specified key and meta key state combination.
    ///
    /// Returns the Unicode character that the specified key would produce when the specified meta bits
    /// (see [MetaKeyKeyListener](https://developer.android.com/reference/android/text/method/MetaKeyKeyListener)) were active.
    ///
    /// Returns 0 if the key is not one that is used to type Unicode characters.
    public func getUnicodeChar(metaState: Int? = nil) -> Int? {
        var args: [any JSignatureItemable] = []
        if let metaState {
            args.append(Int32(metaState))
        }
        guard let value = object.callIntMethod(name: "getUnicodeChar", args: args) else { return nil }
        return Int(value)
    }

    /// Returns true if only the specified modifiers keys are pressed. Returns false if a different combination of modifier keys are pressed.
    public func hasModifiers(modifiers: Int) -> Bool? {
        object.callBoolMethod(name: "hasModifiers", args: Int32(modifiers))
    }

    /// Returns true if no modifier keys are pressed.
    public func hasNoModifiers() -> Bool? {
        object.callBoolMethod(name: "hasNoModifiers")
    }

    /// Returns the pressed state of the `ALT` meta key.
    public func isAltPressed() -> Bool? {
        object.callBoolMethod(name: "isAltPressed")
    }

    /// For `ACTION_UP` events, indicates that the event has been canceled as per `FLAG_CANCELED`.
    public func isCanceled() -> Bool? {
        object.callBoolMethod(name: "isCanceled")
    }

    /// Returns the locked state of the `CAPS LOCK` meta key.
    public func isCapsLockOn() -> Bool? {
        object.callBoolMethod(name: "isCapsLockOn")
    }

    /// Returns the pressed state of the `CTRL` meta key.
    public func isCtrlPressed() -> Bool? {
        object.callBoolMethod(name: "isCtrlPressed")
    }

    /// Returns the pressed state of the `FUNCTION` meta key.
    public func isFunctionPressed() -> Bool? {
        object.callBoolMethod(name: "isFunctionPressed")
    }

    /// Returns true if the specified keycode is a gamepad button.
    public func isGamepadButton(_ key: KeyCode) -> Bool? {
        object.callBoolMethod(name: "isGamepadButton", args: key.rawValue)
    }

    /// For `ACTION_DOWN` events, indicates that the event has been canceled as per `FLAG_LONG_PRESS`.
    public func isLongPress() -> Bool? {
        object.callBoolMethod(name: "isLongPress")
    }

    /// Returns whether this key will be sent to the `MediaSession.Callback` if not handled.
    public func isMediaSessionKey(_ key: KeyCode) -> Bool? {
        object.callBoolMethod(name: "isMediaSessionKey", args: key.rawValue)
    }

    /// Returns the pressed state of the `META` meta key.
    public func isMetaPressed() -> Bool? {
        object.callBoolMethod(name: "isMetaPressed")
    }

    /// Returns true if this key code is a modifier key.
    public func isModifierKey(_ key: KeyCode) -> Bool? {
        object.callBoolMethod(name: "isModifierKey", args: key.rawValue)
    }

    /// Returns the locked state of the `NUM LOCK` meta key.
    public func isNumLockOn() -> Bool? {
        object.callBoolMethod(name: "isNumLockOn")
    }

    /// Returns true if this key produces a glyph.
    public func isPrintingKey() -> Bool? {
        object.callBoolMethod(name: "isPrintingKey")
    }

    /// Returns the locked state of the `SCROLL LOCK` meta key.
    public func isScrollLockOn() -> Bool? {
        object.callBoolMethod(name: "isScrollLockOn")
    }

    /// Returns the pressed state of the `SHIFT` meta key.
    public func isShiftPressed() -> Bool? {
        object.callBoolMethod(name: "isShiftPressed")
    }

    /// Returns the pressed state of the `SYM` meta key.
    public func isSymPressed() -> Bool? {
        object.callBoolMethod(name: "isSymPressed")
    }

    /// Is this a system key? System keys can not be used for menu shortcuts.
    public func isSystem() -> Bool? {
        object.callBoolMethod(name: "isSystem")
    }

    /// For `ACTION_UP` events, indicates that the event is still being tracked from its initial down event as per `FLAG_TRACKING`.
    public func isTracking() -> Bool? {
        object.callBoolMethod(name: "isTracking")
    }

    // TODO: implement static methods
    // public static func keyCodeFromString
    // public static func keyCodeToString
    // public static func metaStateHasModifiers
    // public static func metaStateHasNoModifiers
    // public static func normalizeMetaState

    public func setSource(_ source: Int) {
        object.callVoidMethod(name: "setSource", args: Int32(source))
    }

    /// Call this during `Callback.onKeyDown` to have the system track the key through its final up (possibly including a long press). Note that only one key can be tracked at a time -- if another key down event is received while a previous one is being tracked, tracking is stopped on the previous event.
    public func startTracking() {
        object.callVoidMethod(name: "startTracking")
    }

    /// Flatten this object in to a Parcel.
    public func writeToParcel(_ parcel: Parcel, flags: Flag) {
        object.callVoidMethod(name: "setSource", args: parcel.object.signed(as: Parcel.className), flags.rawValue)
    }
}

extension KeyEvent {
    public enum Action: Int32 {
        /// The key has been pressed down.
        case down = 0
        /// The key has been released.
        case up = 1
        /// **This constant was deprecated in API level 29.**
        case multiple = 2
    }

    public enum Flag: Int32 {
        /// When associated with up key events, this indicates that the key press has been canceled.
        ///
        /// Typically this is used with virtual touch screen keys, where the user can slide from the virtual
        /// key area on to the display: in that case, the application will receive a canceled up event
        /// and should not perform the action normally associated with the key.
        ///
        /// Note that for this to work, the application can not perform an action for a key until it receives
        /// an up or the long press timeout has expired.
        case canceled = 32
        /// Set when a key event has `FLAG_CANCELED` set because a long press action was executed while it was down.
        case canceledLongPress = 256
        /// This mask is used for compatibility, to identify enter keys that are coming
        /// from an IME whose enter key has been auto-labelled "next" or "done".
        /// This allows TextView to dispatch these as normal enter keys for old applications,
        /// but still do the appropriate action when receiving them.
        case editorAction = 16
        /// Set when a key event has been synthesized to implement default behavior for an event that the application did not handle.
        ///
        /// Fallback key events are generated by unhandled trackball motions (to emulate a directional keypad)
        /// and by certain unhandled key presses that are declared in the key map
        /// (such as special function numeric keypad keys when numlock is off).
        case fallback = 1024
        /// This mask is set if an event was known to come from a trusted part of the system.
        /// That is, the event is known to come from the user, and could not have been spoofed by a third party component.
        case fromSystem = 8
        /// This mask is set if we don't want the key event to cause us to leave touch mode.
        case keeptouchMode = 4
        /// This flag is set for the first key repeat that occurs after the long press timeout.
        case longPress = 128
        /// This mask is set if the key event was generated by a software keyboard.
        case softKeyboard = 2
        /// Set for `ACTION_UP` when this event's key code is still being tracked from its initial down.
        ///
        /// That is, somebody requested that tracking started on the key down and a long press has not caused the tracking to be canceled.
        case tracking = 512
        /// This key event was generated by a virtual (on-screen) hard key area. Typically this is an area of the touchscreen, outside of the regular display, dedicated to "hardware" buttons.
        case virtualHardKey = 64
    }

    public enum KeyCode: Int32 {
        /// '0' key.
        case n0 = 7
        /// '1' key.
        case n1 = 8
        /// '11' key.
        case n11 = 227
        /// '12' key.
        case n12 = 228
        /// '2' key.
        case n2 = 9
        /// '3' key.
        case n3 = 10
        /// 3D Mode key.
        ///
        /// Toggles the display between 2D and 3D mode.
        case k3dMode = 206
        /// '4' key.
        case n4 = 11
        /// '5' key.
        case n5 = 12
        /// '6' key.
        case n6 = 13
        /// '7' key.
        case n7 = 14
        /// '8' key.
        case n8 = 15
        /// '9' key.
        case n9 = 16
        /// 'A' key.
        case a = 29
        /// Show all apps.
        case allApps = 284
        /// Left Alt modifier key.
        case altLeft = 57
        /// Right Alt modifier key.
        case altRight = 58
        /// ''' (apostrophe) key.
        case apostrophe = 75
        /// App switch key.
        ///
        /// Should bring up the application switcher dialog.
        case appSwitch = 187
        /// Assist key.
        ///
        /// Launches the global assist activity. Not delivered to applications.
        case assist = 219
        /// '@' key.
        case at = 77
        /// A/V Receiver input key.
        ///
        /// On TV remotes, switches the input mode on an external A/V Receiver.
        case avrInput = 182
        /// A/V Receiver power key.
        ///
        /// On TV remotes, toggles the power on an external A/V Receiver.
        case avrPower = 181
        /// 'B' key.
        case b = 30
        /// Back key.
        case back = 4
        /// '' key.
        case backslash = 73
        /// Bookmark key.
        ///
        /// On some TV remotes, bookmarks content or web pages.
        case bookmark = 174
        /// Break / Pause key.
        case `break` = 121
        /// Brightness Down key.
        ///
        /// Adjusts the screen brightness down.
        case brightnessDown = 220
        /// Brightness Up key.
        ///
        /// Adjusts the screen brightness up.
        case brightnessUp = 221
        /// Generic Game Pad Button #1.
        case button1 = 188
        /// Generic Game Pad Button #10.
        case button10 = 197
        /// Generic Game Pad Button #11.
        case button11 = 198
        /// Generic Game Pad Button #12.
        case button12 = 199
        /// Generic Game Pad Button #13.
        case button13 = 200
        /// Generic Game Pad Button #14.
        case button14 = 201
        /// Generic Game Pad Button #15.
        case button15 = 202
        /// Generic Game Pad Button #16.
        case button16 = 203
        /// Generic Game Pad Button #2.
        case button2 = 189
        /// Generic Game Pad Button #3.
        case button3 = 190
        /// Generic Game Pad Button #4.
        case button4 = 191
        /// Generic Game Pad Button #5.
        case button5 = 192
        /// Generic Game Pad Button #6.
        case button6 = 193
        /// Generic Game Pad Button #7.
        case button7 = 194
        /// Generic Game Pad Button #8.
        case button8 = 195
        /// Generic Game Pad Button #9.
        case button9 = 196
        /// A Button key.
        ///
        /// On a game controller, the A button should be either the button labeled A or the first button on the bottom row of controller buttons.
        case buttonA = 96
        /// B Button key.
        ///
        /// On a game controller, the B button should be either the button labeled B or the second button on the bottom row of controller buttons.
        case buttonB = 97
        /// C Button key.
        ///
        /// On a game controller, the C button should be either the button labeled C or the third button on the bottom row of controller buttons.
        case buttonC = 98
        /// L1 Button key.
        ///
        /// On a game controller, the L1 button should be either the button labeled L1 (or L) or the top left trigger button.
        case buttonL1 = 102
        /// L2 Button key.
        ///
        /// On a game controller, the L2 button should be either the button labeled L2 or the bottom left trigger button.
        case buttonL2 = 104
        /// Mode Button key.
        ///
        /// On a game controller, the button labeled Mode.
        case buttonMode = 110
        /// R1 Button key.
        ///
        /// On a game controller, the R1 button should be either the button labeled R1 (or R) or the top right trigger button.
        case buttonR1 = 103
        /// R2 Button key.
        ///
        /// On a game controller, the R2 button should be either the button labeled R2 or the bottom right trigger button.
        case buttonR2 = 105
        /// Select Button key.
        ///
        /// On a game controller, the button labeled Select.
        case buttonSelect = 109
        /// Start Button key.
        ///
        /// On a game controller, the button labeled Start.
        case buttonStart = 108
        /// Left Thumb Button key.
        ///
        /// On a game controller, the left thumb button indicates that the left (or only) joystick is pressed.
        case buttonThumbl = 106
        /// Right Thumb Button key.
        ///
        /// On a game controller, the right thumb button indicates that the right joystick is pressed.
        case buttonThumbr = 107
        /// X Button key.
        ///
        /// On a game controller, the X button should be either the button labeled X or the first button on the upper row of controller buttons.
        case buttonX = 99
        /// Y Button key.
        ///
        /// On a game controller, the Y button should be either the button labeled Y or the second button on the upper row of controller buttons.
        case buttonY = 100
        /// Z Button key.
        ///
        /// On a game controller, the Z button should be either the button labeled Z or the third button on the upper row of controller buttons.
        case buttonZ = 101
        /// 'C' key.
        case c = 31
        /// Calculator special function key.
        ///
        /// Used to launch a calculator application.
        case calculator = 210
        /// Calendar special function key.
        ///
        /// Used to launch a calendar application.
        case calendar = 208
        /// Call key.
        case call = 5
        /// Camera key.
        ///
        /// Used to launch a camera application or take pictures.
        case camera = 27
        /// Caps Lock key.
        case capsLock = 115
        /// Toggle captions key.
        ///
        /// Switches the mode for closed-captioning text, for example during television shows.
        case captions = 175
        /// Channel down key.
        ///
        /// On TV remotes, decrements the television channel.
        case channelDown = 167
        /// Channel up key.
        ///
        /// On TV remotes, increments the television channel.
        case channelUp = 166
        /// Clear key.
        case clear = 28
        /// AC Close.
        ///
        /// e.g. To close current instance of the application window, close the current tab, etc.
        case close = 321
        /// ',' key.
        case comma = 55
        /// Contacts special function key.
        ///
        /// Used to launch an address book application.
        case contacts = 207
        /// Copy key.
        case copy = 278
        /// Left Control modifier key.
        case ctrlLeft = 113
        /// Right Control modifier key.
        case ctrlRight = 114
        /// Cut key.
        case cut = 277
        /// 'D' key.
        case d = 32
        /// Backspace key.
        case del = 67
        /// Demo Application key #1.
        case demoApp1 = 301
        /// Demo Application key #2.
        case demoApp2 = 302
        /// Demo Application key #3.
        case demoApp3 = 303
        /// Demo Application key #4.
        case demoApp4 = 304
        /// To start dictate to an input field
        case dictate = 319
        /// To toggle 'Do Not Disturb' mode.
        case doNotDisturb = 322
        /// Directional Pad Center key.
        ///
        /// May also be synthesized from trackball motions.
        case dpadCenter = 23
        /// Directional Pad Down key.
        ///
        /// May also be synthesized from trackball motions.
        case dpadDown = 20
        /// Directional Pad Down-Left.
        case dpadDownLeft = 269
        /// Directional Pad Down-Right.
        case dpadDownRight = 271
        /// Directional Pad Left key.
        ///
        /// May also be synthesized from trackball motions.
        case dpadLeft = 21
        /// Directional Pad Right key.
        ///
        /// May also be synthesized from trackball motions.
        case dpadRight = 22
        /// Directional Pad Up key.
        ///
        /// May also be synthesized from trackball motions.
        case dpadUp = 19
        /// Directional Pad Up-Left.
        case dpadUpLeft = 268
        /// Directional Pad Up-Right.
        case dpadUpRight = 270
        /// DVR key.
        ///
        /// On some TV remotes, switches to a DVR mode for recorded shows.
        case dvr = 173
        /// 'E' key.
        case e = 33
        /// Japanese alphanumeric key.
        case eisu = 212
        /// To open emoji picker.
        case emojiPicker = 317
        /// End Call key.
        case endcall = 6
        /// Enter key.
        case enter = 66
        /// Envelope special function key.
        ///
        /// Used to launch a mail application.
        case envelope = 65
        /// '=' key.
        case equals = 70
        /// Escape key.
        case escape = 111
        /// Explorer special function key.
        ///
        /// Used to launch a browser application.
        case explorer = 64
        /// 'F' key.
        case f = 34
        /// F1 key.
        case f1 = 131
        /// F10 key.
        case f10 = 140
        /// F11 key.
        case f11 = 141
        /// F12 key.
        case f12 = 142
        /// F13 key.
        case f13 = 326
        /// F14 key.
        case f14 = 327
        /// F15 key.
        case f15 = 328
        /// F16 key.
        case f16 = 329
        /// F17 key.
        case f17 = 330
        /// F18 key.
        case f18 = 331
        /// F19 key.
        case f19 = 332
        /// F2 key.
        case f2 = 132
        /// F20 key.
        case f20 = 333
        /// F21 key.
        case f21 = 334
        /// F22 key.
        case f22 = 335
        /// F23 key.
        case f23 = 336
        /// F24 key.
        case f24 = 337
        /// F3 key.
        case f3 = 133
        /// F4 key.
        case f4 = 134
        /// F5 key.
        case f5 = 135
        /// F6 key.
        case f6 = 136
        /// F7 key.
        case f7 = 137
        /// F8 key.
        case f8 = 138
        /// F9 key.
        case f9 = 139
        /// Featured Application key #1.
        case featuredApp1 = 297
        /// Featured Application key #2.
        case featuredApp2 = 298
        /// Featured Application key #3.
        case featuredApp3 = 299
        /// Featured Application key #4.
        case featuredApp4 = 300
        /// Camera Focus key.
        ///
        /// Used to focus the camera.
        case focus = 80
        /// Forward key.
        case forward = 125
        /// Forward Delete key.
        case forwardDel = 112
        /// To toggle fullscreen mode (on the current application).
        case fullscreen = 325
        /// Function modifier key.
        case function = 119
        /// 'G' key.
        case g = 35
        /// '`' (backtick) key.
        case grave = 68
        /// Guide key.
        ///
        /// On TV remotes, shows a programming guide.
        case guide = 172
        /// 'H' key.
        case h = 36
        /// Headset Hook key.
        ///
        /// Used to hang up calls and stop media.
        case headsethook = 79
        /// Help key.
        case help = 259
        /// Japanese conversion key.
        case henkan = 214
        /// Home key.
        ///
        /// This key is handled by the framework and is never delivered to applications.
        case home = 3
        /// 'I' key.
        case i = 37
        /// Info key.
        ///
        /// Common on TV remotes to show additional information related to what is currently being viewed.
        case info = 165
        /// Insert key.
        ///
        /// Toggles insert / overwrite edit mode.
        case insert = 124
        /// 'J' key.
        case j = 38
        /// 'K' key.
        case k = 39
        /// Japanese kana key.
        case kana = 218
        /// Japanese katakana / hiragana key.
        case katakanaHiragana = 215
        /// Keyboard backlight down.
        case keyboardBacklightDown = 305
        /// Keyboard backlight toggle.
        case keyboardBacklightToggle = 307
        /// Keyboard backlight up.
        case keyboardBacklightUp = 306
        /// 'L' key.
        case l = 40
        /// Language Switch key.
        ///
        /// Toggles the current input language such as switching between English and Japanese on a QWERTY keyboard. On some devices, the same function may be performed by pressing Shift + Spacebar.
        case languageSwitch = 204
        /// Last Channel key.
        ///
        /// Goes to the last viewed channel.
        case lastChannel = 229
        /// '[' key.
        case leftBracket = 71
        /// To lock the screen.
        case lock = 324
        /// 'M' key.
        case m = 41
        /// A button whose usage can be customized by the user through the system.
        ///
        /// User customizable key #1.
        case macro1 = 313
        /// A button whose usage can be customized by the user through the system.
        ///
        /// User customizable key #2.
        case macro2 = 314
        /// A button whose usage can be customized by the user through the system.
        ///
        /// User customizable key #3.
        case macro3 = 315
        /// A button whose usage can be customized by the user through the system.
        ///
        /// User customizable key #4.
        case macro4 = 316
        /// Manner Mode key.
        ///
        /// Toggles silent or vibrate mode on and off to make the device behave more politely in certain settings such as on a crowded train. On some devices, the key may only operate when long-pressed.
        case mannerMode = 205
        /// Audio Track key.
        ///
        /// Switches the audio tracks.
        case mediaAudioTrack = 222
        /// Close media key.
        ///
        /// May be used to close a CD tray, for example.
        case mediaClose = 128
        /// Eject media key.
        ///
        /// May be used to eject a CD tray, for example.
        case mediaEject = 129
        /// Fast Forward media key.
        case mediaFastForward = 90
        /// Play Next media key.
        case mediaNext = 87
        /// Pause media key.
        case mediaPause = 127
        /// Play media key.
        case mediaPlay = 126
        /// Play/Pause media key.
        case mediaPlayPause = 85
        /// Play Previous media key.
        case mediaPrevious = 88
        /// Record media key.
        case mediaRecord = 130
        /// Rewind media key.
        case mediaRewind = 89
        /// Skip backward media key.
        case mediaSkipBackward = 273
        /// Skip forward media key.
        case mediaSkipForward = 272
        /// Step backward media key.
        ///
        /// Steps media backward, one frame at a time.
        case mediaStepBackward = 275
        /// Step forward media key.
        ///
        /// Steps media forward, one frame at a time.
        case mediaStepForward = 274
        /// Stop media key.
        case mediaStop = 86
        /// Media Top Menu key.
        ///
        /// Goes to the top of media menu.
        case mediaTopMenu = 226
        /// Menu key.
        case menu = 82
        /// Left Meta modifier key.
        case metaLeft = 117
        /// Right Meta modifier key.
        case metaRight = 118
        /// '-'.
        case minus = 69
        /// End Movement key.
        ///
        /// Used for scrolling or moving the cursor around to the end of a line or to the bottom of a list.
        case moveEnd = 123
        /// Home Movement key.
        ///
        /// Used for scrolling or moving the cursor around to the start of a line or to the top of a list.
        case moveHome = 122
        /// Japanese non-conversion key.
        case muhenkan = 213
        /// Music special function key.
        ///
        /// Used to launch a music player application.
        case music = 209
        /// Mute key.
        case mute = 91
        /// 'N' key.
        case n = 42
        /// Navigate in key.
        ///
        /// Activates the item that currently has focus or expands to the next level of a navigation hierarchy.
        case navigateIn = 262
        /// Navigate to next key.
        ///
        /// Advances to the next item in an ordered collection of items.
        case navigateNext = 261
        /// Navigate out key.
        ///
        /// Backs out one level of a navigation hierarchy or collapses the item that currently has focus.
        case navigateOut = 263
        /// Navigate to previous key.
        ///
        /// Goes backward by one item in an ordered collection of items.
        case navigatePrevious = 260
        /// AC New.
        ///
        /// e.g. To create a new instance of a window, open a new tab, etc.
        case new = 320
        /// Notification key.
        case notification = 83
        /// Number modifier key.
        case num = 78
        /// Numeric keypad '0' key.
        case numpad0 = 144
        /// Numeric keypad '1' key.
        case numpad1 = 145
        /// Numeric keypad '2' key.
        case numpad2 = 146
        /// Numeric keypad '3' key.
        case numpad3 = 147
        /// Numeric keypad '4' key.
        case numpad4 = 148
        /// Numeric keypad '5' key.
        case numpad5 = 149
        /// Numeric keypad '6' key.
        case numpad6 = 150
        /// Numeric keypad '7' key.
        case numpad7 = 151
        /// Numeric keypad '8' key.
        case numpad8 = 152
        /// Numeric keypad '9' key.
        case numpad9 = 153
        /// Numeric keypad '+' key (for addition).
        case numpadAdd = 157
        /// Numeric keypad ',' key (for decimals or digit grouping).
        case numpadComma = 159
        /// Numeric keypad '/' key (for division).
        case numpadDivide = 154
        /// Numeric keypad '.' key (for decimals or digit grouping).
        case numpadDot = 158
        /// Numeric keypad Enter key.
        case numpadEnter = 160
        /// Numeric keypad '=' key.
        case numpadEquals = 161
        /// Numeric keypad '(' key.
        case numpadLeftParen = 162
        /// Numeric keypad '*' key (for multiplication).
        case numpadMultiply = 155
        /// Numeric keypad ')' key.
        case numpadRightParen = 163
        /// Numeric keypad '-' key (for subtraction).
        case numpadSubtract = 156
        /// Num Lock key.
        case numLock = 143
        /// 'O' key.
        case o = 43
        /// 'P' key.
        case p = 44
        /// Page Down key.
        case pageDown = 93
        /// Page Up key.
        case pageUp = 92
        /// Pairing key.
        ///
        /// Initiates peripheral pairing mode. Useful for pairing remote control devices or game controllers, especially if no other input mode is available.
        case pairing = 225
        /// Paste key.
        case paste = 279
        /// '.' key.
        case period = 56
        /// Picture Symbols modifier key.
        ///
        /// Used to switch symbol sets (Emoji, Kao-moji).
        case pictsymbols = 94
        /// '+' key.
        case plus = 81
        /// '#' key.
        case pound = 18
        /// Power key.
        case power = 26
        /// To print.
        case print = 323
        /// Used to switch current Account that is consuming content.
        ///
        /// May be consumed by system to set account globally.
        case profileSwitch = 288
        /// Blue "programmable" key.
        ///
        /// On TV remotes, acts as a contextual/programmable key.
        case progBlue = 186
        /// Green "programmable" key.
        ///
        /// On TV remotes, acts as a contextual/programmable key.
        case progGreen = 184
        /// Red "programmable" key.
        ///
        /// On TV remotes, acts as a contextual/programmable key.
        case progRed = 183
        /// Yellow "programmable" key.
        ///
        /// On TV remotes, acts as a contextual/programmable key.
        case progYellow = 185
        /// 'Q' key.
        case q = 45
        /// 'R' key.
        case r = 46
        /// To open recent apps view (a.k.a. Overview).
        ///
        /// This key is handled by the framework and is never delivered to applications.
        case recentApps = 312
        /// Refresh key.
        case refresh = 285
        /// ']' key.
        case rightBracket = 72
        /// Japanese Ro key.
        case ro = 217
        /// 'S' key.
        case s = 47
        /// To take a screenshot.
        case screenshot = 318
        /// Scroll Lock key.
        case scrollLock = 116
        /// Search key.
        case search = 84
        /// ';' key.
        case semicolon = 74
        /// Settings key.
        ///
        /// Starts the system settings activity.
        case settings = 176
        /// Left Shift modifier key.
        case shiftLeft = 59
        /// Right Shift modifier key.
        case shiftRight = 60
        /// '/' key.
        case slash = 76
        /// Sleep key.
        case sleep = 223
        /// Soft Left key.
        ///
        /// Usually situated below the display on phones and used as a multi-function feature key for selecting a software defined function shown on the bottom left of the display.
        case softLeft = 1
        /// Soft Right key.
        ///
        /// Usually situated below the display on phones and used as a multi-function feature key for selecting a software defined function shown on the bottom right of the display.
        case softRight = 2
        /// Put device to sleep unless a wakelock is held.
        case softSleep = 276
        /// Space key.
        case space = 62
        /// '*' key.
        case star = 17
        /// Set-top-box input key.
        ///
        /// On TV remotes, switches the input mode on an external Set-top-box.
        case stbInput = 180
        /// Set-top-box power key.
        ///
        /// On TV remotes, toggles the power on an external Set-top-box.
        case stbPower = 179
        /// Generic stem key 1 for Wear.
        case stem1 = 265
        /// Generic stem key 2 for Wear.
        case stem2 = 266
        /// Generic stem key 3 for Wear.
        case stem3 = 267
        /// Primary stem key for Wear.
        ///
        /// Main power/reset button on watch.
        case stemPrimary = 264
        /// The primary button on the barrel of a stylus.
        ///
        /// This is usually the button closest to the tip of the stylus.
        case stylusButtonPrimary = 308
        /// The secondary button on the barrel of a stylus.
        ///
        /// This is usually the second button from the tip of the stylus.
        case stylusButtonSecondary = 309
        /// A button on the tail end of a stylus.
        ///
        /// The use of this button does not usually correspond to the function of an eraser.
        case stylusButtonTail = 311
        /// The tertiary button on the barrel of a stylus.
        ///
        /// This is usually the third button from the tip of the stylus.
        case stylusButtonTertiary = 310
        /// Switch Charset modifier key.
        ///
        /// Used to switch character sets (Kanji, Katakana).
        case switchCharset = 95
        /// Symbol modifier key.
        ///
        /// Used to enter alternate symbols.
        case sym = 63
        /// System Request / Print Screen key.
        case sysrq = 120
        /// Consumed by the system for navigation down.
        case systemNavigationDown = 281
        /// Consumed by the system for navigation left.
        case systemNavigationLeft = 282
        /// Consumed by the system for navigation right.
        case systemNavigationRight = 283
        /// Consumed by the system for navigation up.
        case systemNavigationUp = 280
        /// 'T' key.
        case t = 48
        /// Tab key.
        case tab = 61
        /// Thumbs down key.
        ///
        /// Apps can use this to let user downvote content.
        case thumbsDown = 287
        /// Thumbs up key.
        ///
        /// Apps can use this to let user upvote content.
        case thumbsUp = 286
        /// TV key.
        ///
        /// On TV remotes, switches to viewing live TV.
        case tv = 170
        /// Antenna/Cable key.
        ///
        /// Toggles broadcast input source between antenna and cable.
        case tvAntennaCable = 242
        /// Audio description key.
        ///
        /// Toggles audio description off / on.
        case tvAudioDescription = 252
        /// Audio description mixing volume down key.
        ///
        /// Lessen audio description volume as compared with normal audio volume.
        case tvAudioDescriptionMixDown = 254
        /// Audio description mixing volume up key.
        ///
        /// Louden audio description volume as compared with normal audio volume.
        case tvAudioDescriptionMixUp = 253
        /// Contents menu key.
        ///
        /// Goes to the title list. Corresponds to Contents Menu (0x0B) of CEC User Control Code.
        case tvContentsMenu = 256
        /// TV data service key.
        ///
        /// Displays data services like weather, sports.
        case tvDataService = 230
        /// TV input key.
        ///
        /// On TV remotes, switches the input on a television screen.
        case tvInput = 178
        /// Component #1 key.
        ///
        /// Switches to component video input #1.
        case tvInputComponent1 = 249
        /// Component #2 key.
        ///
        /// Switches to component video input #2.
        case tvInputComponent2 = 250
        /// Composite #1 key.
        ///
        /// Switches to composite video input #1.
        case tvInputComposite1 = 247
        /// Composite #2 key.
        ///
        /// Switches to composite video input #2.
        case tvInputComposite2 = 248
        /// HDMI #1 key.
        ///
        /// Switches to HDMI input #1.
        case tvInputHdmi1 = 243
        /// HDMI #2 key.
        ///
        /// Switches to HDMI input #2.
        case tvInputHdmi2 = 244
        /// HDMI #3 key.
        ///
        /// Switches to HDMI input #3.
        case tvInputHdmi3 = 245
        /// HDMI #4 key.
        ///
        /// Switches to HDMI input #4.
        case tvInputHdmi4 = 246
        /// VGA #1 key.
        ///
        /// Switches to VGA (analog RGB) input #1.
        case tvInputVga1 = 251
        /// Media context menu key.
        ///
        /// Goes to the context menu of media contents. Corresponds to Media Context-sensitive Menu (0x11) of CEC User Control Code.
        case tvMediaContextMenu = 257
        /// Toggle Network key.
        ///
        /// Toggles selecting broadcast services.
        case tvNetwork = 241
        /// Number entry key.
        ///
        /// Initiates to enter multi-digit channel number when each digit key is assigned for selecting a separate channel. Corresponds to Number Entry Mode (0x1D) of CEC User Control Code.
        case tvNumberEntry = 234
        /// TV power key.
        ///
        /// On HDMI TV panel devices and Android TV devices that don't support HDMI, toggles the power state of the device. On HDMI source devices, toggles the power state of the HDMI-connected TV via HDMI-CEC and makes the source device follow this power state.
        case tvPower = 177
        /// Radio key.
        ///
        /// Toggles TV service / Radio service.
        case tvRadioService = 232
        /// Satellite key.
        ///
        /// Switches to digital satellite broadcast service.
        case tvSatellite = 237
        /// BS key.
        ///
        /// Switches to BS digital satellite broadcasting service available in Japan.
        case tvSatelliteBs = 238
        /// CS key.
        ///
        /// Switches to CS digital satellite broadcasting service available in Japan.
        case tvSatelliteCs = 239
        /// BS/CS key.
        ///
        /// Toggles between BS and CS digital satellite services.
        case tvSatelliteService = 240
        /// Teletext key.
        ///
        /// Displays Teletext service.
        case tvTeletext = 233
        /// Analog Terrestrial key.
        ///
        /// Switches to analog terrestrial broadcast service.
        case tvTerrestrialAnalog = 235
        /// Digital Terrestrial key.
        ///
        /// Switches to digital terrestrial broadcast service.
        case tvTerrestrialDigital = 236
        /// Timer programming key.
        ///
        /// Goes to the timer recording menu. Corresponds to Timer Programming (0x54) of CEC User Control Code.
        case tvTimerProgramming = 258
        /// Zoom mode key.
        ///
        /// Changes Zoom mode (Normal, Full, Zoom, Wide-zoom, etc.).
        case tvZoomMode = 255
        /// 'U' key.
        case u = 49
        /// Unknown key code.
        case unknown = 0
        /// 'V' key.
        case v = 50
        /// Video Application key #1.
        case videoApp1 = 289
        /// Video Application key #2.
        case videoApp2 = 290
        /// Video Application key #3.
        case videoApp3 = 291
        /// Video Application key #4.
        case videoApp4 = 292
        /// Video Application key #5.
        case videoApp5 = 293
        /// Video Application key #6.
        case videoApp6 = 294
        /// Video Application key #7.
        case videoApp7 = 295
        /// Video Application key #8.
        case videoApp8 = 296
        /// Voice Assist key.
        ///
        /// Launches the global voice assist activity. Not delivered to applications.
        case voiceAssist = 231
        /// Volume Down key.
        ///
        /// Adjusts the speaker volume down.
        case volumeDown = 25
        /// Volume Mute key.
        case volumeMute = 164
        /// Volume Up key.
        ///
        /// Adjusts the speaker volume up.
        case volumeUp = 24
        /// 'W' key.
        case w = 51
        /// Wakeup key.
        case wakeup = 224
        /// Window key.
        ///
        /// On TV remotes, toggles picture-in-picture mode or other windowing functions. On Android Wear devices, triggers a display offset.
        case window = 171
        /// 'X' key.
        case x = 52
        /// 'Y' key.
        case y = 53
        /// Japanese Yen key.
        case yen = 216
        /// 'Z' key.
        case z = 54
        /// Japanese full-width / half-width key.
        case zenkakuHankaku = 211
        /// Zoom in key.
        case zoomIn = 168
        /// Zoom out key.
        case zoomOut = 169
    }

    public enum Meta: Int32 {
        /// This mask is used to check whether the left ALT meta key is pressed.
        case altLeftOn = 16
        /// This mask is a combination of `META_ALT_ON`, `META_ALT_LEFT_ON` and `META_ALT_RIGHT_ON`.
        case altMask = 50
        /// This mask is used to check whether one of the ALT meta keys is pressed.
        case altOn = 2
        /// This mask is used to check whether the right the ALT meta key is pressed.
        case altRightOn = 32
        /// This mask is used to check whether the CAPS LOCK meta key is on.
        case capsLockOn = 1048576
        /// This mask is used to check whether the left CTRL meta key is pressed.
        case ctrlLeftOn = 8192
        /// This mask is a combination of `META_CTRL_ON`, `META_CTRL_LEFT_ON` and `META_CTRL_RIGHT_ON`.
        case ctrlMask = 28672
        /// This mask is used to check whether one of the CTRL meta keys is pressed.
        case ctrlOn = 4096
        /// This mask is used to check whether the right CTRL meta key is pressed.
        case ctrlRightOn = 16384
        /// This mask is used to check whether the FUNCTION meta key is pressed.
        case functionOn = 8
        /// This mask is used to check whether the left META meta key is pressed.
        case metaLeftOn = 131072
        /// This mask is a combination of `META_META_ON`, `META_META_LEFT_ON` and `META_META_RIGHT_ON`.
        case metaMask = 458752
        /// This mask is used to check whether one of the META meta keys is pressed.
        case metaOn = 65536
        /// This mask is used to check whether the right META meta key is pressed.
        case metaRightOn = 262144
        /// This mask is used to check whether the NUM LOCK meta key is on.
        case numLockOn = 2097152
        /// This mask is used to check whether the SCROLL LOCK meta key is on.
        case scrollLockOn = 4194304
        /// This mask is used to check whether the left SHIFT meta key is pressed.
        case shiftLeftOn = 64
        /// This mask is a combination of `META_SHIFT_ON`, `META_SHIFT_LEFT_ON` and `META_SHIFT_RIGHT_ON`.
        case shiftMask = 193
        /// This mask is used to check whether one of the SHIFT meta keys is pressed.
        case shiftOn = 1
        /// This mask is used to check whether the right SHIFT meta key is pressed.
        case shiftRightOn = 128
        /// This mask is used to check whether the SYM meta key is pressed.
        case symOn = 4
    }
}