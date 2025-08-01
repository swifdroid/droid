//
//  DroidApp+Instrumentation.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

extension DroidApp {
	/// Declares an Instrumentation class that enables you to monitor an application's interaction with the system.
	///
	/// The Instrumentation object is instantiated before any of the application's components.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element)
	public class Instrumentation: ManifestTag {
        override class var name: String { "instrumentation" }
        
		required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: -
		
		/// Whether or not the Instrumentation class should run as a functional test — "true" if it should, and "false" if not.
		///
		/// The default value is "false".
		public func functionalTest(_ value: Bool = true) -> Self {
			params[.androidFunctionalTest] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the Instrumentation class should run as a functional test — "true" if it should, and "false" if not.
		///
		/// The default value is "false".
		public static func functionalTest(_ value: Bool = true) -> Self {
			Self().functionalTest(value)
		}
		
		// MARK: -
		
		/// Whether or not the Instrumentation object will turn profiling on and off — "true" if it determines
		/// when profiling starts and stops, and "false" if profiling continues the entire time it is running.
		///
		/// A value of "true" enables the object to target profiling at a specific set of operations.
		///
		/// The default value is "false".
		public func handleProfiling(_ value: Bool = true) -> Self {
			params[.androidHandleProfiling] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the Instrumentation object will turn profiling on and off — "true" if it determines
		/// when profiling starts and stops, and "false" if profiling continues the entire time it is running.
		///
		/// A value of "true" enables the object to target profiling at a specific set of operations.
		///
		/// The default value is "false".
		public static func handleProfiling(_ value: Bool = true) -> Self {
			Self().handleProfiling(value)
		}
		
		// MARK: -
		
		/// An icon that represents the Instrumentation class.
		///
		/// This attribute must be set as a reference to a drawable resource.
		public func icon(_ value: String) -> Self { // TODO: drawable resourse
			params[.androidIcon] = value
			return self
		}
		
		/// An icon that represents the Instrumentation class.
		///
		/// This attribute must be set as a reference to a drawable resource.
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the Instrumentation class.
		///
		/// The label can be set as a raw string or a reference to a string resource.
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A user-readable label for the Instrumentation class.
		///
		/// The label can be set as a raw string or a reference to a string resource.
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// The name of the Instrumentation subclass.
		///
		/// This should be a fully qualified class name (such as, "com.example.project.StringInstrumentation").
		///
		/// However, as a shorthand, if the first character of the name is a period,
		/// it is appended to the package name specified in the `<manifest>` element.
		///
		/// There is no default. The name must be specified.
		public func name(_ value: String) -> Self {
			params[.androidName] = value
			return self
		}
		
		/// The name of the Instrumentation subclass.
		///
		/// This should be a fully qualified class name (such as, "com.example.project.StringInstrumentation").
		///
		/// However, as a shorthand, if the first character of the name is a period,
		/// it is appended to the package name specified in the `<manifest>` element.
		///
		/// There is no default. The name must be specified.
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// The application that the Instrumentation object will run against.
		///
		/// An application is identified by the package name assigned in its manifest file by the `<manifest>` element.
		public func targetPackage(_ value: String) -> Self {
			params[.androidTargetPackage] = value
			return self
		}
		
		/// The application that the Instrumentation object will run against.
		///
		/// An application is identified by the package name assigned in its manifest file by the `<manifest>` element.
		public static func targetPackage(_ value: String) -> Self {
			Self().targetPackage(value)
		}
		
		// MARK: -
		
		/// The processes that the Instrumentation object will run against.
		///
		/// A comma-separated list indicates that the instrumentation will run against those specific processes.
		///
		/// A value of `*` indicates that the instrumentation will run against all processes of the app defined in `android:targetPackage`.
		///
		/// If this value isn't provided in the manifest, the instrumentation
		/// will run only against the main process of the app defined in `android:targetPackage`.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#trgtproc)
		public func targetProcesses(_ value: String) -> Self {
			params[.androidTargetProcesses] = value
			return self
		}
		
		/// The processes that the Instrumentation object will run against.
		///
		/// A comma-separated list indicates that the instrumentation will run against those specific processes.
		///
		/// A value of `*` indicates that the instrumentation will run against all processes of the app defined in `android:targetPackage`.
		///
		/// If this value isn't provided in the manifest, the instrumentation
		/// will run only against the main process of the app defined in `android:targetPackage`.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/instrumentation-element#trgtproc)
		public static func targetProcesses(_ value: String) -> Self {
			Self().targetProcesses(value)
		}
	}
}
