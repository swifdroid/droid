//
//  DroidApp+IntentFilter.swift
//
//
//  Created by Mihael Isaev on 23.04.2022.
//

extension DroidApp {
	/// Specifies the types of intents that an activity, service, or broadcast receiver can respond to.
	///
	/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element)
	public class IntentFilter: ManifestTag {
        override class var name: String { "intent-filter" }
		
		public static var mainLauncher: IntentFilter { .init().action(.main).category(.launcher) }

		public required override init() {
            super.init()
        }
		
		// MARK: -
		
		/// An icon that represents the parent activity, service, or broadcast receiver
		/// when that component is presented to the user as having the capability described by the filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#icon)
		public func icon(_ value: String) -> Self { // TODO: drawable resource
			params[.androidIcon] = value
			return self
		}
		
		/// An icon that represents the parent activity, service, or broadcast receiver
		/// when that component is presented to the user as having the capability described by the filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#icon)
		public static func icon(_ value: String) -> Self {
			Self().icon(value)
		}
		
		// MARK: -
		
		/// A user-readable label for the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#label)
		public func label(_ value: String) -> Self { // TODO: string or string resource
			params[.androidLabel] = value
			return self
		}
		
		/// A user-readable label for the parent component.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#label)
		public static func label(_ value: String) -> Self {
			Self().label(value)
		}
		
		// MARK: -
		
		/// The priority that should be given to the parent component
		/// with regard to handling intents of the type described by the filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#priority)
		public func priority(_ value: Int) -> Self {
			params[.androidPriority] = ManifestTagParamValue(value).value
			return self
		}
		
		/// The priority that should be given to the parent component
		/// with regard to handling intents of the type described by the filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#priority)
		public static func priority(_ value: Int) -> Self {
			Self().priority(value)
		}
		
		// MARK: -
		
		/// The order in which the filter should be processed when multiple filters match.
		///
		/// `order` differs from `priority` in that `priority` applies across apps,
		/// while `order` disambiguates multiple matching filters in a single app.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#order)
		public func order(_ value: Int) -> Self {
			params[.androidOrder] = ManifestTagParamValue(value).value
			return self
		}
		
		/// The order in which the filter should be processed when multiple filters match.
		///
		/// `order` differs from `priority` in that `priority` applies across apps,
		/// while `order` disambiguates multiple matching filters in a single app.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/intent-filter-element#order)
		public static func order(_ value: Int) -> Self {
			Self().order(value)
		}
		
		// MARK: -
		
		/// Whether Android should verify that the Digital Asset Links JSON file
		/// from the specified host matches this application.
		///
		/// The default value is false.
		///
		/// [Learn more](https://developer.android.com/training/app-links/verify-site-associations)
		public func autoVerify(_ value: Bool = true) -> Self {
			params[.androidAutoVerify] = ManifestTagParamValue(value).value
			return self
		}
		
		/// Whether Android should verify that the Digital Asset Links JSON file
		/// from the specified host matches this application.
		///
		/// The default value is false.
		///
		/// [Learn more](https://developer.android.com/training/app-links/verify-site-associations)
		public static func autoVerify(_ value: Bool = true) -> Self {
			Self().autoVerify(value)
		}
		
		// MARK: -
		
		/// Adds an action to an intent filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/action-element)
		public func action(_ type: IntentActionType) -> Self {
			items.append(Action(type))
			return self
		}
		
		/// Adds an action to an intent filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/action-element)
		public static func action(_ type: IntentActionType) -> Self {
			Self().action(type)
		}
		
		// MARK: -
		
		/// Adds a category name to an intent filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/category-element)
		public func category(_ type: IntentCategoryType) -> Self {
			items.append(Category(type))
			return self
		}
		
		/// Adds a category name to an intent filter.
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/category-element)
		public static func category(_ type: IntentCategoryType) -> Self {
			Self().category(type)
		}
		
		// MARK: -
		
		/// Adds a data specification to an intent filter.
		///
		/// The specification can be just a data type (the mimeType attribute),
		/// just a URI, or both a data type and a URI.
		/// A URI is specified by separate attributes for each of its parts:
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element)
		public func data(_ handler: () -> Data) -> Self {
			items.append(handler())
			return self
		}
		
		/// Adds a data specification to an intent filter.
		///
		/// The specification can be just a data type (the mimeType attribute),
		/// just a URI, or both a data type and a URI.
		/// A URI is specified by separate attributes for each of its parts:
		///
		/// [Learn more](https://developer.android.com/guide/topics/manifest/data-element)
		public static func data(_ handler: @escaping () -> Data) -> Self {
			Self().data(handler)
		}
	}
}

