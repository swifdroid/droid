//
//  ManifestFeature.swift
//  Droid
//
//  Created by Mihael Isaev on 13.09.2025.
//

/// [Learn more](https://developer.android.com/guide/topics/manifest/uses-feature-element)
public struct ManifestFeature: ExpressibleByStringLiteral, StringValuable, Sendable, CustomStringConvertible {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public var description: String { value }

    // MARK: - Hardware features

    // MARK: Audio hardware features

    /// The app uses the device's low-latency audio pipeline, which reduces lag and delays when processing sound input or output.
    public static let hardwareAudioLowLatency: ManifestFeature = "android.hardware.audio.low_latency"
    /// The app transmits sound using the device's speakers, audio jack, Bluetooth streaming capabilities, or a similar mechanism.
    public static let hardwareAudioOutput: ManifestFeature = "android.hardware.audio.output"
    /// The app uses the device's high-end audio functionality and performance capabilities.
    public static let hardwareAudioPro: ManifestFeature = "android.hardware.audio.pro"
    /// The app records audio using the device's microphone.
    public static let hardwareMicrophone: ManifestFeature = "android.hardware.microphone"

    // MARK: Bluetooth hardware features

    /// The app uses the device's Bluetooth features, usually to communicate with other Bluetooth-enabled devices.
    public static let hardwareBluetooth: ManifestFeature = "android.hardware.bluetooth"
    /// The app uses the device's Bluetooth Low Energy radio features.
    public static let hardwareBluetoothLe: ManifestFeature = "android.hardware.bluetooth_le"

    // MARK: Camera hardware features

    /// The app uses one of the device's cameras or an external camera connected to the device. Use this feature instead of android.hardware.camera or android.hardware.camera.front if your app doesn't require the camera to be back (world) facing or front (user) facing, respectively.
    ///
    /// The CAMERA permission implies that your app also uses android.hardware.camera. A back camera is a required feature unless android.hardware.camera is declared with android:required="false".
    public static let hardwareCameraAny: ManifestFeature = "android.hardware.camera.any"
    /// The app uses the device's back (world-facing) camera.
    public static let hardwareCamera: ManifestFeature = "android.hardware.camera"

    /// The app uses the device's front (user-facing) camera.
    ///
    /// The CAMERA permission implies that your app also uses android.hardware.camera. A back camera is a required feature unless android.hardware.camera is declared with android:required="false".
    public static let hardwareCameraFront: ManifestFeature = "android.hardware.camera.front"

    /// The app communicates with an external camera the user connects to the device. This feature doesn't guarantee that an external camera is available for your app to use.
    ///
    /// The CAMERA permission implies that your app also uses android.hardware.camera. A back camera is a required feature unless android.hardware.camera is declared with android:required="false".
    public static let hardwareCameraExternal: ManifestFeature = "android.hardware.camera.external"
    /// The app uses the autofocus feature supported by the device's camera.
    public static let hardwareCameraAutofocus: ManifestFeature = "android.hardware.camera.autofocus"
    /// The app uses the flash feature supported by the device's camera.
    public static let hardwareCameraFlash: ManifestFeature = "android.hardware.camera.flash"
    /// The app uses the MANUAL_POST_PROCESSING feature supported by the device's camera.
    /// 
    /// This feature lets your app override the camera's auto white balance functionality. Use android.colorCorrection.transform, android.colorCorrection.gains, and an android.colorCorrection.mode of TRANSFORM_MATRIX.
    public static let hardwareCameraManualPostProcessing: ManifestFeature = "android.hardware.camera.capability.manual_post_processing"
    /// The app uses the MANUAL_SENSOR feature supported by the device's camera.
    /// 
    /// This feature implies support for auto exposure locking (android.control.aeLock), which enables the camera's exposure time and sensitivity to remain fixed at specific values.
    public static let hardwareCameraManualSensor: ManifestFeature = "android.hardware.camera.capability.manual_sensor"
    /// The app uses the RAW feature supported by the device's camera.
    /// 
    /// This feature implies that the device can save DNG (raw) files. The device's camera provides the DNG-related metadata necessary for your app to process the raw images directly.
    public static let hardwareCameraRaw: ManifestFeature = "android.hardware.camera.capability.raw"
    /// The app uses the FULL level of image capture support provided by at least one of the device's cameras. FULL support includes burst-capture capabilities, per frame control, and manual post-processing control. See INFO_SUPPORTED_HARDWARE_LEVEL_FULL.
    public static let hardwareCameraLevelFull: ManifestFeature = "android.hardware.camera.level.full"

    // MARK: Device UI hardware features
    
    /// The app is designed to show its UI on a set of screens inside a vehicle. The user interacts with the app using hard buttons, touch, rotary controllers, and mouse-like interfaces. The vehicle's screens usually appear in the center console or the instrument cluster of a vehicle.
    public static let hardwareTypeAutomotive: ManifestFeature = "android.hardware.type.automotive"
    /// (Deprecated; use android.software.leanback instead.)
    /// 
    /// The app is designed to show its UI on a television. This feature defines "television" as a typical living-room television experience: the app displaying on a big screen, the user sitting far away, and the dominant form of input being something like a D-pad, rather than a mouse, pointer, or touch device.
    public static let hardwareTypeTelevision: ManifestFeature = "android.hardware.type.television"
    /// The app is designed to show its UI on a watch. A watch is worn on the body, such as on the wrist. The user is very close to the device while interacting with it.
    public static let hardwareTypeWatch: ManifestFeature = "android.hardware.type.watch"
    /// The app is designed to show its UI on Chromebooks. This feature disables input emulation for mouse and touchpad, since Chromebooks use mouse and touchpad hardware. See Mouse input.
    public static let hardwareTypePC: ManifestFeature = "android.hardware.type.pc"

    // MARK: Fingerprint hardware features

    /// The app reads fingerprints using the device's biometric hardware.
    public static let hardwareFingerprint: ManifestFeature = "android.hardware.fingerprint"

    // MARK: Gamepad hardware features 

    /// The app captures game controller input, either from the device itself or from a connected gamepad.
    public static let hardwareGamepad: ManifestFeature = "android.hardware.gamepad"
    
    // MARK: Infrared hardware features 

    /// The app uses the device's infrared (IR) capabilities, usually to communicate with other consumer IR devices.
    public static let hardwareConsumerIR: ManifestFeature = "android.hardware.consumerir"

    // MARK: Location hardware features 

    /// The app uses one or more features on the device for determining location, such as GPS location, network location, or cell location.
    public static let hardwareLocation: ManifestFeature = "android.hardware.location"
    /// The app uses precise location coordinates obtained from a Global Positioning System (GPS) receiver on the device.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.location feature, unless this parent feature is declared with the attribute android:required="false".
    public static let hardwareLocationGPS: ManifestFeature = "android.hardware.location.gps"
    /// The app uses coarse location coordinates obtained from a network-based geolocation system supported on the device.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.location feature, unless this parent feature is declared with the attribute android:required="false".
    public static let hardwareLocationNetwork: ManifestFeature = "android.hardware.location.network"

    // MARK: NFC hardware features 

    /// The app uses the device's Near-Field Communication (NFC) radio features.
    public static let hardwareNFC: ManifestFeature = "android.hardware.nfc"
    /// The app uses NFC card emulation that is hosted on the device.
    public static let hardwareNFCEmulation: ManifestFeature = "android.hardware.nfc.hce"

    // MARK: OpenGL ES hardware features

    /// The app uses the OpenGL ES Android Extension Pack that is installed on the device.
    public static let hardwareOpenGLES: ManifestFeature = "android.hardware.opengles.aep"

    // MARK: Sensor hardware features 

    /// The app uses motion readings from the device's accelerometer to detect the device's current orientation. For example, an app might use accelerometer readings to determine when to switch between portrait and landscape orientations.
    public static let hardwareSensorAccelerometer: ManifestFeature = "android.hardware.sensor.accelerometer"
    /// The app uses the device's ambient (environmental) temperature sensor. For example, a weather app can report indoor or outdoor temperature.
    public static let hardwareSensorAmbientTemperature: ManifestFeature = "android.hardware.sensor.ambient_temperature"
    /// The app uses the device's barometer. For example, a weather app might report air pressure.
    public static let hardwareSensorBarometer: ManifestFeature = "android.hardware.sensor.barometer"
    /// The app uses the device's magnetometer (compass). For example, a navigation app might show the current direction a user faces.
    public static let hardwareSensorCompass: ManifestFeature = "android.hardware.sensor.compass"
    /// The app uses the device's gyroscope to detect rotation and twist, creating a six-axis orientation system. By using this sensor, an app can detect more smoothly when it needs to switch between portrait and landscape orientations.
    public static let hardwareSensorGyroscope: ManifestFeature = "android.hardware.sensor.gyroscope"
    /// The app uses the device's high fidelity (Hi-Fi) sensors. For example, a gaming app might detect the user's high-precision movements.
    public static let hardwareSensorHiFi: ManifestFeature = "android.hardware.sensor.hifi_sensors"
    /// The app uses the device's heart rate monitor. For example, a fitness app might report trends in a user's heart rate over time.
    public static let hardwareSensorHeartRate: ManifestFeature = "android.hardware.sensor.heartrate"
    /// The app uses the device's electrocardiogram (ECG) heart rate sensor. For example, a fitness app might report more detailed information about a user's heart rate.
    public static let hardwareSensorHeartRateECG: ManifestFeature = "android.hardware.sensor.heartrate.ecg"
    /// The app uses the device's light sensor. For example, an app might display one of two color schemes based on the ambient lighting conditions.
    public static let hardwareSensorLight: ManifestFeature = "android.hardware.sensor.light"
    /// The app uses the device's proximity sensor. For example, a telephony app might turn off the device's screen when the app detects that the user is holding the device close to their body.
    public static let hardwareSensorProximity: ManifestFeature = "android.hardware.sensor.proximity"
    /// The app uses the device's relative humidity sensor. For example, a weather app might use the humidity to calculate and report the current dewpoint.
    public static let hardwareSensorRelativeHumidity: ManifestFeature = "android.hardware.sensor.relative_humidity"
    /// The app uses the device's step counter. For example, a fitness app might report the number of steps a user needs to take to achieve their daily step count goal.
    public static let hardwareSensorStepCounter: ManifestFeature = "android.hardware.sensor.stepcounter"
    /// The app uses the device's step detector. For example, a fitness app might use the time interval between steps to infer the type of exercise that the user is doing.
    public static let hardwareSensorStepDetector: ManifestFeature = "android.hardware.sensor.stepdetector"

    // MARK: Screen hardware features 

    /// The app requires the device to use the portrait or landscape orientation. If your app supports both orientations, then you don't need to declare either feature.
    public static let hardwareScreenLandscape: ManifestFeature = "android.hardware.screen.landscape"
    /// The app requires the device to use the portrait or landscape orientation. If your app supports both orientations, then you don't need to declare either feature.
    public static let hardwareScreenPortrait: ManifestFeature = "android.hardware.screen.portrait"

    // MARK: Telephony hardware features 

    /// The app uses the device's telephony features, such as telephony radio with data communication services.
    public static let hardwareTelephony: ManifestFeature = "android.hardware.telephony"
    /// The app uses the Code Division Multiple Access (CDMA) telephony radio system.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.telephony feature, unless this parent feature is declared with android:required="false".
    public static let hardwareTelephonyCDMA: ManifestFeature = "android.hardware.telephony.cdma"
    /// The app uses the Global System for Mobile Communications (GSM) telephony radio system.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.telephony feature, unless this parent feature is declared with android:required="false".
    public static let hardwareTelephonyGSM: ManifestFeature = "android.hardware.telephony.gsm"

    // MARK: Touchscreen hardware features 

    /// The app uses basic touch interaction events, such as tapping and dragging.
    /// 
    /// When declared as required, this feature indicates that the app is compatible with a device only if that device has an emulated "fake touch" touchscreen or has an actual touchscreen.
    /// 
    /// A device that offers a fake touch interface provides a user input system that emulates a subset of a touchscreen's capabilities. For example, a mouse or remote control might drive an on-screen cursor.
    /// 
    /// If your app requires basic point and click interaction and doesn't work with only a D-pad controller, declare this feature. Because this is the minimum level of touch interaction, you can also use an app that declares this feature on devices that offer more complex touch interfaces.
    public static let hardwareFaketouch: ManifestFeature = "android.hardware.faketouch"
    /// The app tracks two or more distinct "fingers" on a fake touch interface. This is a superset of the android.hardware.faketouch feature. When declared as required, this feature indicates that the app is compatible with a device only if that device emulates distinct tracking of two or more fingers or has an actual touchscreen.
    /// 
    /// Unlike the distinct multitouch defined by android.hardware.touchscreen.multitouch.distinct, input devices that support distinct multitouch with a fake touch interface don't support all two-finger gestures, because the input is transformed to cursor movement on the screen. That is, single-finger gestures on such a device move a cursor, two-finger swipes cause single-finger touch events to occur, and other two-finger gestures trigger the corresponding two-finger touch events.
    /// 
    /// A device that provides a two-finger touch trackpad for cursor movement can support this feature.
    public static let hardwareFaketouchMultitouchDistinct: ManifestFeature = "android.hardware.faketouch.multitouch.distinct"
    /// The app tracks five or more distinct "fingers" on a fake touch interface. This is a superset of the android.hardware.faketouch feature. When declared as required, this feature indicates that the app is compatible with a device only if that device emulates distinct tracking of five or more fingers or has an actual touchscreen.
    /// 
    /// Unlike the distinct multitouch defined by android.hardware.touchscreen.multitouch.jazzhand, input devices that support jazzhand multitouch with a fake touch interface don't support all five-finger gestures, because the input is transformed to cursor movement on the screen. That is, single-finger gestures on such a device move a cursor, multi-finger gestures cause single-finger touch events to occur, and other multi-finger gestures trigger the corresponding multi-finger touch events.
    /// 
    /// A device that provides a five-finger touch trackpad for cursor movement can support this feature.
    public static let hardwareFaketouchMultitouchJazzhand: ManifestFeature = "android.hardware.faketouch.multitouch.jazzhand"
    /// The app uses the device's touchscreen capabilities for gestures that are more interactive than basic touch events, such as a fling. This is a superset of the android.hardware.faketouch feature.
    /// 
    /// By default, all apps require this feature and therefore aren't available to devices that provide only an emulated "fake touch" interface. You can make your app available on devices that provide a fake touch interface, or even on devices that provide only a D-pad controller, by explicitly declaring that a touchscreen is not required using android.hardware.touchscreen with android:required="false". Add this declaration if your app uses, but doesn't require, a real touchscreen interface. All apps that don't explicitly require android.hardware.touchscreen also work on devices with android.hardware.faketouch.
    /// 
    /// If your app in fact requires a touch interface, such as to perform more advanced touch gestures like flings, then you don't need to declare any touch interface features, because they're required by default. However, it's best if you explicitly declare all features that your app uses.
    /// 
    /// If you require more complex touch interaction, such as multi-finger gestures, declare that your app uses advanced touchscreen features.
    public static let hardwareTouchscreen: ManifestFeature = "android.hardware.touchscreen"
    /// The app uses the device's basic two-point multitouch capabilities, such as for pinch gestures, but the app doesn't need to track touches independently. This is a superset of the android.hardware.touchscreen feature.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.touchscreen feature, unless this parent feature is declared with android:required="false".
    public static let hardwareTouchscreenMultitouch: ManifestFeature = "android.hardware.touchscreen.multitouch"
    /// The app uses the device's advanced multitouch capabilities for tracking two or more points independently. This feature is a superset of the android.hardware.touchscreen.multitouch feature.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.touchscreen.multitouch feature, unless this parent feature is declared with android:required="false".
    public static let hardwareTouchscreenMultitouchDistinct: ManifestFeature = "android.hardware.touchscreen.multitouch.distinct"
    /// The app uses the device's advanced multitouch capabilities for tracking five or more points independently. This feature is a superset of the android.hardware.touchscreen.multitouch feature.
    /// 
    /// By using this feature, an app implies that it also uses the android.hardware.touchscreen.multitouch feature, unless this parent feature is declared with android:required="false".
    public static let hardwareTouchscreenMultitouchJazzhand: ManifestFeature = "android.hardware.touchscreen.multitouch.jazzhand"

    // MARK: USB hardware features 

    /// The app behaves as a USB device and connects to USB hosts.
    public static let hardwareUsbAccessory: ManifestFeature = "android.hardware.usb.accessory"
    /// The app uses the USB accessories that are connected to the device. The device serves as the USB host.
    public static let hardwareUsbHost: ManifestFeature = "android.hardware.usb.host"

    // MARK: Vulkan hardware features 

    /// The app uses Vulkan compute features. This feature indicates that the app requires the hardware-accelerated Vulkan implementation. The feature version indicates which level of optional compute features the app requires beyond the Vulkan 1.0 requirements.
    public static let hardwareVulkanCompute: ManifestFeature = "android.hardware.vulkan.compute"
    /// The app uses Vulkan level features. This feature indicates that the app requires the hardware-accelerated Vulkan implementation. The feature version indicates which level of optional hardware features the app requires.
    public static let hardwareVulkanLevel: ManifestFeature = "android.hardware.vulkan.level"
    /// The app uses Vulkan. This feature indicates that the app requires the hardware-accelerated Vulkan implementation. The feature version indicates the minimum version of Vulkan API support the app requires.
    public static let hardwareVulkanVersion: ManifestFeature = "android.hardware.vulkan.version"

    // MARK: Wi-Fi hardware features 

    /// The app uses 802.11 networking (Wi-Fi) features on the device.
    public static let hardwareWifi: ManifestFeature = "android.hardware.wifi"
    /// The app uses the Wi-Fi Direct networking features on the device.
    public static let hardwareWifiDirect: ManifestFeature = "android.hardware.wifi.direct"

    // MARK: - Software features

    // MARK: Communication software features 

    /// The app uses Session Initiation Protocol (SIP) services. By using SIP, the app can support internet telephony operations, such as video conferencing and instant messaging.
    public static let hardwareSip: ManifestFeature = "android.software.sip"
    /// The app uses SIP-based Voice Over Internet Protocol (VoIP) services. By using VoIP, the app can support real-time internet telephony operations, such as two-way video conferencing.
    /// 
    /// By using this feature, an app implies that it also uses the android.software.sip feature, unless this parent feature is declared with android:required="false".
    public static let hardwareSipVoip: ManifestFeature = "android.software.sip.voip"
    /// The app displays content from the internet.
    public static let hardwareWebview: ManifestFeature = "android.software.webview"

    // MARK: Custom input software features 

    /// The app uses a new input method, which the developer defines in an InputMethodService.
    /// Device management software features 
    public static let hardwareInputMethods: ManifestFeature = "android.software.input_methods"
    /// The app includes logic to handle a backup and restore operation.
    public static let hardwareBackup: ManifestFeature = "android.software.backup"
    /// The app uses device administrators to enforce a device policy.
    public static let hardwareDeviceAdmin: ManifestFeature = "android.software.device_admin"
    /// The app supports secondary users and managed profiles.
    public static let hardwareManagedUsers: ManifestFeature = "android.software.managed_users"
    /// The app can permanently remove users and their associated data.
    public static let hardwareSecurelyRemovesUsers: ManifestFeature = "android.software.securely_removes_users"
    /// The app includes logic to handle results from the device's verified boot feature, which detects whether the device's configuration changes during a restart operation.
    public static let hardwareVerifiedBoot: ManifestFeature = "android.software.verified_boot"

    // MARK: Media software features 

    /// The app connects to musical instruments or outputs sound using the Musical Instrument Digital Interface (MIDI) protocol.
    public static let hardwareMidi: ManifestFeature = "android.software.midi"
    /// The app includes commands for printing documents displayed on the device.
    public static let hardwarePrint: ManifestFeature = "android.software.print"
    /// The app is designed to run on Android TV devices.
    public static let hardwareLeanback: ManifestFeature = "android.software.leanback"
    /// The app streams live television programs.
    public static let hardwareLiveTv: ManifestFeature = "android.software.live_tv"

    // MARK: Screen interface software features 

    /// The app uses or provides App Widgets and is intended only for devices that include a Home screen or similar location where users can embed App Widgets.
    public static let hardwareAppWidgets: ManifestFeature = "android.software.app_widgets"
    /// The app behaves as a replacement to the device's Home screen.
    public static let hardwareHomeScreen: ManifestFeature = "android.software.home_screen"
    /// The app uses or provides wallpapers that include animation.
    public static let hardwareLiveWallpaper: ManifestFeature = "android.software.live_wallpaper"
}