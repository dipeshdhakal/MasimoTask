//
//  DeviceData.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation

/// A model with all necessary fields for displaying data in UI.
class DeviceData: Identifiable {
    
    var id: Int {
        return deviceID
    }
    
    var deviceID: Int
    var deviceTitle: String
    var artwork: String
    var largeArtwork: String
    var trackTitle: String
    var artistTitle: String
    // true if item is selected in device list; Used to show different state in UI
    var isSelected: Bool
    // true if item is playing in now playing; Used for play / pause state in UI
    var isPlaying: Bool
    
    init(deviceID: Int, deviceTitle: String, artwork: String, largeArtwork: String, trackTitle: String, artistTitle: String, isSelected: Bool = false, isPlaying: Bool = false) {
        self.deviceID = deviceID
        self.deviceTitle = deviceTitle
        self.artwork = artwork
        self.largeArtwork = largeArtwork
        self.trackTitle = trackTitle
        self.artistTitle = artistTitle
        self.isSelected = isSelected
        self.isPlaying = isPlaying
    }
}

