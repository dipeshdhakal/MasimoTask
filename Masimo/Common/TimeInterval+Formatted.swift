//
//  TimeInterval+Formatted.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation

extension TimeInterval {
    
    var toMMSS: String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds) // not considering hours
    }
}
