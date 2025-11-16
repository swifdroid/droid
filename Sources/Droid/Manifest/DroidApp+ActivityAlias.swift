//
//  DroidApp+ActivityAlias.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// An alias for an activity, named by the targetActivity attribute.
	///
	/// The target must be in the same application as the alias and it must be declared before the alias in the manifest.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element)
	public class ActivityAlias: ManifestTag {
        override class var name: String { "activity-alias" }
		
        required override init() {
            super.init()
        }
        
        override func uniqueParams() -> [ManifestTagParamName] {
            [.androidName]
        }
		
		// MARK: -
		
		/// Whether or not the target activity can be instantiated by
		/// the system through this alias — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#enabled)
		public func enabled(_ value: Bool = true) -> Self {
			params[.androidEnabled] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not the target activity can be instantiated by
		/// the system through this alias — "true" if it can be, and "false" if not.
		///
		/// The default value is "true".
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#enabled)
		public static func enabled(_ value: Bool = true) -> Self {
			Self().enabled(value)
		}
		
		// MARK: -
		
		/// Whether or not components of other applications can launch
		/// the target activity through this alias — "true" if they can, and
		/// "false" if not. If "false", the target activity can be launched
		/// through the alias only by components of the same application
		/// as the alias or applications with the same user ID.
		///
		/// The default value depends on whether the alias contains intent filters.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#exported)
		public func exported(_ value: Bool = true) -> Self {
			params[.androidExported] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether or not components of other applications can launch
		/// the target activity through this alias — "true" if they can, and
		/// "false" if not. If "false", the target activity can be launched
		/// through the alias only by components of the same application
		/// as the alias or applications with the same user ID.
		///
		/// The default value depends on whether the alias contains intent filters.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#exported)
		public static func exported(_ value: Bool = true) -> Self {
			Self().exported(value)
		}
		
		// MARK: -
		
		/// An icon for the target activity when presented to users through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// An icon for the target activity when presented to users through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the alias when presented to users through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#label)
		public func label(_ value: String) -> Self { // string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A user-readable label for the alias when presented to users through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// A unique name for the alias.
		///
		/// The name should resemble a fully qualified class name.
		/// But, unlike the name of the target activity, the alias name is arbitrary; it does not refer to an actual class.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#nm)
		public func name(_ value: String) -> Self {
			params[.androidName] = value
			return self
		}
		
		/// A unique name for the alias.
		///
		/// The name should resemble a fully qualified class name.
		/// But, unlike the name of the target activity, the alias name is arbitrary; it does not refer to an actual class.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#nm)
		public static func name(_ value: String) -> Self {
			Self().name(value)
		}
		
		// MARK: -
		
		/// The name of a permission that clients must have to launch
		/// the target activity or get it to do something via the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#prmsn)
		public func permission(_ value: ManifestPermission) -> Self {
			params[.androidPermission] = value.value
			return self
		}
		
		/// The name of a permission that clients must have to launch
		/// the target activity or get it to do something via the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#prmsn)
		public static func permission(_ value: ManifestPermission) -> Self {
			Self().permission(value)
		}
		
		// MARK: -
		
		/// The name of the activity that can be activated through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#trgt)
		public func targetActivity(_ value: AnyActivity.Type) -> Self {
			params[.androidTargetActivity] = ".\(value.className)"
			return self
		}
		
		/// The name of the activity that can be activated through the alias.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/activity-alias-element#trgt)
		public static func targetActivity(_ value: AnyActivity.Type) -> Self {
			Self().targetActivity(value)
		}
		
		// MARK: -
		
		/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
		public func intentFilter(_ handler: () -> DroidApp.IntentFilter) -> Self {
			items.append(handler())
			return self
		}
		
		/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
		public static func intentFilter(_ handler: @escaping () -> DroidApp.IntentFilter) -> Self {
			Self().intentFilter(handler)
		}
		
		// MARK: -
		
		/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
		public func metaData(_ handler: () -> DroidApp.MetaData) -> Self {
			items.append(handler())
			return self
		}
		
		/// A name-value pair for an item of additional, arbitrary data that can be supplied to the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/meta-data-element)
		public static func metaData(_ handler: @escaping () -> DroidApp.MetaData) -> Self {
			Self().metaData(handler)
		}
	}
}

