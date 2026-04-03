import Testing
@testable import Droid

@MainActor
@Test("TableRow and TableLayout accept BodyBuilder content")
func tableContentInitializersAcceptBodyBuilder() {
    let row = TableRow {
        TextView("A")
        TextView("B")
    }
    let table = TableLayout {
        TableRow {
            TextView("Name")
        }
    }
    #expect(row.subviews.count == 2)
    #expect(table.subviews.count == 1)
}
