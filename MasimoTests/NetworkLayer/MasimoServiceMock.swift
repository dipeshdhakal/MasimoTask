//
//  MasimoServiceMock.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation
@testable import Masimo

final class MasimoServiceMock: Mockable, MasimoServiceable {
    
    
    var shouldFail: Bool
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func fetchDevices() async throws -> DeviceResponse {
        return try loadJSON(filename: shouldFail ? "test" : "devices_response", type: DeviceResponse.self)
    }
    
    func fetchNowPlaying() async throws -> NowPlayingResponse {
        return try loadJSON(filename: shouldFail ? "test" : "now_playing_response", type: NowPlayingResponse.self)
    }

}
