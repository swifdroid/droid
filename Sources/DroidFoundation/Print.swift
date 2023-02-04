//
//  Print.swift
//  DroidFoundation
//
//  Created by Mihael Isaev on 20.07.2021.
//

import Foundation
import ndk.log

public enum PrintLevel {
    case info, verbose, debug, warn, error, fatal, silent
}

public func print(_ level: PrintLevel = .info, _ tag: String, _ items: Any...) {
    if items.count > 0 {
        print(level, tag, items: items)
    } else {
        print(level, "🛠SWIFT", items: [tag])
    }
}

public func print(_ level: PrintLevel = .info, _ tag: String, items: [Any]) {
    #if os(Android)
    _ = tag.withCString { tag -> Int32 in
        items.map { "\($0)" }.joined(separator: " ").withCString { text -> Int32 in
            switch level {
            case .info: return __android_log_print_info(tag, text)
            case .verbose: return __android_log_print_verbose(tag, text)
            case .debug: return __android_log_print_debug(tag, text)
            case .warn: return __android_log_print_warn(tag, text)
            case .error: return __android_log_print_error(tag, text)
            case .fatal: return __android_log_print_fatal(tag, text)
            case .silent: return __android_log_print_silent(tag, text)
            }
        }
    }
    #else
    print(items.map { "\($0)" }.joined(separator: " "))
    #endif
}
