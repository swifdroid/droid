import Testing
@testable import Droid

@MainActor
@Test("TableRow uses its own LayoutParams class")
func tableRowLayoutParamsClassIdentity() {
    let row = TableRow.layoutParamsClass.className.path
    let table = TableLayout.layoutParamsClass.className.path

    #expect(row == "android/widget/TableRow$LayoutParams")
    #expect(table == "android/widget/TableLayout$LayoutParams")
    #expect(row != table)
}

@MainActor
@Test("TableRow column and span modifiers queue TableRow fields")
func tableRowLayoutParamsModifiersQueueColumnAndSpan() {
    let cell = View(id: 1234)
        .column(1)
        .span(2)

    #expect(cell._layoutParamsToApply.map(\.key.rawValue) == ["column", "span"])
}
