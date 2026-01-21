# Wrapped Classes

Working navigation index for wrapper classes with concrete implementation evidence.

## Role and maintenance

- This file routes discovery; concrete Swift source and the exact Android contract remain authoritative.
- An entry means the class has a meaningful wrapper surface, not that every upstream member is implemented.
- Do not add class-name-only stubs, empty shells, TODO-only files, or planned classes.
- Add/update/remove an entry in the same task that changes its class-level availability. Track missing methods as explicit source TODOs or approved tasks rather than claiming full SDK parity here.
- `.agent/architecture/ANDROID_WRAPPERS.md` owns the definition of implementation; `ANDROID_CLASS_WRAPPERS.md` owns detailed patterns.

## `android.widget`

- `android.widget.AbsSeekBar` -> `Sources/Droid/Packages/android/widget/AbsSeekBar.swift`
- `android.widget.AbsoluteLayout` -> `Sources/Droid/Packages/android/widget/AbsoluteLayout.swift`
- `android.widget.ActionMenuView` -> `Sources/Droid/Packages/android/widget/ActionMenuView.swift`
- `android.widget.AdapterViewFlipper` -> `Sources/Droid/Packages/android/widget/AdapterViewFlipper.swift`
- `android.widget.AutoCompleteTextView` -> `Sources/Droid/Packages/android/widget/AutoCompleteTextView.swift`
- `android.widget.Button` -> `Sources/Droid/Packages/android/widget/Button.swift`
- `android.widget.CalendarView` -> `Sources/Droid/Packages/android/widget/CalendarView.swift`
- `android.widget.CheckBox` -> `Sources/Droid/Packages/android/widget/CheckBox.swift`
- `android.widget.CheckedTextView` -> `Sources/Droid/Packages/android/widget/CheckedTextView.swift`
- `android.widget.Chronometer` -> `Sources/Droid/Packages/android/widget/Chronometer.swift`
- `android.widget.CompoundButton` -> `Sources/Droid/Packages/android/widget/CompoundButton.swift`
- `android.widget.DatePicker` -> `Sources/Droid/Packages/android/widget/DatePicker.swift`
- `android.widget.EditText` -> `Sources/Droid/Packages/android/widget/EditText.swift`
- `android.widget.ExpandableListView` -> `Sources/Droid/Packages/android/widget/ExpandableListView.swift`
- `android.widget.FrameLayout` -> `Sources/Droid/Packages/android/widget/FrameLayout.swift`
- `android.widget.Gallery` -> `Sources/Droid/Packages/android/widget/Gallery.swift`
- `android.widget.GridLayout` -> `Sources/Droid/Packages/android/widget/GridLayout.swift`
- `android.widget.GridView` -> `Sources/Droid/Packages/android/widget/GridView.swift`
- `android.widget.HorizontalScrollView` -> `Sources/Droid/Packages/android/widget/HorizontalScrollView.swift`
- `android.widget.ImageButton` -> `Sources/Droid/Packages/android/widget/ImageButton.swift`
- `android.widget.ImageSwitcher` -> `Sources/Droid/Packages/android/widget/ImageSwitcher.swift`
- `android.widget.ImageView` -> `Sources/Droid/Packages/android/widget/ImageView.swift`
- `android.widget.ListPopupWindow` -> `Sources/Droid/Packages/android/widget/ListPopupWindow.swift`
- `android.widget.ListView` -> `Sources/Droid/Packages/android/widget/ListView.swift`
- `android.widget.Magnifier` -> `Sources/Droid/Packages/android/widget/Magnifier.swift`
- `android.widget.MediaController` -> `Sources/Droid/Packages/android/widget/MediaController.swift`
- `android.widget.MultiAutoCompleteTextView` -> `Sources/Droid/Packages/android/widget/MultiAutoCompleteTextView.swift`
- `android.widget.NumberPicker` -> `Sources/Droid/Packages/android/widget/NumberPicker.swift`
- `android.widget.OverScroller` -> `Sources/Droid/Packages/android/widget/OverScroller.swift`
- `android.widget.PopupMenu` -> `Sources/Droid/Packages/android/widget/PopupMenu.swift`
- `android.widget.PopupWindow` -> `Sources/Droid/Packages/android/widget/PopupWindow.swift`
- `android.widget.ProgressBar` -> `Sources/Droid/Packages/android/widget/ProgressBar.swift`
- `android.widget.QuickContactBadge` -> `Sources/Droid/Packages/android/widget/QuickContactBadge.swift`
- `android.widget.RadioButton` -> `Sources/Droid/Packages/android/widget/RadioButton.swift`
- `android.widget.RadioGroup` -> `Sources/Droid/Packages/android/widget/RadioGroup.swift`
- `android.widget.RatingBar` -> `Sources/Droid/Packages/android/widget/RatingBar.swift`
- `android.widget.RemoteViews` -> `Sources/Droid/Packages/android/widget/RemoteViews.swift`
- `android.widget.RemoteViewsService` -> `Sources/Droid/Packages/android/widget/RemoteViewsService.swift`
- `android.widget.Scroller` -> `Sources/Droid/Packages/android/widget/Scroller.swift`
- `android.widget.ScrollView` -> `Sources/Droid/Packages/android/widget/ScrollView.swift`
- `android.widget.SearchView` -> `Sources/Droid/Packages/android/widget/SearchView.swift`
- `android.widget.SeekBar` -> `Sources/Droid/Packages/android/widget/SeekBar.swift`
- `android.widget.SlidingDrawer` -> `Sources/Droid/Packages/android/widget/SlidingDrawer.swift`
- `android.widget.Spinner` -> `Sources/Droid/Packages/android/widget/Spinner.swift`
- `android.widget.Switch` -> `Sources/Droid/Packages/android/widget/Switch.swift`
- `android.widget.TableLayout` -> `Sources/Droid/Packages/android/widget/TableLayout.swift`
- `android.widget.TableRow` -> `Sources/Droid/Packages/android/widget/TableRow.swift`
- `android.widget.TextClock` -> `Sources/Droid/Packages/android/widget/TextClock.swift`
- `android.widget.TextSwitcher` -> `Sources/Droid/Packages/android/widget/TextSwitcher.swift`
- `android.widget.TimePicker` -> `Sources/Droid/Packages/android/widget/TimePicker.swift`
- `android.widget.ToggleButton` -> `Sources/Droid/Packages/android/widget/ToggleButton.swift`
- `android.widget.Toolbar` -> `Sources/Droid/Packages/android/widget/Toolbar.swift` (`Toolbar1` wrapper type)
- `android.widget.TwoLineListItem` -> `Sources/Droid/Packages/android/widget/TwoLineListItem.swift`
- `android.widget.VideoView` -> `Sources/Droid/Packages/android/widget/VideoView.swift`
- `android.widget.ViewAnimator` -> `Sources/Droid/Packages/android/widget/ViewAnimator.swift`
- `android.widget.ViewFlipper` -> `Sources/Droid/Packages/android/widget/ViewFlipper.swift`
- `android.widget.ViewSwitcher` -> `Sources/Droid/Packages/android/widget/ViewSwitcher.swift`
- `android.widget.ZoomButton` -> `Sources/Droid/Packages/android/widget/ZoomButton.swift`
- `android.widget.ZoomControls` -> `Sources/Droid/Packages/android/widget/ZoomControls.swift`
