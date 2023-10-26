//
//  DeviceData.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation

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
    var isSelected: Bool
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

