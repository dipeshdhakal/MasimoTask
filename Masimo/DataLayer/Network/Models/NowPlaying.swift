//
//  NowPlaying.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

// MARK: - NowPlayingResponse
struct NowPlayingResponse: Codable {
    let nowPlaying: [NowPlaying]

    enum CodingKeys: String, CodingKey {
        case nowPlaying = "Now Playing"
    }
}

// MARK: - NowPlaying
struct NowPlaying: Codable {
    let deviceID: Int
    let artworkSmall, artworkLarge: String
    let trackName, artistName: String

    enum CodingKeys: String, CodingKey {
        case deviceID = "Device ID"
        case artworkSmall = "Artwork Small"
        case artworkLarge = "Artwork Large"
        case trackName = "Track Name"
        case artistName = "Artist Name"
    }
}
