//
//  Application.swift
//  Manifest
//
//  Created by Mihael Isaev on 29.07.2021.
//

/// The declaration of the application.
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/application-element)
public class Application {
    public init () {}
    
    var allowTaskReparenting: Bool?
    
    /// Whether or not activities that the application defines can move from the task that started them
    /// to the task they have an affinity for when that task is next brought to the front — "true" if they can move,
    /// and "false" if they must remain with the task where they started. The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#reparent)
    @discardableResult
    public func allowTaskReparenting(_ value: Bool = true) -> Self {
        allowTaskReparenting = value
        return self
    }
    
    var allowBackup: Bool?
    
    /// Whether to allow the application to participate in the backup and restore infrastructure.
    /// If this attribute is set to false, no backup or restore of the application will ever be performed,
    /// even by a full-system backup that would otherwise cause all application data to be saved via adb.
    ///
    /// The default value of this attribute is true.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowbackup)
    @discardableResult
    public func allowBackup(_ value: Bool = true) -> Self {
        allowBackup = value
        return self
    }
    
    var allowClearUserData: Bool?
    
    /// Whether to allow the application to reset user data.
    /// This data includes flags—such as whether the user has seen introductory tooltips—as well as user-customizable settings and preferences.
    ///
    /// The default value of this attribute is true.
    ///
    /// [Learn more](___)
    @discardableResult
    public func allowClearUserData(_ value: Bool = true) -> Self {
        allowClearUserData = value
        return self
    }
    
    var allowNativeHeapPointerTagging: Bool?
    
    /// Whether or not the app has the Heap pointer tagging feature enabled.
    ///
    /// The default value of this attribute is true.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#allowNativeHeapPointerTagging)
    @discardableResult
    public func allowNativeHeapPointerTagging(_ value: Bool = true) -> Self {
        allowNativeHeapPointerTagging = value
        return self
    }
    
    var backupAgent: String?
    
    /// The name of the class that implements the application's backup agent, a subclass of BackupAgent.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#agent)
    @discardableResult
    public func backupAgent(_ value: String) -> Self {
        backupAgent = value
        return self
    }
    
    var backupInForeground: Bool?
    
    /// Indicates that Auto Backup operations may be performed on this app even if the app is in a foreground-equivalent state.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#backupInForeground)
    @discardableResult
    public func backupInForeground(_ value: Bool = true) -> Self {
        backupInForeground = value
        return self
    }
    
//    /// A drawable resource providing an extended graphical banner for its associated item.
//    ///
//    /// The system uses the banner to represent an app in the Android TV home screen.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#banner)
//    @discardableResult
//    public func banner(_ value: ___) -> Self { // "drawable resource"
//        banner = value
//        return self
//    }
    
    var debuggable: Bool?
    
    /// Whether or not the application can be debugged, even when running on a device in user mode — "true" if it can be, and "false" if not.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#debug)
    @discardableResult
    public func debuggable(_ value: Bool = true) -> Self {
        debuggable = value
        return self
    }
    
//    /// User-readable text about the application, longer and more descriptive than the application label.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#desc)
//    @discardableResult
//    public func description(_ value: ___) -> Self { // "string resource"
//        description = value
//        return self
//    }
    
    var enabled: Bool?
    
    /// Whether or not the Android system can instantiate components of the application — "true" if it can, and "false" if not.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#enabled)
    @discardableResult
    public func enabled(_ value: Bool = true) -> Self {
        enabled = value
        return self
    }
    
    var extractNativeLibs: Bool?
    
    /// Whether or not the package installer extracts native libraries from the APK to the filesystem.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#extractNativeLibs)
    @discardableResult
    public func extractNativeLibs(_ value: Bool = true) -> Self {
        extractNativeLibs = value
        return self
    }
    
    var fullBackupContent: String?
    
    /// This attribute points to an XML file that contains full backup rules for Auto Backup.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupContent)
    @discardableResult
    public func fullBackupContent(_ value: String) -> Self {
        fullBackupContent = value
        return self
    }
    
    var fullBackupOnly: Bool?
    
    /// This attribute indicates whether or not to use Auto Backup on devices where it is available.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fullBackupOnly)
    @discardableResult
    public func fullBackupOnly(_ value: Bool = true) -> Self {
        fullBackupOnly = value
        return self
    }
    
    public enum GWPAsanMode: String, Codable {
        case always, never
    }
    
    var gwpAsanMode: GWPAsanMode?
    
    /// This attribute indicates whether or not to use GWP-ASan, which is a native memory allocator feature
    /// that helps find use-after-free and heap-buffer-overflow bugs.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#gwpAsanMode)
    @discardableResult
    public func gwpAsanMode(_ value: GWPAsanMode) -> Self {
        gwpAsanMode = value
        return self
    }
    
    var hasCode: Bool?
    
    /// Whether or not the application contains any code — "true" if it does, and "false" if not.
    ///
    /// When the value is "false", the system does not try to load any application code when launching components.
    ///
    /// The default value is "true".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#code)
    @discardableResult
    public func hasCode(_ value: Bool = true) -> Self {
        hasCode = value
        return self
    }
    
    var hasFragileUserData: Bool?
    
    /// When the user uninstalls an app, whether or not to show the user a prompt to keep the app's data.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#fragileuserdata)
    @discardableResult
    public func hasFragileUserData(_ value: Bool = true) -> Self {
        hasFragileUserData = value
        return self
    }
    
    var hardwareAccelerated: Bool?
    
    /// Whether or not hardware-accelerated rendering should be enabled for all activities and views
    /// in this application — "true" if it should be enabled, and "false" if not.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#hwaccel)
    @discardableResult
    public func hardwareAccelerated(_ value: Bool = true) -> Self {
        hardwareAccelerated = value
        return self
    }
    
//    /// An icon for the application as whole, and the default icon for each of the application's components.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#icon)
//    @discardableResult
//    public func icon(_ value: ___) -> Self { // "drawable resource"
//        icon = value
//        return self
//    }
    
    var isGame: Bool?
    
    /// Whether or not the application is a game.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#isGame)
    @discardableResult
    public func isGame(_ value: Bool = true) -> Self {
        isGame = value
        return self
    }
    
    var killAfterRestore: Bool?
    
    /// Whether the application in question should be terminated after its settings have been restored during a full-system restore operation.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#killrst)
    @discardableResult
    public func killAfterRestore(_ value: Bool = true) -> Self {
        killAfterRestore = value
        return self
    }
    
    var largeHeap: Bool?
    
    /// Whether your application's processes should be created with a large Dalvik heap.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#largeHeap)
    @discardableResult
    public func largeHeap(_ value: Bool = true) -> Self {
        largeHeap = value
        return self
    }
    
//    /// A user-readable label for the application as a whole, and a default label for each of the application's components.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#label)
//    @discardableResult
//    public func label(_ value: ___) -> Self { // "string resource"
//        label = value
//        return self
//    }
    
//    /// A logo for the application as whole, and the default logo for activities.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#logo)
//    @discardableResult
//    public func logo(_ value: ___) -> Self { // "drawable resource"
//        logo = value
//        return self
//    }
    
    var manageSpaceActivity: String?
    
    /// The fully qualified name of an Activity subclass that the system can launch to let users manage the memory occupied by the application on the device.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#space)
    @discardableResult
    public func manageSpaceActivity(_ value: String) -> Self {
        manageSpaceActivity = value
        return self
    }
    
    var name: String?
    
    /// The fully qualified name of an Application subclass implemented for the application.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#nm)
    @discardableResult
    public func name(_ value: String) -> Self {
        name = value
        return self
    }
    
//    /// Specifies the name of the XML file that contains your application's Network Security Configuration.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#networkSecurityConfig)
//    @discardableResult
//    public func networkSecurityConfig(_ value: ___) -> Self { // "xml resource"
//        networkSecurityConfig = value
//        return self
//    }
    
    var permission: String?
    
    /// The name of a permission that clients must have in order to interact with the application.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#prmsn)
    @discardableResult
    public func permission(_ value: String) -> Self {
        permission = value
        return self
    }
    
    var persistent: Bool?
    
    /// Whether or not the application should remain running at all times — "true" if it should, and "false" if not.
    ///
    /// The default value is "false".
    ///
    /// Applications should not normally set this flag; persistence mode is intended only for certain system applications.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#persistent)
    @discardableResult
    public func persistent(_ value: Bool = true) -> Self {
        persistent = value
        return self
    }
    
    var process: String?
    
    /// The name of a process where all components of the application should run.
    /// Each component can override this default by setting its own process attribute.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#proc)
    @discardableResult
    public func process(_ value: String) -> Self {
        process = value
        return self
    }
    
    var restoreAnyVersion: Bool?
    
    /// Indicates that the application is prepared to attempt a restore of any backed-up data set,
    /// even if the backup was stored by a newer version of the application than is currently installed on the device.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restoreany)
    @discardableResult
    public func restoreAnyVersion(_ value: Bool = true) -> Self {
        restoreAnyVersion = value
        return self
    }
    
    var requestLegacyExternalStorage: Bool?
    
    /// Whether or not the application wants to opt out of scoped storage.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requestLegacyExternalStorage)
    @discardableResult
    public func requestLegacyExternalStorage(_ value: Bool = true) -> Self {
        requestLegacyExternalStorage = value
        return self
    }
    
    var requiredAccountType: String?
    
    /// Specifies the account type required by the application in order to function.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#requiredAccountType)
    @discardableResult
    public func requiredAccountType(_ value: String) -> Self {
        requiredAccountType = value
        return self
    }
    
    var resizeableActivity: Bool?
    
    /// Specifies whether the app supports multi-window display.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#resizeableActivity)
    @discardableResult
    public func resizeableActivity(_ value: Bool = true) -> Self {
        resizeableActivity = value
        return self
    }
    
    var restrictedAccountType: String?
    
    /// Specifies the account type required by this application and indicates that restricted profiles are allowed to access such accounts that belong to the owner user.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#restrictedAccountType)
    @discardableResult
    public func restrictedAccountType(_ value: String) -> Self {
        restrictedAccountType = value
        return self
    }
    
    var supportsRtl: Bool?
    
    /// Declares whether your application is willing to support right-to-left (RTL) layouts.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#supportsrtl)
    @discardableResult
    public func supportsRtl(_ value: Bool = true) -> Self {
        supportsRtl = value
        return self
    }
    
    var taskAffinity: String?
    
    /// An affinity name that applies to all activities within the application, except for those that set a different affinity with their own taskAffinity attributes.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#aff)
    @discardableResult
    public func taskAffinity(_ value: String) -> Self {
        taskAffinity = value
        return self
    }
    
    var testOnly: Bool?
    
    /// Indicates whether this application is only for testing purposes.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#testOnly)
    @discardableResult
    public func testOnly(_ value: Bool = true) -> Self {
        testOnly = value
        return self
    }
    
//    /// A reference to a style resource defining a default theme for all activities in the application.
//    ///
//    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#theme)
//    @discardableResult
//    public func theme(_ value: ___) -> Self { // "resource or theme"
//        theme = value
//        return self
//    }
    
    public enum UIOptions: String, Codable {
        case none, splitActionBarWhenNarrow
    }
    
    var uiOptions: UIOptions?
    
    /// Extra options for an activity's UI.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#uioptions)
    @discardableResult
    public func uiOptions(_ value: UIOptions) -> Self {
        uiOptions = value
        return self
    }
    
    var usesCleartextTraffic: Bool?
    
    /// Indicates whether the app intends to use cleartext network traffic, such as cleartext HTTP.
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#usesCleartextTraffic)
    @discardableResult
    public func usesCleartextTraffic(_ value: Bool = true) -> Self {
        usesCleartextTraffic = value
        return self
    }
    
    var vmSafeMode: Bool?
    
    /// Indicates whether the app would like the virtual machine (VM) to operate in safe mode.
    ///
    /// The default value is "false".
    ///
    /// [Learn more](https://developer.android.com/guide/topics/manifest/application-element#vmSafeMode)
    @discardableResult
    public func vmSafeMode(_ value: Bool = true) -> Self {
        vmSafeMode = value
        return self
    }
}
