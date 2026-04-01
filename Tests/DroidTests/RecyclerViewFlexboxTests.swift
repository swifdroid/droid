import Testing
@testable import Droid

@Test("RecyclerView Flexbox properties use distinct Android setter keys")
func recyclerViewFlexboxPropertiesUseDistinctAndroidSetterKeys() {
    let wrap = FlexWrapLayoutManagerProperty(value: .wrap)
    let direction = FlexDirectionLayoutManagerProperty(value: .row)

    #expect(wrap.key.rawValue == "setFlexWrap")
    #expect(direction.key.rawValue == "setFlexDirection")
    #expect(wrap.key != direction.key)
}
