//
//  ApplicationUIOptions.swift
//  
//
//  Created by Mihael Isaev on 21.04.2022.
//

public enum ApplicationUIOptions: String {
	/// No extra UI options. This is the default.
	case `none`
	
	/// Add a bar at the bottom of the screen to display action items in the app bar (also known as the action bar),
	/// when constrained for horizontal space (such as when in portrait mode on a handset).
	///
	/// Instead of a small number of action items appearing in the app bar at the top of the screen,
	/// the app bar is split into the top navigation section and the bottom bar for action items.
	///
	/// This ensures a reasonable amount of space is made available not only for the action items,
	/// but also for navigation and title elements at the top.
	///
	/// Menu items are not split across the two bars; they always appear together.
	case splitActionBarWhenNarrow
}
