//
//  MasimoService.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

/// Abstract service layer
protocol MasimoServiceable {
    /// Fetches list of devices from API
    func fetchDevices() async throws -> DeviceResponse
    /// Fetches list of now playing from API
    func fetchNowPlaying() async throws -> NowPlayingResponse
}

// Concrete implementation of MasimoServiceable
struct MasimoService: HTTPClient, MasimoServiceable {
    
    func fetchDevices() async throws -> DeviceResponse {
        return try await sendRequest(endpoint: MasimoEndpoint.listDevices, responseModel: DeviceResponse.self)
    }
    
    func fetchNowPlaying() async throws -> NowPlayingResponse {
        return try await sendRequest(endpoint: MasimoEndpoint.listNowPlaying, responseModel: NowPlayingResponse.self)
    }
}
