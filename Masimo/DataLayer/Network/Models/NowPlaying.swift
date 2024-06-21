//
//  NowPlaying.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

// MARK: - NowPlayingResponse
public struct NowPlayingResponse: Codable {
    public let nowPlaying: [NowPlaying]

    enum CodingKeys: String, CodingKey {
        case nowPlaying = "Now Playing"
    }
}

// MARK: - NowPlaying
public struct NowPlaying: Codable {
    public let deviceID: Int
    public let artworkSmall, artworkLarge: String
    public let trackName, artistName: String

    enum CodingKeys: String, CodingKey {
        case deviceID = "Device ID"
        case artworkSmall = "Artwork Small"
        case artworkLarge = "Artwork Large"
        case trackName = "Track Name"
        case artistName = "Artist Name"
    }
}
