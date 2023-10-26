//
//  MasimoService.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

protocol MasimoServiceable {
    func fetchDevices() async throws -> DeviceResponse
    func fetchNowPlaying() async throws -> NowPlayingResponse
}

struct MasimoService: HTTPClient, MasimoServiceable {
    
    func fetchDevices() async throws -> DeviceResponse {
        return try await sendRequest(endpoint: MasimoEndpoint.listDevices, responseModel: DeviceResponse.self)
    }
    
    func fetchNowPlaying() async throws -> NowPlayingResponse {
        return try await sendRequest(endpoint: MasimoEndpoint.listDevices, responseModel: NowPlayingResponse.self)
    }
}
