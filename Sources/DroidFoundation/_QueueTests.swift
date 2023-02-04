//
//  QueueTests.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 13.01.2022.
//

import Foundation

//DispatchQueue(label: "myqueue1").asyncAfter(deadline: .now() + 3) {
//    let datachedContext = context.detach()
//    defer { datachedContext.finalize() }
//    guard let `class` = try? datachedContext.toClass() else { return }
//    `class`.callMethod("callback", 333)
////        print(.debug, "😎😎: \(ll)")
//}
//    let queue2 = DispatchQueue(label: "myqueue2")
//    queue2.asyncAfter(deadline: .now() + 4) {
//        let datachedContext = context.detach()
//        defer { datachedContext.finalize() }
//        guard let `class` = try? datachedContext.toClass() else { return }
//        `class`.callMethod("callback", 444)
//    }
//    queue2.asyncAfter(deadline: .now() + 5) {
//        let datachedContext = context.detach()
//        defer { datachedContext.finalize() }
//        guard let `class` = try? datachedContext.toClass() else { return }
//        `class`.callMethod("callback", 556)
//    }
//print(.info, "MYAPP", "DispatchQueue.main: \(DispatchQueue.main)")
//DispatchQueue.global()//(label: "myqueue2")
////        .asyncAfter(deadline: .now() + 3) {
//    .async {
//        let datachedContext = context.detach()
//        defer { datachedContext.finalize() }
//        guard let `class` = datachedContext.toClass() else { return }
//        `class`.callMethod("callback", 111)
//        `class`.callMethod("trololo")
//}
