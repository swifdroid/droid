//
//  DispatchQueue+DetachedJavaContext.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 15.01.2022.
//

import Foundation

extension DispatchQueue {
    public static func asyncAfter(
        deadline: DispatchTime,
        in context: JavaContext,
        execute work: @escaping (DetachedJavaContext) -> Void
    ) {
        DispatchQueue(label: UUID().uuidString).asyncAfter(deadline: deadline) {
            let datachedContext = context.detach()
            defer {
                datachedContext.finalize()
            }
            work(datachedContext)
        }
    }
}
