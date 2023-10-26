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

// Returns true if running unit test; false otherwise
public var isUnitTest: Bool {
    return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}

// Returns true if either preview or unit test
public var isPreviewOrUnitTest: Bool {
    return isPreview || isUnitTest
}

var isUITest: Bool {
    #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("IS_UI_TEST") {
            return true
        }
    #endif
    return false
}
