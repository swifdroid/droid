//
//  InstallLocation.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

/// Install location for the app
///
/// [Learn more](https://developer.android.com/guide/topics/manifest/manifest-element#install)
public enum InstallLocation: String {
	/// The app must be installed on the internal device storage only.
	///
	/// If this is set, the app will never be installed on the external storage.
	/// If the internal storage is full, then the system will not install the app.
	///
	/// This is also the default behavior if you do not define android:installLocation.
	case internalOnly
	
	/// The app may be installed on the external storage,
	/// but the system will install the app on the internal storage by default.
	///
	/// If the internal storage is full, then the system will install it on the external storage.
	/// Once installed, the user can move the app to either internal or external storage through the system settings.
	case auto
	
	/// The app prefers to be installed on the external storage (SD card).
	/// There is no guarantee that the system will honor this request.
	///
	/// The app might be installed on internal storage if the external media is unavailable or full.
	/// Once installed, the user can move the app to either internal or external storage through the system settings.
	case preferExternal
}
