#if canImport(Logging)
import Logging
#endif

extension View {
    func proceedSubviewLayoutParams(_ subview: View, _ params: [LayoutParamToApply]) {
        InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id))")
        guard
            let instance
        else {
            InnerLog.t("🟥 Unable to init `LayoutParams` in `proceedSubviewLayoutParams`")
            return
        }
        let type = LayoutParams.LinearLayoutType.fromClassName(instance.className)
        guard
            let lp = LayoutParams(type) else {
            return
        }
        InnerLog.t("🟠 LayoutParams: \(lp.className.path)")
        func void() {}
        if self is ConstraintLayout {

        } else {
            InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) not constraintlayout type: \(lp.className.path)")
            InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) params.count: \(params.count)")
            var marginLeft: Int32 = 0
            var marginTop: Int32 = 0
            var marginRight: Int32 = 0
            var marginBottom: Int32 = 0
            for param in params {
                // ViewGroup
                switch param {
                case .width(let value, let unit):
                    lp.setWidth(value.value < 0 ? value.value : unit.toPixels(value.value))
                case .height(let value, let unit):
                    lp.setHeight(value.value < 0 ? value.value : unit.toPixels(value.value))
                default: void()
                }
                // Margins
                switch param {
                case .leftMargin(let value, let unit):
                    marginLeft = unit.toPixels(Int32(value))
                case .topMargin(let value, let unit):
                    marginTop = unit.toPixels(Int32(value))
                case .rightMargin(let value, let unit):
                    marginRight = unit.toPixels(Int32(value))
                case .bottomMargin(let value, let unit):
                    marginBottom = unit.toPixels(Int32(value))
                case .startMargin(let value, let unit):
                    lp.setMarginStart(unit.toPixels(Int32(value)))
                case .endMargin(let value, let unit):
                    lp.setMarginEnd(unit.toPixels(Int32(value)))
                default: void()
                }
                switch type {
                    case .linearLayout:
                InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) switching type: \(lp.className.path)")
                        switch param {
                        case .weight(let value):
                            lp.setWeight(value)
                        case .minHeight://(let value, let unit):
                            void() // TODO
                        case .maxHeight://(let value, let unit):
                            void() // TODO
                        case .order://(let value):
                            void() // TODO: seems it is not present in LinearLayout?
                        case .gravity(let value):
                            lp.setGravity(Int32(value.rawValue))
                        default: void()
                        }
                    case .frameLayout:
                        switch param {
                        case .weight(let value):
                            lp.setWeight(value)
                        case .x(let value, let unit):
                            lp.setX(unit.toPixels(Int32(value)))
                        case .y(let value, let unit):
                            lp.setY(unit.toPixels(Int32(value)))
                        case .preventEdgeOffset://(let value):
                            void() // TODO
                        case .minHeight://(let value, let unit):
                            void() // TODO
                        case .maxHeight://(let value, let unit):
                            void() // TODO
                        case .minWidth://(let value, let unit):
                            void() // TODO
                        case .maxWidth://(let value, let unit):
                            void() // TODO
                        default: void()
                        }
                    case .absoluteLayout:
                        switch param {
                        case .x(let value, let unit):
                            lp.setX(unit.toPixels(Int32(value)))
                        case .y(let value, let unit):
                            lp.setY(unit.toPixels(Int32(value)))
                        case .minHeight://(let value, let unit):
                            void() // TODO
                        case .maxHeight://(let value, let unit):
                            void() // TODO
                        default: void()
                        }
                    case .relativeLayout:
                        switch param {
                        case .preventEdgeOffset://(let value):
                            void() // TODO
                        case .minHeight://(let value, let unit):
                            void() // TODO
                        case .maxHeight://(let value, let unit):
                            void() // TODO
                        case .gravity://(let value):
                            void() // TODO
                        case .alignParentTop:
                            void() // TODO
                        case .alignParentBottom:
                            void() // TODO
                        case .alignParentLeft:
                            void() // TODO
                        case .alignParentRight:
                            void() // TODO
                        case .alignParentStart:
                            void() // TODO
                        case .alignParentEnd:
                            void() // TODO
                        case .centerInParent:
                            void() // TODO
                        case .centerHorizontal:
                            void() // TODO
                        case .centerVertical:
                            void() // TODO
                        case .above://(let value):
                            void() // TODO
                        case .below://(let value):
                            void() // TODO
                        case .toLeftOf://(let value):
                            void() // TODO
                        case .toRightOf://(let value):
                            void() // TODO
                        case .toStartOf://(let value):
                            void() // TODO
                        case .toEndOf://(let value):
                            void() // TODO
                        case .alignTop://(let value):
                            void() // TODO
                        case .alignBottom://(let value):
                            void() // TODO
                        case .alignLeft://(let value):
                            void() // TODO
                        case .alignRight://(let value):
                            void() // TODO
                        case .alignStart://(let value):
                            void() // TODO
                        case .alignEnd://(let value):
                            void() // TODO
                        case .alignBaseline://(let value):
                            void() // TODO
                        default: break
                        }
                    default: void()
                }
            } // params loop end
            InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) subview margins l: \(subview.marginLeft) t: \(subview.marginTop) r: \(subview.marginRight) b: \(subview.marginBottom)")
            InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) new margins l: \(marginLeft) t: \(marginTop) r: \(marginRight) b: \(marginBottom)")
            InnerLog.t("💧 proceedSubviewLayoutParams (id: \(subview.id)) margins diff l: \(subview.marginLeft != marginLeft) t: \(subview.marginTop != marginTop) r: \(subview.marginRight != marginRight) b: \(subview.marginBottom != marginBottom)")
            if subview.marginLeft != marginLeft
                || subview.marginTop != marginTop
                || subview.marginRight != marginRight
                || subview.marginBottom != marginBottom {
                subview.marginLeft = marginLeft
                subview.marginTop = marginTop
                subview.marginRight = marginRight
                subview.marginBottom = marginBottom
                lp.setMargins(left: marginLeft, top: marginTop, right: marginRight, bottom: marginBottom)
            }
            subview.setLayoutParams(lp)
        }
    }
}