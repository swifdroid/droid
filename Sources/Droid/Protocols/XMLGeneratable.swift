//
//  XMLGeneratable.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

import FoundationEssentials

protocol XMLGeneratable {
	func generateXML(indentation: UInt) -> String
}

class Indentation: CustomStringConvertible {
	var value: UInt
	
	required init(_ value: UInt) {
		self.value = value
	}
	
	func tab() -> Self {
        return .init(value + 3)
	}
	
	var string: String {
		value == 0 ? "" : (0...value).map { _ in " " }.joined(separator: "")
	}
    
    var description: String { string }
}

func + (lhs: Indentation, rhs: String) -> String {
	lhs.string + rhs
}

protocol StringValuable {
	var value: String { get }
}

extension Array where Element == DroidApp.ManifestTag {
    func contains<T: DroidApp.ManifestTag>(_ tag: T.Type) -> Bool {
		contains(where: { $0.name == tag.name })
	}
}

struct ManifestTagParamName: ExpressibleByStringLiteral, Hashable, Equatable {
	let value: String
	
	init(stringLiteral value: StringLiteralType) {
		self.value = value
	}
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    static func == (lhs: ManifestTagParamName, rhs: ManifestTagParamName) -> Bool {
        lhs.value == rhs.value
    }
	
	static var xmlnsAndroid: Self { "xmlns:android" }
	static var package: Self { "package" }
	static var androidSharedUserId: Self { "android:sharedUserId" }
	static var androidSharedUserLabel: Self { "android:sharedUserLabel" }
	static var androidVersionCode: Self { "android:versionCode" }
	static var androidVersionName: Self { "android:versionName" }
	static var androidInstallLocation: Self { "android:installLocation" }
	static var androidScreenSize: Self { "android:screenSize" }
	static var androidScreenDensity: Self { "android:screenDensity" }
	static var androidDescription: Self { "android:description" }
	static var androidIcon: Self { "android:icon" }
	static var androidRoundIcon: Self { "android:roundIcon" }
	static var androidLabel: Self { "android:label" }
	static var androidName: Self { "android:name" }
	static var androidPermissionGroup: Self { "android:permissionGroup" }
	static var androidProtectionLevel: Self { "android:protectionLevel" }
	static var androidFunctionalTest: Self { "android:functionalTest" }
	static var androidHandleProfiling: Self { "android:handleProfiling" }
	static var androidTargetPackage: Self { "android:targetPackage" }
	static var androidTargetProcesses: Self { "android:targetProcesses" }
	static var androidTargetActivity: Self { "android:targetActivity" }
	static var androidAllowTaskReparenting: Self { "android:allowTaskReparenting" }
	static var androidAllowBackup: Self { "android:allowBackup" }
	static var androidAllowClearUserData: Self { "android:allowClearUserData" }
	static var androidAllowNativeHeapPointerTagging: Self { "android:allowNativeHeapPointerTagging" }
	static var androidBackupAgent: Self { "android:backupAgent" }
	static var androidBackupInForeground: Self { "android:backupInForeground" }
	static var androidBanner: Self { "android:banner" }
	static var androidDataExtractionRules: Self { "android:dataExtractionRules" }
	static var androidDebuggable: Self { "android:debuggable" }
	static var androidEnabled: Self { "android:enabled" }
	static var androidExtractNativeLibs: Self { "android:extractNativeLibs" }
	static var androidFullBackupContent: Self { "android:fullBackupContent" }
	static var androidFullBackupOnly: Self { "android:fullBackupOnly" }
	static var androidGWPAsanMode: Self { "android:gwpAsanMode" }
	static var androidHasCode: Self { "android:hasCode" }
	static var androidHasFragileUserData: Self { "android:hasFragileUserData" }
	static var androidHardwareAccelerated: Self { "android:hardwareAccelerated" }
	static var androidKillAfterRestore: Self { "android:killAfterRestore" }
	static var androidLargeHeap: Self { "android:largeHeap" }
	static var androidLogo: Self { "android:logo" }
	static var androidManageSpaceActivity: Self { "android:manageSpaceActivity" }
	static var androidNetworkSecurityConfig: Self { "android:networkSecurityConfig" }
	static var androidPermission: Self { "android:permission" }
	static var androidPersistent: Self { "android:persistent" }
	static var androidProcess: Self { "android:process" }
	static var androidRestoreAnyVersion: Self { "android:restoreAnyVersion" }
	static var androidRequestLegacyExternalStorage: Self { "android:requestLegacyExternalStorage" }
	static var androidRequiredAccountType: Self { "android:requiredAccountType" }
	static var androidResizeableActivity: Self { "android:resizeableActivity" }
	static var androidRestrictedAccountType: Self { "android:restrictedAccountType" }
	static var androidSupportsRTL: Self { "android:supportsRtl" }
	static var androidTaskAffinity: Self { "android:taskAffinity" }
	static var androidTestOnly: Self { "android:testOnly" }
	static var androidTheme: Self { "android:theme" }
	static var androidUIOptions: Self { "android:uiOptions" }
	static var androidUsesCleartextTraffic: Self { "android:usesCleartextTraffic" }
	static var androidVMSafeMode: Self { "android:vmSafeMode" }
	static var androidMimeType: Self { "android:mimeType" }
	static var androidHost: Self { "android:host" }
	static var androidPort: Self { "android:port" }
	static var androidPath: Self { "android:path" }
	static var androidPathPattern: Self { "android:pathPattern" }
	static var androidPathPrefix: Self { "android:pathPrefix" }
	static var androidAuthorities: Self { "android:authorities" }
	static var androidDirectBootAware: Self { "android:directBootAware" }
	static var androidExported: Self { "android:exported" }
	static var androidGrantUriPermissions: Self { "android:grantUriPermissions" }
	static var androidInitOrder: Self { "android:initOrder" }
	static var androidMultiprocess: Self { "android:multiprocess" }
	static var androidReadPermission: Self { "android:readPermission" }
	static var androidSyncable: Self { "android:syncable" }
	static var androidWritePermission: Self { "android:writePermission" }
	static var androidPriority: Self { "android:priority" }
	static var androidOrder: Self { "android:order" }
	static var androidAutoVerify: Self { "android:autoVerify" }
	static var androidResource: Self { "android:resource" }
	static var androidValue: Self { "android:value" }
	static var androidScheme: Self { "android:scheme" }
	static var androidAllowEmbedded: Self { "android:allowEmbedded" }
	static var androidAlwaysRetainTaskState: Self { "android:alwaysRetainTaskState" }
	static var androidAutoRemoveFromRecents: Self { "android:autoRemoveFromRecents" }
	static var androidClearTaskOnLaunch: Self { "android:clearTaskOnLaunch" }
	static var androidColorMode: Self { "android:colorMode" }
	static var androidConfigChanges: Self { "android:configChanges" }
	static var androidDocumentLaunchMode: Self { "android:documentLaunchMode" }
	static var androidExcludeFromRecents: Self { "android:excludeFromRecents" }
	static var androidFinishOnTaskLaunch: Self { "android:finishOnTaskLaunch" }
	static var androidImmersive: Self { "android:immersive" }
	static var androidLaunchMode: Self { "android:launchMode" }
	static var androidLockTaskMode: Self { "android:lockTaskMode" }
	static var androidMaxRecents: Self { "android:maxRecents" }
	static var androidMaxAspectRatio: Self { "android:maxAspectRatio" }
	static var androidNoHistory: Self { "android:noHistory" }
	static var androidParentActivityName: Self { "android:parentActivityName" }
	static var androidPersistableMode: Self { "android:persistableMode" }
	static var androidRelinquishTaskIdentity: Self { "android:relinquishTaskIdentity" }
	static var androidScreenOrientation: Self { "android:screenOrientation" }
	static var androidShowForAllUsers: Self { "android:showForAllUsers" }
	static var androidStateNotNeeded: Self { "android:stateNotNeeded" }
	static var androidSupportsPictureInPicture: Self { "android:supportsPictureInPicture" }
	static var androidWindowSoftInputMode: Self { "android:windowSoftInputMode" }
}

struct ManifestTagParamValue {
    let value: String
	
	init (_ value: String) {
		self.value = value
	}
	
	init (_ value: Bool) {
		self.value = value ? "true" : "false"
	}
	
	init (_ value: Int) {
		self.value = "\(value)"
	}
	
	init (_ value: Double) {
		self.value = "\(value)"
	}
	
	init (values: [String]) {
		self.value = values.joined(separator: "|")
	}
	
	init <R>(_ value: R) where R: RawRepresentable, R.RawValue == String {
		self.value = value.rawValue
	}
	
	init <R>(values: [R]) where R: RawRepresentable, R.RawValue == String {
		self.value = values.map { $0.rawValue }.joined(separator: "|")
	}
	
	init <S>(_ value: S) where S: StringValuable {
		self.value = value.value
	}
	
	init <S>(values: [S]) where S: StringValuable {
		self.value = values.map { $0.value }.joined(separator: "|")
	}
}

extension DroidApp {
    public class ManifestTag: XMLGeneratable, Hashable, Equatable {
        class var name: String { "" }
        
        var order: Int { 10 }
        
        var params: [ManifestTagParamName: String] = [:]
        var items: [ManifestTag] = []
        
        func uniqueParams() -> [ManifestTagParamName] { [] }
        func missingParams() -> [String] { [] }
        func missingItems() -> [String] { [] }
        
        func merge(with tag: ManifestTag) {
            for (key, value) in tag.params {
                params[key] = value
            }
            for tagItem in tag.items {
                if let foundItem = items.first(where: { $0 == tagItem }) {
                    foundItem.merge(with: tagItem)
                } else {
                    items.append(tagItem)
                }
            }
        }
        
        public static func == (lhs: DroidApp.ManifestTag, rhs: DroidApp.ManifestTag) -> Bool {
            return lhs.name == rhs.name
                && lhs.uniqueParams().compactMap { lhs.params[$0] }.joined() == rhs.uniqueParams().compactMap { rhs.params[$0] }.joined()
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            for key in uniqueParams() {
                if let v = params[key] {
                    hasher.combine(v)
                }
            }
        }
    }
}

extension DroidApp.ManifestTag {
	var name: String { Self.name }
	
	@discardableResult
	func param(_ name: ManifestTagParamName, _ value: String) -> Self {
		params[name] = value
		return self
	}
	
	@discardableResult
    func item(_ handler: () -> DroidApp.ManifestTag) -> Self {
		items.append(handler())
		return self
	}
	
	func generateXML(indentation: UInt = 0) -> String {
		let indentation = Indentation(indentation)
        var lines: [String] = []
        if indentation.value == 0 {
            lines.append(##"<?xml version="1.0" encoding="utf-8"?>"##)
            lines.append(indentation + "<!--managed by SwifDroid-->")
        }
        lines.append(indentation + "<\(Self.name)" + (params.count == 0 ? ">" : ""))
		if params.count > 0 {
			params.enumerated().forEach { offset, element in
				let result = "\(element.key.value)=\"\(element.value)\""
                if offset == params.count - 1 {
                    lines.append(indentation.tab().string + result + (items.count > 0 ? ">" : " />"))
				} else {
					lines.append(indentation.tab().string + result)
				}
			}
		}
        items.sorted(by: { $0.order < $1.order }).forEach {
			lines.append($0.generateXML(indentation: indentation.tab().value))
		}
        if items.count > 0 {
            lines.append(indentation + "</\(Self.name)>")
        }
		return lines.joined(separator: "\n")
	}
}
