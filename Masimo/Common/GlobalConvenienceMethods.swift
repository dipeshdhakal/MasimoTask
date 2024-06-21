//
//  GlobalConvenienceMethods.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

// Returns true if running in preview; false otherwise
public var isPreview: Bool {
    #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return true
        }
    #endif
    return false
}
